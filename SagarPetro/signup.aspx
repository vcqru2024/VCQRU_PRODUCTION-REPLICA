<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="Patanjali_signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign up</title>
    <!-- css -->
    <link rel="stylesheet" href="assets/SIgnup/css/style.css" />
    <link rel="stylesheet" href="assets/SIgnup/css/css.css" />

    <link href="assets/SIgnup/css/responsive.css" rel="stylesheet" />
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
        rel="stylesheet" />
    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    
    <style>
         #overlay {
            position: fixed;
            top: 0;
            z-index: 10000;
            width: 100%;
            height: 100%;
            display: none;
            background: rgba(0, 0, 0, 0.6);
        }

        .cv-spinner {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px #ddd solid;
            border-top: 4px #2e93e6 solid;
            border-radius: 50%;
            animation: sp-anime 0.8s infinite linear;
        }

        @keyframes sp-anime {
            100% {
                transform: rotate(360deg);
            }
        }

        .is-hide {
            display: none;
        }
    </style>
    <script>
        function showAlert(title, text, icon) {
            Swal.fire({
                title: title,
                text: text,
                icon: icon,
                confirmButtonText: 'OK'
            });
        }
    </script>
    <style>
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
     <div id="overlay">
        <div class="cv-spinner">
            <span class="spinner"></span>
        </div>
    </div>
    <!-- login-start -->
    <section class="login-page">
        <div class="container-fluid">
            <div class="row g-0">
                <div class="col-xxl-8 col-xl-8 col-lg-6 d-lg-block d-none">
                    <div class="login-services">
                        <div class="all-login-services">
                            <div class="heading-login">
                                <h5>Explore our services</h5>
                                <p>
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Modi atque placeat saepe
                                    minima ducimus rem temporibus, tempore nisi sapiente provident totam ratione
                                    repellendus dolorum harum animi ipsam nobis quasi illo?
                                </p>
                            </div>
                            <img src="assets/SIgnup/img/all-login-services.svg" alt="all-login-services" class="img-fluid" />
                        </div>
                    </div>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-6">
                    <div class="login-box">
                        <div class="login-card">
                            <div class="card">
                                <div class="card-body" id="divRegistration">
                                    <img src="assets/SIgnup/img/logo-vcqru.svg" alt="" />
                                    <h5 class="card-title">Sign up & Get Started</h5>
                                    <p class="card-text">Sign up to your VCQRU Dashboard Account </p>
                                    <form class="needs-validation" novalidate>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="comname" class="form-label">Company Name<span>*</span></label>
                                                <input type="text" class="form-control" id="comname" required />

                                                <div class="invalid-feedback">Please Enter Your Company Name</div>
                                            </div>
                                            <div class="col-12">
                                                <label for="EmailId" class="form-label">Email Id <span>*</span></label>
                                                <input type="text" class="form-control" id="EmailId" required />

                                                <div class="invalid-feedback">Please Enter valid email</div>
                                            </div>
                                            <div class="col-12">
                                                <label for="conper" class="form-label">
                                                    Contact Person Name
                                                    <span>*</span></label>
                                                <input type="text" class="form-control" id="conper" required />

                                                <div class="invalid-feedback"></div>
                                            </div>
                                            <div class="col-12">
                                                <label for="number" class="form-label">
                                                    Mobile
                                                    Number<span>*</span></label>
                                                <input type="text" class="form-control" id="number" required />

                                                <div class="invalid-feedback">Please Enter password</div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" id="btnsignup" class="btn btn-primary">Sign UP</button>
                                            </div>
                                            <div class="col-12">
                                                <p class="bottom-links-form">Already a member? <a href="../SagarPetro/Loginpfl.aspx">Sign in</a></p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-body" style="display: none" id="divotp">
                                    <img src="assets/SIgnup/img/logo-vcqru.svg" alt="">
                                    <h5 class="card-title">OTP Verification</h5>
                                    <p class="card-text">
                                        Enter the 4 digit verification code that was sent to your Phone
                                        Number and Email Id.
                                    </p>
                                    <form class="needs-validation" novalidate>
                                        <div class="row g-3">
                                            <div class="col-12">
                                                <label for="MobileOTP" class="form-label">
                                                    Mobile OTP
                                                    <span>*</span></label>
                                                <div id="otpInputs" class="otpInputs">
                                                    <input type="text" id="mobileOtp1" class="form-control" required maxlength="1" />
                                                    <input type="text" id="mobileOtp2" class="form-control" required maxlength="1" />
                                                    <input type="text" id="mobileOtp3" class="form-control" required maxlength="1" />
                                                    <input type="text" id="mobileOtp4" class="form-control" required maxlength="1" />

                                                </div>

                                                <p class="count1">
                                                    Resend OTP in <span id="countdowntimer">30 </span>
                                                    Seconds
                                                </p>
                                                <button
                                                    class="resend btn-link btn shadow-none btn-sm w-auto text-capitalize"
                                                    type="button" style="display: none;">
                                                    Resend</button>

                                                <div class="invalid-feedback">Please Enter valid OTP</div>
                                            </div>
                                            <div class="col-12">
                                                <label for="EmailOTP" class="form-label">Email OTP<span>*</span></label>
                                                <div id="otpInputs2" class="otpInputs">
                                                    <input type="text" id="emailOtp1" class="form-control" required maxlength="1" />
                                                    <input type="text" id="emailOtp2" class="form-control" required maxlength="1" />
                                                    <input type="text" id="emailOtp3" class="form-control" required maxlength="1" />
                                                    <input type="text" id="emailOtp4" class="form-control" required maxlength="1" />
                                                </div>
                                                <p class="count2">
                                                    Resend OTP in <span id="countdowntimer2">30 </span>
                                                    Seconds
                                                </p>
                                                <button
                                                    class="resend btn-link btn shadow-none btn-sm w-auto text-capitalize"
                                                    type="button" style="display: none;">
                                                    Resend</button>
                                                <div class="invalid-feedback">Please Enter valid OTP</div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" id="btnverifyotp" class="btn btn-primary">VERIFY</button>
                                            </div>
                                            <div class="col-12">
                                                <p class="bottom-links-form">Already a member? <a href="../SagarPetro/Loginpfl.aspx">Sign in</a></p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- login-end -->
    <!-- js -->
    <script src="assets/js/index.js"></script>
    <!-- form-validation -->
    <script>
        (() => {
            'use strict'
            const forms = document.querySelectorAll('.needs-validation')
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnsignup').click(function (event) {
                event.preventDefault();
                RegisterVendor();
            });
            $('#btnverifyotp').click(function (event) {
                event.preventDefault();
                RegisterVendornew();
            });
            $('#countdowntimer').click(function (event) {
                event.preventDefault();
                otpsendMobile();
            });
            $('#countdowntimer2').click(function (event) {
                event.preventDefault();
                otpsendEmail();
            });
            
        });
        function ShowProgress() {
            $("#overlay").fadeIn(300);

        };

        function HideProgress() {
            $("#overlay").fadeIn(0);
            $("#overlay").hide();

        };
        function otpsendMobile() {
            ShowProgress();
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/PatanjaliHandler.ashx?method=ResendotponMobile&Mobile='+ $('#number').val(),
                success: function (data) {
                    HideProgress();
                    if (data == "Otp Send Successfully") {
                        showAlert('Success', data, 'success');
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        };
        function otpsendEmail() {
            ShowProgress();
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/PatanjaliHandler.ashx?method=Resendotponemail&Email=' + $('#EmailId').val() + "&Mobile=" + $('#number').val(),
                success: function (data) {
                    HideProgress();
                    if (data == "Otp Send Successfully") {
                        showAlert('Success', data, 'success');
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }
                }
            });
        };

        function RegisterVendor() {
            var comp = $('#comname').val();
            var contactpersion = $('#conper').val();
            var email = $('#EmailId').val();
            var mobile = $('#number').val();
            if ($('#comname').val() == '') {
                showAlert('Error', "Enter Company Name !", 'error'); return false;
            }
            else {
                if ($('#conper').val() == '') {
                    showAlert('Error', "Enter Contact Person Name !", 'error'); return false;
                }
                else {
                    if ($('#EmailId').val() == '') {
                        showAlert('Error', "Enter Email Address !", 'error'); return false;
                    }
                    else {
                        var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                        var valid = emailReg.test($('#EmailId').val());
                        if (!valid) {
                            showAlert('Error', "Please enter the correct email.", 'error'); return false;
                        }
                        else {
                            if ($('#number').val() == '') {
                                showAlert('Error', "Please enter mobile no.", 'error'); return false;
                            }
                            else {
                                var v = $('#number').val().length;
                                if (v != 10) {
                                    showAlert('Error', "Please enter correct Mobile Number.", 'error'); return false;
                                }
                                else {
                                    ShowProgress();
                                    $.ajax({
                                        type: "POST",
                                        url: '../Info/PatanjaliHandler.ashx?method=OTPSENDFORREG&EmailID=' + email + '&MobileNO=' + mobile,
                                        success: function (data) {
                                            HideProgress();
                                            if (data.split('~')[0] === "Success") {
                                                $('#divRegistration').css('display', 'none');
                                                $('#divotp').css('display', 'block');
                                                startCountdown('countdowntimer', 30);
                                                startCountdown('countdowntimer2', 30);
                                                showAlert('Success', data.slit("~")[1], 'success');
                                            }
                                            else {
                                                $('#divRegistration').css('display', 'block');
                                                $('#divotp').css('display', 'none');
                                                showAlert('Error', data, 'error');
                                            }
                                        },
                                    });
                                }
                            }
                        }
                    }
                }
            }
        }

        function RegisterVendornew() {
            var comp = $('#comname').val();
            var contactpersion = $('#conper').val();
            var email = $('#EmailId').val();
            var mobile = $('#number').val();
            var OTPEmail = $('#emailOtp1').val() + $('#emailOtp2').val() + $('#emailOtp3').val() + $('#emailOtp4').val();
            var OTPmobile = $('#mobileOtp1').val() + $('#mobileOtp2').val() + $('#mobileOtp3').val() + $('#mobileOtp4').val();
            if (OTPEmail.length < 4) {
                showAlert('Error', "Please Enter Valid Email OTP", 'error'); return false;
            }
            if (OTPmobile.length < 4) {
                showAlert('Error', "Please Enter Valid Mobile OTP", 'error'); return false;
            }
            if ($('#comname').val() == '') {
                showAlert('Error', "Enter Company Name !", 'error'); return false;
            }
            else {
                if ($('#conper').val() == '') {
                    showAlert('Error', "Enter Contact Person Name !", 'error'); return false;
                }
                else {
                    if ($('#EmailId').val() == '') {
                        showAlert('Error', "Enter Email Address !", 'error'); return false;
                    }
                    else {
                        var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                        var valid = emailReg.test($('#EmailId').val());
                        if (!valid) {
                            showAlert('Error', "Please enter the correct email.", 'error'); return false;
                        }
                        else {
                            if ($('#number').val() == '') {
                                showAlert('Error', "Please enter mobile no.", 'error'); return false;
                            }
                            else {
                                var v = $('#number').val().length;
                                if (v != 10) {
                                    showAlert('Error', "Please enter correct Mobile Number.", 'error'); return false;
                                }
                                else {
                                    ShowProgress();
                                    $.ajax({
                                        type: "POST",
                                        url: '../Info/PatanjaliHandler.ashx?method=register&company=' + comp + '&contactpersion=' + contactpersion + '&email=' + email + '&mobile=' + mobile + '&OTPEmail=' + OTPEmail + '&OTPMobile=' + OTPmobile,
                                        success: function (data) {
                                            HideProgress();
                                            if (data.split('~')[0] !== "Failed") {
                                                $('#comname').val("");
                                                $('#conper').val("");
                                                $('#EmailId').val("");
                                                $('#number').val("");
                                                $('#emailOtp1').val(''); $('#emailOtp2').val(''); $('#emailOtp3').val(''); $('#emailOtp4').val('');
                                                $('#mobileOtp1').val(''); $('#mobileOtp2').val(''); $('#mobileOtp3').val(''); $('#mobileOtp4').val('');
                                                window.location.href = "../SagarPetro/Loginpfl.aspx?message=Success";
                                            }
                                            else {
                                               // $('#divRegistration').css('display', 'block');
                                               // $('#divotp').css('display', 'none');
                                                //showAlert('Success', data.slit("~")[1], 'success');
                                                showAlert('Error', data.split("~")[1], 'error'); return false;
                                            }
                                        },
                                    });
                                }
                            }
                        }
                    }
                }
            }
        }

        function startCountdown(targetId, countdown) {
            var timer = setInterval(function () {
                $('#' + targetId).html(countdown + ' Seconds');
                countdown--;
                if (countdown < 0) {
                    clearInterval(timer);
                    $('.resend').show();
                }
            }, 1000);
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
