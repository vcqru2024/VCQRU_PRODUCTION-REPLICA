<%@ Page Language="C#" AutoEventWireup="true" CodeFile="blackcobragov.aspx.cs" Inherits="blackcobragov" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Black Cobra</title>
    <!-- css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- icon -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- font-family -->
    <!-- font family -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA=" crossorigin="anonymous"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap');

        /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }

        body {
            font-family: 'Jost' !important;
        }

        .landing-ui .container-fluid {
            padding: 0;
        }

        .landing-ui .card-left .logo {
            margin-bottom: 1rem;
        }

        /* .landing-ui .card-left .logo img{
                width: 100%;
            } */
        /* form */
        .landing-ui .card-left .tab .card-title {
            margin-bottom: 0.75rem;
        }

        .landing-ui .card-left .tab .card-text {
            margin-bottom: 0;
            color: #4B5563;
        }

        .landing-ui .card-left .tab {
            margin: 1rem 0 2rem 0;
        }

        .landing-ui .card-left .form-btns .btn {
            width: 100%;
            border-radius: 2px;
            background-color: #34C759;
            color: var(--bs-white);
            font-weight: 600;
            text-transform: uppercase;
            padding: 0.75rem;
        }

        .landing-ui .card-left .tab {
            display: none;
        }

        .landing-ui .card-left {
            padding: 3rem 10rem;
            width: 100%;
            min-height: 100vh;
        }

            .landing-ui .card-left .card-title {
                margin-bottom: 0.75rem;
            }

            .landing-ui .card-left .card-text {
                margin-bottom: 0;
                color: #4B5563;
            }

            .landing-ui .card-left .form-control {
                border-radius: 2px;
                background-color: #F3F4F6;
                font-weight: 600;
                padding: 0.75rem;
            }

                .landing-ui .card-left .form-control::placeholder {
                    color: #ADAAAF;
                }

        /* footer */
        .footer {
            background-color: var(--bs-black);
            padding: 0.25rem 0;
            position: fixed;
            width: 100%;
            bottom: 0;
            z-index: 1000;
        }

            .footer a {
                color: var(--bs-white);
            }

            .footer p {
                margin-bottom: 0;
                font-size: 14px;
                color: var(--bs-white);
            }

        .landing-ui .card-right {
            width: 100%;
            min-height: 100vh;
        }

            .landing-ui .card-right .carousel,
            .landing-ui .card-right .carousel .carousel-inner,
            .landing-ui .card-right .carousel .carousel-inner .carousel-item,
            .landing-ui .card-right .carousel .carousel-inner .carousel-item img {
                height: 100%;
                display: flex;
                align-items: end;
            }

                .landing-ui .card-right .carousel .carousel-item img {
                    object-fit: cover;
                }

                .landing-ui .card-right .carousel .carousel-inner .carousel-item::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    background: linear-gradient(0deg, rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0) 100%);
                    height: 100%;
                    width: 100%;
                    z-index: 1000;
                }

                .landing-ui .card-right .carousel .carousel-inner .carousel-item .carousel-caption {
                    bottom: auto;
                    top: 0;
                    left: 0;
                    padding: 2rem;
                    width: 100%;
                    z-index: 1000;
                    text-align: left;
                    background: linear-gradient(0deg, rgba(0, 0, 0, 0) 80%, rgba(0, 0, 0, 1) 100%);
                    height: 100%;
                }

                    .landing-ui .card-right .carousel .carousel-inner .carousel-item .carousel-caption h5 {
                        margin-bottom: 0;
                    }

                .landing-ui .card-right .carousel .carousel-inner .contact-us-details {
                    position: relative;
                    z-index: 1000;
                    padding: 2rem 2rem 3rem 2rem;
                    width: 100%;
                    color: var(--bs-white);
                }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul {
                        list-style: none;
                        padding: 0;
                        margin: 0;
                        display: flex;
                        flex-direction: column;
                        gap: 1rem;
                    }

                        .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul li {
                            display: flex;
                            gap: 1rem;
                        }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details h5 {
                        font-weight: 600;
                        margin-bottom: 1rem;
                    }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul li a {
                        text-decoration: none;
                        color: var(--bs-white);
                    }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul li h6 {
                        margin-bottom: 0.25rem;
                    }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul li p {
                        margin-bottom: 0;
                    }

                    .landing-ui .card-right .carousel .carousel-inner .contact-us-details ul li i {
                        font-size: 20px;
                        color: var(--bs-white);
                        background-color: rgba(255, 255, 255, 0.5);
                        border-radius: var(--bs-border-radius-pill);
                        height: 1.5rem;
                        min-width: 1.5rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

        .landing-ui .app-whatsapp {
            position: fixed;
            right: 0;
            bottom: 0;
            margin: 0 2rem 3rem 0;
            border: 2px solid var(--bs-border-color);
            z-index: 1000;
            width: 3rem;
            height: 3rem;
            background-color: var(--bs-white);
            padding: 0.25rem;
            border-radius: var(--bs-border-radius-sm);
        }

            .landing-ui .app-whatsapp a {
                height: 100%;
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

        .original {
            height: 5rem;
            margin-bottom: 1rem;
        }

        .invail-box {
            background-color: #FDBF00;
            border-color: #FDBF00;
        }


        .success-box,
        .invail-box {
            padding: 2rem;
            border-width: 2px;
            text-align: center;
            border-radius: var(--bs-border-radius-lg);
            border-style: solid;
        }

        .success-box {
            background-color: #FDBF00;
            border-width: 0;
        }

            .success-box p,
            .invail-box p {
                margin-bottom: 0;
            }

        /* .success-box img {
                mix-blend-mode: darken;
                height: 4rem;
            } */
        @media screen and (max-width:1024px) {
            .landing-ui .card-left {
                padding: 3rem;
            }
        }

        @media screen and (max-width:768px) {
            .landing-ui .card-left {
                padding: 2rem;
                min-height: auto;
            }

            .landing-ui .card-right {
                min-height: auto;
            }

                .landing-ui .card-right .carousel .carousel-inner .contact-us-details {
                    padding: 8rem 2rem 6rem 2rem;
                }
        }

        @media screen and (max-width:425px) {
            .footer p {
                font-size: 12px;
            }
        }
    </style>
    <style>
        .landing-ui .card-left .invalid-feedback {
            display: block;
        }

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

   <script type="text/javascript">
       $("#Pincode").mask("999999");
       var lat = "";
       var BaseURL = "../";
       var long = "";
       var code1 = "";
       var code2 = "";

       var getPosition = function (options) {
           return new Promise(function (resolve, reject) {
               navigator.geolocation.getCurrentPosition(resolve, reject, options);
           });
       };

       function Postalcode() {
           let pin = document.getElementById("pincode").value;
           if (pin.length == 6) {
               $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                   createHTML(data);
               });
           }

           function createHTML(data) {
               if (data[0].Status == "Success") {
                   var city = data[0].PostOffice[0]['District'];
                   var state = data[0].PostOffice[0]['State'];
                   $("#city").val(city).prop('readonly', true);
                   $("#state").val(state).prop('readonly', true);
                   setCookie("city", city, 1); // Save city to cookie
                   setCookie("state", state, 1); // Save state to cookie
               } else {
                   $("#city").val('').prop('readonly', false);
                   $("#state").val('').prop('readonly', false);
               }
           }
       }

       $(document).ready(function () {
           // Check and set cookies for fields
           $('#mobile').val(getCookie("mobileNumber") || ""); // Mobile
           $('#dealer').val(getCookie("dealerName") || ""); // Dealer Name
           $('#productname').val(getCookie("productName") || ""); // Product Name
           $('#txtemail').val(getCookie("email") || ""); // Email
           $('#pincode').val(getCookie("pincode") || ""); // Pincode
           $('#city').val(getCookie("city") || ""); // City
           $('#state').val(getCookie("state") || ""); // State

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
           } else if (id == "blackcobragov") {
               var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
               $("#example13-digit-number").val(code);
               var mobileNumberCookie = getCookie("mobileNumber");
               if (mobileNumberCookie !== "" && mobileNumberCookie !== null) {
                   
                   finnalsubmit();
               } else {
                   $('#Chkcode').hide();
                   $('#Chkfields').show();
                   $('#mobilefield').show();
                   $('#Otherfield').hide();
                   
               }
           }

           $("#example13-digit-number").mask("99999-99999999");

           $("#btnnxt").on('click', function (e) {
               e.preventDefault();
               var codeone = $('#example13-digit-number').val();
               code1 = codeone.split('-')[0];
               code2 = codeone.split('-')[1];
               if (!codeone) {
                   showAlert('Error', 'Please enter codes', 'error');
                   return false;
               } else if ($('#example13-digit-number').val().length < 14) {
                   showAlert('Error', 'Please enter valid codes', 'error');
                   return false;
               }
               var rquestpage_Dcrypt = $("#example13-digit-number").val();
               $('#btnnxt').hide();
               $('#btnloadnxt').show();
               $('#overlay').show();
               $.ajax({
                   type: "POST",
                   url: BaseURL + 'Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + lat + '&long=' + long,
                   success: function (data) {
                       $('#overlay').hide();
                       $('#btnnxt').show();
                       $('#btnloadnxt').hide();
                       if (data.split('&')[1] == "Yamuna Interiors Pvt Ltd G" || data.split('&')[1] == "" || data.split('&')[1] == undefined) {
                           var mobileNumberCookie = getCookie("mobileNumber");
                           if (mobileNumberCookie !== "" && mobileNumberCookie !== null) {
                               finnalsubmit();
                           } else {
                               $('#Chkcode').hide();
                               $('#Chkfields').show();
                               $('#mobilefield').show();
                               $('#Otherfield').hide();
                           }
                       } else {
                           $('#Chkcode').show();
                           $('#Chkfields').hide();
                           $('#mobilefield').hide();
                           $('#Otherfield').hide();
                           showAlert('Error', 'Invalid Code', 'error');
                           return false;
                       }
                   },
                   error: function (xhr, status, error) {
                       $('#overlay').hide();
                       $('#btnnxt').show();
                       $('#btnloadnxt').hide();
                       showAlert('Error', 'An error occurred while verifying the warranty. Please try again.', 'error');
                   }
               });
           });

           $("#mobile").mask("9999999999");

           $('#btnsubmit').on('click', function (e) {
               e.preventDefault();
               var Mobileno = $('#mobile').val().trim();
               var dealername = $('#dealer').val().trim();
               var proname = $('#productname').val().trim();
               var validNameRegex = /^[a-zA-Z ]{3,40}$/;

               if (Mobileno.length != 10 || !/^\d{10}$/.test(Mobileno) || Mobileno.slice(0, 1) <= 5) {
                   showAlert('Error', 'Please enter valid mobile number', 'error');
                   return false;
               }
               if (dealername == "" || !validNameRegex.test(dealername)) {
                   showAlert('Error', 'Dealer name must be between 3 and 40 characters and may only contain letters.', 'error');
                   return false;
               }
               if (proname == "" || !validNameRegex.test(proname)) {
                   showAlert('Error', 'Product name must be between 3 and 40 characters and may only contain letters.', 'error');
                   return false;
               }
               var email = $('#txtemail').val().trim();
               if (!validateEmail(email)) {
                   showAlert('Error', 'Please enter a valid email address', 'error');
                   return false;
               }
               var pincode = $('#pincode').val().trim();
               if (pincode.length != 6 || !/^\d{6}$/.test(pincode)) {
                   showAlert('Error', 'Please enter a valid 6-digit pincode', 'error');
                   return false;
               }

               // Save values to cookies
               setCookie("mobileNumber", Mobileno, 1);
               setCookie("dealerName", dealername, 1);
               setCookie("productName", proname, 1);
               setCookie("email", email, 1);
               setCookie("pincode", pincode, 1);

               finnalsubmit();
           });

           $('#btnNext').click(function () {
               window.location.href = 'https://qa.vcqru.com/blackcobraretail.aspx';
           });
           $('#btnlogin').click(function () {
               window.location.href = 'https://qa.vcqru.com/login.aspx';
           });
       });

       function validateEmail(email) {
           if (email === null || email === undefined || email.trim() === "") {
               return true;
           }
           var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
           return emailRegex.test(email);
       }

       function setCookie(name, value, days) {
           var expires = "";
           if (days) {
               var date = new Date();
               date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
               expires = "; expires=" + date.toUTCString();
           }
           document.cookie = name + "=" + (value || "") + expires + "; path=/";
       }

       function getCookie(name) {
           var nameEQ = name + "=";
           var ca = document.cookie.split(';');
           for (var i = 0; i < ca.length; i++) {
               var c = ca[i];
               while (c.charAt(0) == ' ') c = c.substring(1, c.length);
               if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
           }
           return null;
       }

       function finnalsubmit() {

           var code = $('#example13-digit-number').val();
           if (code != "") {
               $('#overlay').show();
               $.ajax({
                   type: "POST",
                   contentType: false,
                   processData: false,
                   url: BaseURL + 'Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#example13-digit-number').val() + '&PinCode=' + $('#pincode').val() + '&EmailAddrs=' + $('#txtemail').val() + '&city=' + $('#city').val() + '&state=' + $('#state').val() + '&SellerName=' + $('#dealer').val() + '&Shopname=' + $('#productname').val() + '&Comp_ID=Comp-1728' + '&comp=Yamuna Interiors Pvt Ltd G',
                   success: function (data) {
                       $('#overlay').hide();
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
                           $('#divhead').hide();
                           $('#ShowMessage').show();

                           if (data.split("~")[1].includes('Genuine')) {
                               $('.success-box').show();
                               $('.invail-box').hide();
                               $('#p3msg').html(data.split("~")[1]);
                           }
                           else {
                               $('.success-box').hide();
                               $('.invail-box').show();
                               $('#p3msg2').html(data.split("~")[1]);
                           }
                       }
                       else {
                           showAlert('Error', data.split('~')[1], 'error');
                       }
                   }
               });
           }
       }
   </script>



