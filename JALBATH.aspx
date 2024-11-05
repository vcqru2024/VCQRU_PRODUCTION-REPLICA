<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JALBATH.aspx.cs" Inherits="JALBATH" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>



    <script>

        window.onload = function () {
            var input = document.getElementById("frmlink").focus();
        }

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }



        $(document).ready(function () {
            $('.customer-logos').slick({
                slidesToShow: 6,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 1500,
                arrows: false,
                dots: false,
                pauseOnHover: false,
                responsive: [{
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 4
                    }
                }, {
                    breakpoint: 520,
                    settings: {
                        slidesToShow: 3
                    }
                }]
            });

            firstfunction();

            var id = $('#HdnID').val();


            if (id == "1") {

                $('#div1').show();
                $('#div2').hide();
                $('#div3').hide();
            }

            else if (id == "JALBATH") {
                $('#div1').hide();
                $('#div2').show();
                $('#div3').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);


            }



            $("#codeone").mask("99999-99999999");

            $(".input1").keyup(function () {

                if (this.value.length == this.maxLength) {
                    $('#div1').hide();

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
                                        $('#div2').show();
                                        $('#div3').show();

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


                var State = $('#ddlstate').val();
                if (State != undefined) {


                    if ($('#ddlstate').val().length < 1) {
                        toastr.error('Please select State');
                        validate = false;
                    }
                }



            //    var State = $("#ddlstate");
            //    if (State.val() == "") {
            //        alert("Please select State!");
            //        return false;
            //    }
            //    return true;
            //});




            if (validate) {
                $('#p3msg').html('');


                if (code != "") {
                    $.ajax({
                        type: "POST",
                        async: true,
                        contentType: false,
                        processData: false,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&City=' + $('#Address').val() + '&state=' + $('#ddlstate option:selected').text() + '&name=' + $('#Name').val() + '&comp=' + $('#CompName').val(),
                            success: function (data) {
                                debugger;
                                if (data.split('~')[0] !== "failure") {
                                    if (data.indexOf("not valid") !== -1) {
                                        data = data.split(".")[0];
                                    }

                                    window.scrollTo(0, 0);
                                    $('#head').hide();
                                    $('#div2').hide();
                                    $('#div3').hide();
                                    $('#mainform').hide();
                                    $('#ShowMessage').show();
                                    $('#chkLine').hide();
                                    $('#p3msg').html(data.split('~')[1]);
                                    $('.product_img').attr("style", "margin-top : 0px !important");

                                    var input = document.getElementById("ShowMessage").focus();

                                    //$('#p3msg:contains("not")').css('color', 'white');





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
            window.location.href = 'https://jaljoy.com/';
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

    </script>




    <script>

        var alertRedInput = "#8C1010";
        var defaultInput = "rgba(10, 180, 180, 1)";

        function userNameValidation(usernameInput) {
            var username = document.getElementById("username");
            var issueArr = [];
            if (/[-!@#$%^&*()_+|~=`{}\[\]:";'<>?,.\/]/.test(usernameInput)) {
                issueArr.push("No special characters!");
            }
            if (issueArr.length > 0) {
                username.setCustomValidity(issueArr);
                username.style.borderColor = alertRedInput;
            } else {
                username.setCustomValidity("");
                username.style.borderColor = defaultInput;
            }
        }

        function passwordValidation(passwordInput) {
            var password = document.getElementById("password");
            var issueArr = [];
            if (!/^.{7,15}$/.test(passwordInput)) {
                issueArr.push("Password must be between 7-15 characters.");
            }
            if (!/\d/.test(passwordInput)) {
                issueArr.push("Must contain at least one number.");
            }
            if (!/[a-z]/.test(passwordInput)) {
                issueArr.push("Must contain a lowercase letter.");
            }
            if (!/[A-Z]/.test(passwordInput)) {
                issueArr.push("Must contain an uppercase letter.");
            }
            if (issueArr.length > 0) {
                password.setCustomValidity(issueArr.join("\n"));
                password.style.borderColor = alertRedInput;
            } else {
                password.setCustomValidity("");
                password.style.borderColor = defaultInput;
            }
        }




    </script>

    <title>Jaljoy</title>

    <style>
        * {
            padding: 0px;
            margin: 0px;
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }

        .container-box {
            width: 80%;
            margin: auto;
        }

        .jaljoy {
            background-image: url(/assets/images/JALBATH/jal_bg.jpg);
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            width: 100%;
            height: 625px;
            position: relative;
        }

            .jaljoy .logo-img {
                /*width: 10%;*/
                margin-top: 5px;
            }

        .align-row {
            align-items: center;
            margin-top: -200px;
            flex-direction: row-reverse;
        }

        .form {
            /* width: 360px;*/
            background-color: #fff;
            padding: 25px;
            font-size: 14px;
            font-weight: 500;
            display: table;
            padding-bottom: 10px;
            box-shadow: 1px 0px 8px 1px #333333c2;
            padding-bottom: 35px;
            margin: auto;
            margin-top: -15px;
        }

            .form input[type=text] {
                margin-bottom: 15px;
                background: #e6e5e5;
                border: 1px solid #c6c6c6;
            }

            .form button {
                background-color: #0095da;
                border-radius: 0;
                margin-top: 20px;
                color: #fff;
                width: 60%;
            }

        .tap-box img {
            box-shadow: 1px 0px 8px 1px #333333c2;
            margin-top: 15px;
            height: 90%;
            width: 100%;
        }



        .massage_box {
            color: #12af84 !important;
            overflow: hidden;
            font-size: 13px !important;
            max-width: 100%;
            border: 2px dashed #f47932;
            padding: 1em;
            border-radius: 4px;
        }


        .next_btn {
            background: coral;
            padding: 5px 30px;
            color: #073136 !important;
            text-transform: uppercase;
            font-size: 14px;
            border: 1px solid white;
            margin-top: 20px;
            margin: 20px auto 0px;
            text-align: center;
            float: right;
            border-radius: 3px;
            text-align: center;
            display: table;
            float: none !important;
            margin: 0 auto;
            font-weight: 600;
            text-decoration: none !important;
            outline: none;
            transition: all 0.5s ease;
        }



        .massage_box strong {
            color: #12af84 !important
        }

        .massage_box a {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: block;
            color: #fb6405;
            text-decoration: none;
            font-weight: 600;
            margin-top: 10px;
        }


        footer {
            position: relative;
        }

        .footer {
            background-color: #0095da;
            height: 80px;
        }

            .footer::before {
                content: "";
                width: 100%;
                height: 4px;
                background-color: #0095da;
                position: absolute;
                bottom: 85px;
            }

        sup {
            color: #ff0000;
        }
        /* footer .footer-section{
            display:flex;
            
        }*/
        footer .youtube-icon {
            color: #FF0000;
            font-size: 28px;
            background-color: #fff;
            padding: 3px 9px;
            border-radius: 4px;
        }

        .footer-section a {
            color: #fff;
            float: right;
            margin-top: 27px;
        }

            .footer-section a:hover {
                text-decoration: none;
            }


        @media screen and (max-width: 411px) {
            .footer-section .youtube {
                display: block;
            }
        }
    </style>

</head>
<body class="overflow-auto">
    <form id="form1" runat="server">


        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="HdnID" runat="server" />
        <asp:HiddenField ID="HdnCode1" runat="server" />
        <asp:HiddenField ID="HdnCode2" runat="server" />
        <asp:HiddenField ID="CompName" runat="server" />
        <asp:HiddenField ID="long" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />

        <div class="jaljoy">
            <div class="container-box">
                <header>
                    <nav class="navbar">
                        <img src="../assets/images/JALBATH/jal_logo.png" alt="logo" class="img-fluid logo-img">
                    </nav>
                </header>
            </div>
        </div>
        <section class="pb-5 mb-5">
            <div class="container-box">
                <div class="row align-row">
                    <div class="col-md-4">
                        <div class="form">
                            <div id="mainform">
                                <div id="div1" style="display: none;">
                                    <div class="col-12">
                                        <label>ENTER 13 DIGIT CODE<sup>*</sup></label>
                                        <input type="text" id="codeone" data-msg-required="ENTER 13 DIGIT CODE" maxlength="13" class="form-control input1" />
                                    </div>
                                </div>

                                <div id="div2">
                                    <div class="col-12">
                                        <label>Plumber </label>
                                        <input type="radio" checked name="radio-btn" />
                                        <label>Consumer </label>
                                        <input type="radio" name="radio-btn" />
                                    </div>
                                    <br>

                                    <div class="col-12">
                                        <label>NAME<sup>*</sup></label>
                                        <input type="text" id="Name" placeholder="Name" data-msg-required="Please Enter Your Full Name" maxlength="50" class="form-control" />
                                    </div>
                                    <div class="col-12">
                                        <label>NUMBER<sup>*</sup></label>
                                        <input type="text" id="mobilenumber" maxlength="10" placeholder="Mobile Number" data-msg-required="Please Enter Your Moblie Number" class="form-control" />
                                    </div>
                                    <div class="col-12">
                                        <label>City<sup>*</sup></label>
                                        <input type="text" id="Address" placeholder="Address" data-msg-required="Please Enter Your Address." class="form-control" />
                                    </div>
                                    <div class="col-12">

                                        <select id="ddlstate" name="--Select State--" class="form-control">
                                              <option value="">--Select State--</option>
                                              <option value="1">Andhra Pradesh</option>
                                              <option value="2">Arunachal Pradesh</option>
                                              <option value="3">Assam</option>
                                              <option value="4">Bihar</option>
                                              <option value="5">Chhattisgarh</option>
                                              <option value="6">Goa</option>
                                              <option value="7">Gujarat</option>
                                              <option value="8">Haryana</option>
                                              <option value="9">Himachal Pradesh</option>
                                              <option value="10">Jharkhand</option>
                                              <option value="11">Karnataka</option>
                                              <option value="12">Kerala</option>
                                              <option value="13">Madhya Pradesh</option>
                                              <option value="14">Maharashtra</option>
                                              <option value="15">Manipur</option>
                                              <option value="16">Meghalaya</option>
                                              <option value="17">Mizoram</option>
                                              <option value="18">Nagaland</option>
                                              <option value="19">Odisha</option>
                                              <option value="20">Punjab</option>
                                              <option value="21">Rajasthan</option>
                                              <option value="22">Sikkim</option>
                                              <option value="23">Tamil Nadu</option>
                                              <option value="24">Telangana</option>
                                              <option value="25">Tripura</option>
                                              <option value="26">Uttar Pradesh</option>
                                              <option value="27">Uttarakhand</option>
                                              <option value="28">West Bengal</option>
                                              <option value="29">Andaman and Nicobar Islands</option>
                                              <option value="30">Chandigarh</option>
                                              <option value="31">Dadra & Nagar Haveli and Daman & Diu</option>
                                              <option value="32">Delhi</option>
                                              <option value="33">Jammu and Kashmir</option>
                                              <option value="34">Ladakh</option>
                                              <option value="35">Lakshadweep</option>
                                              <option value="36">Puducherry</option>
                                        </select>
                                        <%-- <select id="ddlstate" runat="server" class="form-control"></select>--%>
                                        <%--  <asp:DropDownList ID="ddlstate" CssClass="form-control" required="" runat="server"></asp:DropDownList>
                                        <asp:RequiredFieldValidator InitialValue="0" CssClass="toast-error" ID="rfv" runat="server" ControlToValidate="ddlstate" ErrorMessage="Select State*" ForeColor="Red"></asp:RequiredFieldValidator> --%>
                                    </div>
                                    <div class="col-12 text-center">
                                        <button type="button" id="btnsubmit" data-toggle="modal" class="btn toast-success" style="color: white;">Submit</button>
                                    </div>
                                </div>
                            </div>

                            <div style="display: none; padding: 0px !important;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <p id="p3msg" style="color: green !important; overflow: hidden; width: 280px; font-size: 14px !important;" class="displayNone massage_box"></p>
                                    </div>
                                    <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                                </div>


                            </div>

                        </div>



                    </div>
                    <div class="col-md-8 tap-box" id="frmlink">
                        <!--<div class="embed-responsive embed-responsive-16by9 mb-4">
                            <iframe class="embed-responsive-item" src="video/JAL_30_SEC_HINDI.mp4"></iframe>
                        </div>-->

                        <div class="row">
                            <div class="col-md-4">
                                <img src="../assets/images/JALBATH/1.jpg" alt="tap1" class="img-fluid">
                            </div>
                            <div class="col-md-4">
                                <img src="../assets/images/JALBATH/2.jpg" alt="tap2" class="img-fluid">
                            </div>
                            <div class="col-md-4">
                                <img src="../assets/images/JALBATH/3.jpg" alt="tap3" class="img-fluid">
                            </div>

                            <!--<div class="col-12">
                                     <div class="embed-responsive embed-responsive-16by9 mt-4 ">
                                        <iframe class="embed-responsive-item" src="video/JAL_30_SEC_HINDI.mp4"></iframe>
                                    </div>
                                 </div>-->

                        </div>


                    </div>
                </div>

                <!--<div class="row">
                    <div class="col-md-8 offset-2">
                        
                    </div>
                </div>-->

            </div>
        </section>

        <footer>
            <div class="footer">
                <div class="container-box">
                    <div class="footer-section d-flex justify-content-between">
                        <a href="https://www.youtube.com/watch?v=lBlvb6fyth0" target="_blank" class="youtube"><i class="fa fa-youtube-play youtube-icon" aria-hidden="true"></i></a>
                        <a href="https://jaljoy.com/" target="_blank" class="link">https://jaljoy.com</a>
                    </div>
                </div>
            </div>
        </footer>


    </form>
</body>
</html>

