<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteAccount.aspx.cs" Inherits="DeleteAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Deleted Account</title>
    <!-- css -->
    <link rel="stylesheet" href="assets/Deletecss/css.css" />
    <link rel="stylesheet" href="assets/Deletecss/style.css" />
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <!-- fontawsome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
   
        <section class="deleted-account">
        <div class="container">
            <div class="logo">
                <nav class="navbar">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">
                            <img src="https://www.vcqru.com/NewContent/img-home/logo.png" alt="Logo" />
                        </a>
                    </div>
                </nav>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 mx-auto my-5">
                    <div class="card">
                        <div class="card-body">
                            <form  id="multiStepForm">
                                <div id="step1" class="form-section active">
                                    <h5>Deleted Account</h5>
                                    <p>We will send you an <span class="fw-500 text-dark">One Time Password</span> on
                                        this mobile number</p>
                                    <div class="form-group">
                                        <label for="mobile-number" class="form-label">mobile
                                            number<span class="text-danger">*</span></label>
                                        <input type="number" class="form-control mb-3" id="mobilenumber" maxlength="10" required="" />
                                        <button type="button" id="btnotp" class="btn btn-primary nextBtn">get
                                            otp</button>
                                    </div>
                                </div>
                                <div id="step2" class="form-section">
                                    <h5>OTP Verification</h5>
                                    <p>Enter the OTP send to <br /><span class="text-dark fw-500">+91 - <label id="lblMobile" for="otp" class="form-label"></label></span>
                                    </p>
                                    <label for="otp" class="form-label">OTP<span>*</span></label>
                                    <ul class="otp">
                                        <li>
                                            <input type="number" size="1" class="form-control otpField" id="otp1" maxlength="1" />
                                        </li>
                                        <li>
                                            <input type="number" size="1" class="form-control otpField" id="otp2"  maxlength="1" />
                                        </li>
                                        <li>
                                            <input type="number" size="1" class="form-control otpField" id="otp3" maxlength="1" />
                                        </li>
                                        <li>
                                            <input type="number" size="1" class="form-control otpField" id="otp4" maxlength="1" />
                                        </li>
                                    </ul>
                                    <p>Don't received the OTP ? <button
                                            class="btn p-0 w-auto text-primary fs-14 border-0" type="button" id="btnresendOTP">RESEND
                                            OTP</button></p>
                                    <button type="button" class="btn btn-primary nextBtn" id="btnverifyotp">Verify</button>
                                    <button type="button" class="btn btn-sm border-0 prevBtn" id="btnchangenumber">change number</button>
                                </div>
                                <div id="step3" class="text-center form-section">
                                    <p>
                                        Are you sure you want to delete your account? If you proceed with
                                        deleting your account, please be aware that you will permanently lose all data,
                                        codes, and any other information associated with your account. This action
                                        cannot be undone, so please consider carefully before making a decision.!
                                    </p>
                                    <button type="button" class="w-auto btn-light btn prevBtn" id="btncancel">cancel</button>
                                    <button type="button" class="w-auto btn btn-danger nextBtn" id="btnDelete">delete</button>
                                </div>
                                 <div id="step4" class="text-center form-section">
                                    <p>
                                        Your account deleted successfully !
                                    </p>
                                    
                                    <button type="button" class="w-auto btn btn-danger nextBtn" id="btnOK">OK</button>
                                </div>

                                <div id="DivInvailid" class="text-center form-section">
                                    <p>
                                        Sorry! You are not Registered with us.
                                    </p>
                                    
                                    <button type="button" class="w-auto btn btn-danger nextBtn" id="btnnewnumber">change number</button>
                                </div>
                            </form> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- toggle button -->
    <script>
       

       

      



    </script>
    <!-- otp fildes -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

     <script type="text/javascript">

         const formSections = document.querySelectorAll('.form-section');
         const nextButtons = document.querySelectorAll('.nextBtn');
         const prevButtons = document.querySelectorAll('.prevBtn');

         let currentStep = 0;

         // Show the first step by default
         formSections[currentStep].classList.add('active');

         // Function to show the next step
         const showNextStep = () => {
             formSections[currentStep].classList.remove('active');
             formSections[currentStep + 1].classList.add('active');
             currentStep++;
         };

         // Function to show the previous step
         const showPrevStep = () => {
             formSections[currentStep].classList.remove('active');
             formSections[currentStep - 1].classList.add('active');
             currentStep--;
         };

         //nextButtons.forEach((button, index) => {
         //    button.addEventListener('click', showNextStep);
         //});

         //prevButtons.forEach((button, index) => {
         //    button.addEventListener('click', showPrevStep);
         //});

         $(document).ready(function () {

            

             $("#btnotp").click(function () {
                
              
                debugger;
                $.ajax({
                    type: "POST",
                   

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=Deleteotpsend&mobile=' + $('#mobilenumber').val(),
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (data == "2")
                        {
                            
                            $("#step1").hide();
                            $("#DivInvailid").show();
                            alter("Sorry! You are not Registered with us.");
                           

                        }
                        else
                        {

                            var text = $('#mobilenumber').val();
                            //...and put it in the div:
                            $('#lblMobile').html(text);
                           
                            showNextStep();
                           
                           
                        }

                        $('#progress').hide();
                    },
                });
             });

             $("#btnresendOTP").click(function () {


                 debugger;
                 $.ajax({
                     type: "POST",


                     url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=Deleteotpsend&mobile=' + $('#mobilenumber').val(),
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (data == "2") {
                            toastr.error("Sorry! You are not Registered with us.");

                        }

                        $('#progress').hide();
                    },
                });
             });

             $("#btnDelete").click(function () {


                 debugger;
                 $.ajax({
                     type: "POST",


                     url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=DeleteAccount_OTPVerify&mobile=' + $('#mobilenumber').val() + '&verifycode=' + $('#otp1').val() + $('#otp2').val() + $('#otp3').val() + $('#otp4').val(),
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (data != "Success") {
                            toastr.error("Sorry! You are not Registered with us.");

                        }
                        else {

                           
                            showNextStep();
                        }

                        $('#progress').hide();
                    },
                });
             });

             $("#btnOK").click(function () {

                 window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/login.aspx";

             });
             $("#btnverifyotp").click(function () {

                 showNextStep();

             });



             $("#btnnewnumber").click(function () {

                 $("#DivInvailid").hide();
                 $("#step1").show();

                 window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/DeleteAccount.aspx";

             });

             $("#btnchangenumber").click(function () {

                 showPrevStep();
                
             });

             $("#btncancel").click(function () {

                 showPrevStep();

             });

          });
     </script>
    <script>
        const otpFields = document.querySelectorAll('.otpField');
        otpFields.forEach((field, index) => {
            field.addEventListener('input', (e) => {
                const input = e.target.value;
                if (input.length === 1) {
                    if (index !== otpFields.length - 1) {
                        otpFields[index + 1].focus();
                    }
                }
            });

            field.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && index !== 0 && field.value === '') {
                    otpFields[index - 1].focus();
                }
            });
        });
    </script>
    <!--  -->
    <!-- js -->
    <script src="assests/js/"></script>
   
</body>
</html>