</head>

<body>


    <div id="overlay">
        <div class="cv-spinner">
            <span class="spinner"></span>
        </div>
    </div>

    <section class="landing-ui">
        <div class="container-fluid">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-0">
                <div class="col d-flex">
                    <div class="card-left">
                        <div class="logo">
                            <img src="../assets/Images/Yamuna-black-cobra/black-cobra-logo.svg" alt="Logo"
                                class="img-fluid mb-3">
                            <p class="mb-0">Grade Especially Designed For Govt Projects</p>
                        </div>
                        <form id="regForm" runat="server">
                            <asp:HiddenField ID="hdnmob" runat="server" />
                            <asp:HiddenField ID="HdnID" runat="server" />
                            <asp:HiddenField ID="HdnCode1" runat="server" />
                            <asp:HiddenField ID="HdnCode2" runat="server" />
                            <asp:HiddenField ID="CompName" runat="server" />
                            <asp:HiddenField ID="long" runat="server" />
                            <asp:HiddenField ID="lat" runat="server" />
                            <asp:HiddenField ID="state" runat="server" />
                            <asp:HiddenField ID="city" runat="server" />


                            <div class="tab" style="display: block;">
                                <div class="row row-cols-1 g-4">
                                    <div class="col" id="divhead">
                                        <h5 class="card-title">Authenticate your product</h5>
                                        <p class="card-text">
                                            India’s Leading manufacturer of a wide range of quality
                                                building
                                                materials since 1995
                                        </p>
                                    </div>
                                    <div id="Chkcode" class="col">
                                        <div class="row row-cols-1 g-3">
                                            <div class="col">
                                                <input type="text" maxlength="13" id="example13-digit-number"
                                                    placeholder="13 Digits Code" class="form-control" />
                                            </div>
                                            <div class="col">
                                                <div class="form-btns">
                                                    <button type="submit" id="btnnxt" class="btn">Next</button>
                                                    <button type="submit" style="display: none" id="btnloadnxt"
                                                        class="btn">
                                                        <i class="fa fa-spinner fa-spin"></i>Loading...</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="Chkfields" class="col">
                                        <div class="row row-cols-1 g-3">
                                            <div class="col">
                                                <div class="form-group">
                                                    <input type="text" id="mobile" placeholder="Mobile Number*"
                                                        class="form-control"
                                                        onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                        name="">
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group">
                                                    <input type="text" id="dealer" maxlength="30"
                                                        placeholder="Dealers Name*" class="form-control"
                                                        name="">
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group">
                                                    <input type="text" id="productname" maxlength="30"
                                                        placeholder="Product Name*" class="form-control"
                                                        name="">
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group">
                                                    <input type="email" id="txtemail"
                                                        placeholder="Email Address" class="form-control"
                                                        name="">
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-group">
                                                    <input type="number" id="pincode" onkeyup="Postalcode();"
                                                        oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 6) this.setCustomValidity('Pin code must be exactly 6 digits.'); else this.setCustomValidity('');"
                                                        maxlength="6" placeholder="Pin code*"
                                                        class="form-control" name="">
                                                </div>
                                            </div>

                                        </div>
                                        <div class="form-btns mt-3">
                                            <button type="button" id="btnsubmit" onclick="nextPrev(1)"
                                                class="btn">
                                                submit</button>
                                            <button type="submit" style="display: none" id="btnloadsubmit"
                                                class="btn">
                                                <i class="fa fa-spinner fa-spin"></i>Loading...</button>
                                        </div>
                                    </div>
                                    <div class="col" style="display: none;" id="ShowMessage">
                                        <div class="row row-cols-1 g-3">
                                            <div class="col">
                                                <div class="success-box">
                                                    <div class="mb-2">
                                                        <img src="../assets/images/Yamuna-black-cobra/100-origainal.svg"
                                                            alt="icon">
                                                    </div>
                                                    <p id="p3msg"></p>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="invail-box">
                                                    <div id="p3msg2"></div>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-btns">
                                                    <a href="http://blackcobra.org/" class="btn" id="btnNext">Close</a>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <h5 class="text-center">Trusted By</h5>
                                                <img src="../assets/images/Yamuna-black-cobra/Trusted.svg"
                                                    class="w-100" />
                                            </div>
                                            <div class="col">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h5 class="card-title">Explore more products.</h5>
                                                        <p class="card-text mb-3">
                                                            Click here on the button to visit our website and see
                                                                our new
                                                                products.
                                                        </p>
                                                        <a href="http://blackcobra.org/" target="_blank"
                                                            class="btn btn-dark px-5">View
                                                                more</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card-right">
                        <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel"
                            data-bs-pause="false">
                            <!-- data-bs-pause="false"
                            data-bs-ride="carousel" -->
                            <div class="carousel-inner">
                                <div class="carousel-item active" data-bs-interval="2000">
                                    <img src="../assets/Images/Yamuna-black-cobra/banner-one.png"
                                        class="d-block w-100" alt="Banner one">
                                    <div class="carousel-caption">
                                        <h5>Aluminium Composite Panel</h5>
                                    </div>
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <img src="../assets/Images/Yamuna-black-cobra/banner-two.png"
                                        class="d-block w-100" alt="Banner one">
                                    <div class="carousel-caption">
                                        <h5>Interior louvers</h5>
                                    </div>
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <img src="../assets/Images/Yamuna-black-cobra/banner-three.png"
                                        class="d-block w-100" alt="Banner one">
                                    <div class="carousel-caption">
                                        <h5>Flush Doors</h5>
                                    </div>
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <img src="../assets/Images/Yamuna-black-cobra/banner-four.png"
                                        class="d-block w-100" alt="Banner one">
                                    <div class="carousel-caption">
                                        <h5>WPC Doors</h5>
                                    </div>
                                </div>
                                <div class="contact-us-details">
                                    <h5>Get in touch with us</h5>
                                    <ul>
                                        <li>
                                            <i class="bx bx-check"></i>
                                            <div>
                                                <h6>Toll-Free Number:</h6>
                                                <a href="tel:9681822222">+91 9681822222</a>
                                            </div>
                                        </li>
                                        <li>
                                            <i class="bx bx-check"></i>
                                            <div>
                                                <h6>BLACK COBRA Care Email:</h6>
                                                <a href="mailto:info@blackcobra.org">info@blackcobra.org</a>
                                            </div>
                                        </li>
                                        <li>
                                            <i class="bx bx-check"></i>
                                            <div>
                                                <h6>Email & Call Timings:</h6>
                                                <p>Monday to Saturday (9:30 AM – 7:00 PM)</p>
                                            </div>
                                        </li>
                                        <li>
                                            <i class="bx bx-check"></i>
                                            <div>
                                                <h6>WhatsApp Messaging:</h6>
                                                <p>Monday to Saturday (9:30 AM – 7:30 PM)</p>
                                            </div>
                                        </li>
                                        <p class="mb-0">
                                            <span>Please note -</span> No calls will be entertained on
                                                WhatsApp.
                                        </p>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="app-whatsapp">
            <a href="https://web.whatsapp.com/send?phone=919681822222&text=" target="_blank">
                <img src="../assets/Images/Yamuna-black-cobra/WhatsApp_icon.svg" alt="WhatsApp_icon"
                    class="img-fluid">
            </a>
        </div>
    </section>
    <!-- footer -->
    <footer class="footer">
        <div class="container">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                <div class="col">
                    <p class="text-md-start text-center">Copyright © 2024 Black Cobra. All Rights Reserved.</p>
                </div>
                <div class="col">
                    <p class="text-md-end text-center">
                        Designed and developed by <a href="https://www.vcqru.com/" target="_blank">VCQRU
                                Private Limited.</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- footer-end -->
    <!-- js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- form with next and prev-->

</body>

</html>
