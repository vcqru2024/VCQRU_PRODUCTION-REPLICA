<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ihff-event.aspx.cs" Inherits="ihff_event" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
         <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <link rel="canonical" href="https://www.vcqru.com/event/ihff-event.aspx"/>
        <title>IHFF Event Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <!-- css -->
        <link rel="stylesheet" href="css/css.css" />
        <link rel="stylesheet" href="css/reponsive.css" />
        <!-- font family -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <!-- Boxicons CSS -->
        <!-- font-awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/0.9.0/jquery.mask.min.js"></script>
               <script>
                   $(document).ready(function () {
                       $('#ChkCode').show();
                       $('#Chkfields').hide();
                       $('#mobilefield').hide();
                       // $('#otpfield').hide();
                       var id = $('#HdnID').val();
                       //alert(id);
                       if (id == "1") {
                           $('#ChkCode').show();
                           $('#Chkfields').hide();
                           $('#mobilefield').hide();
                           //$('#otpfield').hide();
                       }
                       else if (id == "Cosmo") {
                           //alert();
                           $('#ChkCode').hide();
                           // $('#otherfield').hide();
                           $('#mobilefield').show();
                           $('#Chkfields').show();
                           //$('#otpfield').hide();
                           var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                           $("#codeone").val(code);
                       }

                       $('#codeone').mask("99999-99999999");

                       $("#btnnxt").on('click', function (e) {
                           e.preventDefault();
                           debugger;
                           var codeone = $('#codeone').val();
                           if (codeone == "" || codeone == undefined) {
                               $('#codecheck').html('**Please Enter 13- Digit-Code');
                               $('#codecheck').css("color", "red");
                               return false;
                           }
                           else {
                               $('#nextcheck').text('');
                           }

                           if (codeone != undefined) {
                               if ($('#codeone').val().length < 14) {
                                   $('#codecheck').text('**Please Enter 13-Digit-Code');
                                   $('#codecheck').css("color", "red");
                                   return false;
                               }
                               else {
                                   $('#codecheck').text('');
                                   $('#codecheck').hide();
                               }
                           }

                           var rquestpage_Dcrypt = $("#codeone").val();
                           //$('#btnnxt').hide();
                           //$('#btnloadnxt').show();
                           $('#codediv').hide();
                           $('#Chkfields').show();
                           $('#mobilefield').show();
                           $("#mobile").mask("9999999999");

                       });

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

                           $('#btnsubmit').hide();
                           $('#btnloadsubmit').show();
                           var code = $('#codeone').val();
                           $("#p3msg").html("");
                           if (code != "") {
                               $.ajax({
                                   type: "POST",
                                   contentType: false,
                                   processData: false,
                                   url: '../Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobile').val() + "&vCode=" + $('#codeone').val() + '&comp=Cosmo Tech Expo&Comp_ID=Comp-1541',
                                   success: function (data) {
								  // alert(data);
                                       $('#btnsubmit').show();
                                       $('#btnloadsubmit').hide();
                                       if (data.split("~")[0] !== "failure") {
                                           window.scrollTo(0, 0);
                                           if (data.includes("invalid")) {
                                               data = "0~The code entered is invalid. Please try again";

                                           }
                                           if (data.includes("already")) {
                                               data = "1~This code has already been verified.";

                                           }
										    /*if (data.includes("Congratulations!!")) {
                                              data = data.substr(0,data.indexOf('.The checked'));

                                           }*/
                                           if (data.includes("Congratulations!!")) {
                                               data = "2~<img style=\"height: 4rem;\" src=\"https://cdn-icons-png.flaticon.com/512/14179/14179894.png\"/> <br> <br> <h4> Congratulations! </h4>  <b>You have Purchased an Authentic product from VCQRU</b>";
                                           }
										//data = data.substr(0,data.indexOf('.The checked'));
										// alert(data);
										//alert(data.split("~")[1]);

                                           $('#Chkfields').hide();
                                           $('#mobilefield').hide();
                                           $('#ChkCode').hide();
                                           $('#msg').hide();
                                           $('#ShowMessage').show();
                                           $("#p3msg").html(data.split("~")[1]);
                                           $('#p3msg').css("color", "black");
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
                   });
               </script>
    </head>
    <style>
        body {
            background: url('./assets/images/ihff-landing/landingpage.png');
            background-repeat: no-repeat;
            background-size: cover;
            min-height: 100vh;
            background-position: center;
            /* position: relative; */
        }

        ::placeholder {
            color: var(--bs-white) !important;
            opacity: 1;
            /* Firefox */
        }

        ::-ms-input-placeholder {
            /* Edge 12 -18 */
            color: var(--bs-white) !important;
        }

        .top-bar-landing-page {
            position: sticky;
            top: 0;
            background-color: #170a5a;
            z-index: 1000;
            margin-bottom: 2rem;
        }

        .logo img {
            height: 5rem;
        }

        .heading-logo img {
            height: 39rem;
        }



        .formplace .card .card-body {
            padding: 1.5rem;
        }

        .formplace .card .card-body button {
            width: 100%;
            border-radius: 2px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.1rem;
        }

        .formplace .card .card-body .form-label {
            font-size: 14px;
            font-weight: 400;
            color: var(--bs-white);
        }

        .formplace .card {
            border-radius: 8px;
            background-color: rgb(255 255 255 / 10%);
            border: 1px solid rgba(255, 255, 255, 0.40);
        }

        .formplace .card .card-body {
            color: var(--bs-white);
        }

        .formplace .card .card-body .form-control {
            color: var(--bs-white);
            border-radius: 2px;
            background-color: transparent;
            border-width: 2px;
        }

        .formplace .card .card-body .card-title {
            font-weight: 500;
            text-align: center;
        }
        .product-img img{
            height: 17rem;
            width: 100%;
        }

        .footer {
            height: 2rem;
            width: 100%;
            background-color: var(--bs-black);
            color: var(--bs-white);
            position: fixed;
            bottom: 0;
            text-align: center;
            padding: 0.25rem 0;
        }

        .footer p {
            margin-bottom: 0;
            font-size: 14px;
        }
            @media screen and (max-width:768px) {
                
                .heading-logo img {
               height: 15rem;
               
}
            .heading-logo img{
                display: none;
            }
            }
    </style>
    <body>
        <div class="landing">
            <div class="top-bar-landing-page">
                <div class="container-fluid">
                    <div class="row g-3">
                        <div class="col">
                            <div class="logo ">
                                <a href="https://www.vcqru.com/" alt="Vcqru logo">
                                <img class="img-fluid" src="assets/images/ihff-landing/image-65.png" alt="" />
                                    </a>
                            </div>
                        </div>
                        <div class="col">
                            <div class="logo text-end">
                                <img class="img-fluid" src="assets/images/ihff-landing/Clip-path-group.png" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row g-4 mobile-view">
                    <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 col-6 order-lg-1 order-2">
                        <div class="heading-logo text-center">
                            <img class="img-fluid" src="assets/images/ihff-landing/image-66.png" alt="" />
                        </div>
                    </div>
                    <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-7 order-lg-2 order-1 mx-auto">
                        <div class="formplace">
                            <div class="card">
                                <div class="card-body">
                                    <div class="mb-3" id="msg">
                                        <h5 class="card-title">To Check Authenticity</h5>
                                        <p class="card-text">
                                            Welcome to the official page of VCQRU product authenticity check portal
                                        </p>
                                    </div>
                                    <%--     <form class="row g-3">--%>
                                    <form runat="server">
                                        <asp:HiddenField ID="hdnmob" runat="server" />
                                        <asp:HiddenField ID="HdnID" runat="server" />
                                        <asp:HiddenField ID="HdnCode1" runat="server" />
                                        <asp:HiddenField ID="HdnCode2" runat="server" />
                                        <asp:HiddenField ID="CompName" runat="server" />
                                        <asp:HiddenField ID="long" runat="server" />
                                        <asp:HiddenField ID="lat" runat="server" />
                                        <div  id="codediv">
                                            <div id="ChkCode">
                                                <label for="digit">Enter 13 digit code*</label>
                                                <input type="text" class="form-control" id="codeone" required="" />
                                                <div id="codecheck" class="invalid-feedback d-block"></div>
                                                <div class="mt-3">
                                                    <button type="button" id="btnnxt"
                                                        class="btn btn-light">Next</button>
                                                    <button type="button" id="btnloadnxt" style="display: none"
                                                        class="btn btn-light"><i class="fa fa-spinner fa-spin"></i>Loading..</button>
                                                </div>
                                                <h6 id="nextcheck"></h6>
                                            </div>
                                        </div>

                                        <div id="Chkfields" style="display: none;" >
                                            <div id="mobilefield">
                                                <label for="exampleInputtext2" class="form-label">Mobile Number*</label>
                                                <input type="text" maxlength="10" id="mobile" onkeyup="Getdata()"
                                                    onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;"
                                                    class="form-control" />

                                                <div id="mobilecheck" class="invalid-feedback d-block"></div>
                                            </div>
                                            <div class="mt-3">
                                                <button type="submit" id="btnsubmit"
                                                    class="btn btn-light">submit</button>
                                                <button type="button" id="btnloadsubmit" style="display: none"
                                                    data-toggle="modal" class="form-control login-btn"><i
                                                        class="fa fa-spinner fa-spin"></i>Loading..</button>
                                            </div>
                                        </div>
                                </form>
                            </div>
                            <div style="display: none" id="ShowMessage">
                                <div class="form-box">
                                    <div class="text-center" style="margin-top:-30px;">
                                        <p id="p3msg" style="font-size: 15px !important;font-weight: 500;"
                                            class="displayNone massage_box text-white"></p>
                                    </div>
                                    <div class="text-center">
                                        <a href="https://www.vcqru.com" class="btn btn-danger m-2" id="btnNext">Close</a>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="product-img">
                            <img class="img-fluid" src="assets/images/ihff-landing/protien.png" alt="" />
                        </div>
                    </div>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 col-6 order-lg-3 order-3">
                    <div class="heading-logo text-center">
                        <img class="img-fluid" src="/assets/images/ihff-landing/image-68.png" />
                    </div>
                </div>
            </div>
        </div>
        <div class="footer">
            <div class="container">
                <p>@ Copyright 2024 VCQRU PVT LTD | All Rights Reserved</p>
            </div>
        </div>
        </div>
        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="script.js"></script>
    </body>

    </html>