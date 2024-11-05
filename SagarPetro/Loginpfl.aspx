<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Loginpfl.aspx.cs" Inherits="Patanjali_Loginpfl" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login</title>
        <!-- Bootstrap css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <!-- css -->
        <link href="assets/css/css.css" rel="stylesheet" />
        <link href="assets/css/reponsive.css" rel="stylesheet" />
        <!-- font family -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <!-- font-awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="../Content/js/jquery-1.11.1.min.js"></script>
      
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


       <script>
           function ShowProgress() {
               
               $("#overlay").fadeIn(300);
           };

           function HideProgress() {
               $("#overlay").fadeOut(300);
           };

           var cnt = 0;
           var mblno;

           function otpsend() {
               ShowProgress();
               $.ajax({
                   type: "POST",
                   contentType: false,
                   processData: false,
                   url: '../Info/PatanjaliHandler.ashx?method=otpsendforpfl&Email=' + $('#txtUserName').val(),
                   success: function (data) {
                       HideProgress();
                       if (data == "Otp Send Successfully") {
                           showAlert('Success', data, 'success');
                       } else {
                           showAlert('Error', data, 'error');
                       }
                   }
               });
           };

           function forgotpassword(element) {
               ShowProgress();
               $.ajax({
                   type: "POST",
                   contentType: false,
                   processData: false,
                   url: '../Info/PatanjaliHandler.ashx?method=ForgotPassword&Email=' + $('#txtUserName').val(),
                   success: function (data) {
                       HideProgress();
                       if (data == "Password Send On Registered Email Id") {
                           $('#forgotp').css('display', 'none');
                           showAlert('Success', data, 'success');
                       } else {
                           showAlert('Error', data, 'error');
                       }
                   }
               });
           }

    // function showAlert(title, message, type) {
    //     alert(title + ': ' + message);
    // }

       </script>

    </head>

    <body class="bg-light">
         <div id="overlay">
        <div class="cv-spinner">
            <span class="spinner"></span>
        </div>
    </div>
        <!-- top-bar -->
       <%-- <div class="update-msg alert alert-dismissible fade show" role="alert">
            <div class="container">
                <marquee behavior="" direction="" onmouseover="this.stop();" onmouseout="this.start();">
                    The
                    authenticity check for the products will only be
                    considered
                    genuine when checked
                    through SAGAR PETROLEUMS PRIVATE LIMITED domain <a href="https://www.deltaindia.com/"
                        target="_blank">deltaindia.com</a></marquee>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                    <i class='bx bxs-x-circle'></i>
                </button>
            </div>
        </div>--%>
        <!-- top-bar-end -->
        <!-- login card -->
        <section class="login-ui">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-4 col-xl-4 col-lg-5 col-md-8 mx-auto">
                        <div class="card">
                            <div class="card-body">
                                <div class="patanjaliayurved">
                                    <img src="img/sagarlogo.png" alt="logo" class="patanjali-logo" />
                                </div>
                                <h5 class="card-title">Hey, welcome to SAGAR PETROLEUMS PRIVATE LIMITED!</h5>
                                <p class="card-text">
                                    Welcome to the official page of the SAGAR PETROLEUMS PRIVATE LIMITED Product Authenticity
                                    Login Portal.
                                </p>
                                <div class="login-tab">
                                    <form runat="server" class="needs-validation" novalidate>
                                        <div
                                            class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                                            <div class="col">
                                                <label for="userName" class="form-label">User
                                                    Email<span>*</span></label>
                                                <asp:TextBox ID="txtUserName" textMode="Email" autocomplete="off"
                                                    CssClass="form-control" runat="server"
                                                    placeholder="user@example.com"
                                                    pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                                                    required>
                                                </asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Please enter valid user email
                                                </div>
                                            </div>
                                            <div class="col">
                                                <label for="txtpassword"
                                                    class="form-label">password/OTP<span>*</span></label>
                                                <asp:TextBox ID="txtpassword" TextMode="Password" runat="server"
                                                    MaxLength="15" CssClass="form-control" autocomplete="off"
                                                    placeholder="******" required>
                                                </asp:TextBox>
                                                <div class="invalid-feedback">
                                                    Enter password
                                                </div>
                                             <%--   <p class="card-text mb-0 mt-1 fs-12">
                                                    <a href="#" id="getotp" onclick="otpsend();">Click to Get One-Time
                                                        Password(OTP)</a>
                                                </p>--%>
                                            </div>
                                            <div class="col">
                                                <asp:Button ID="btnlogin" runat="server" OnClick="btnlogin_Click"
                                                    CssClass="btn" Text="Submit" />
                                            </div>
                                            <div class="col">
                                                <p class="text-center card-text"><a href="#" id="forgotp"
                                                        onclick="forgotpassword(this);">Forgot Password</a></p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- footer -->
        <footer class="footer fixed-bottom">
            <div class="container">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                    <div class="col">
                        <p class="text-md-start text-center">© 2024 SAGAR PETROLEUMS PRIVATE LIMITED..</p>
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
        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- validtion js -->
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (() => {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                const forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
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
    </body>
    </html>