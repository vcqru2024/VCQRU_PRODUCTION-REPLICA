<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgotpasswordpfl.aspx.cs" Inherits="Patanjali_forgotpasswordpfl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patanjali</title>
    <!-- Bootstrap css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- css -->
    <link rel="stylesheet" href="../Patanjali/assets/css/css.css">
    <link rel="stylesheet" href="../Patanjali/assets/css/reponsive.css">
    <!-- font family -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript">
        function showAlert(title, text, icon, redirectUrl) {
            Swal.fire({
                title: title,
                text: text,
                icon: icon,
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed && redirectUrl) {
                    window.location.href = redirectUrl;
                }
            });
        }

        function forgotpassword() {
           var UserID= $('#txtUserName').val().trim();
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '../Info/PatanjaliHandler.ashx?method=ForgotPassword&Email=' + UserID,
                success: function (data) {
                    if (data == "Password Send On Registered Email Id") {
                        showAlert('Success', data, 'success',"../Patanjali/Loginpfl.aspx");
                    }
                    else {
                        showAlert('Error', data, 'error');
                    }

                }
            });
        }

        $('#btnNext').click(function () {
            window.location.href = 'https://tigercoat.co.in/';
        });
    </script>
</head>

<body class="bg-light">
    <!-- top-bar -->
    <div class="update-msg alert alert-dismissible fade show" role="alert">
        <div class="container">
            <div class="row align-items-center g-1">
                <div class="col-xxl-1 col-xl-2 col-lg-2 col-md-2 col-3">
                    <button type="button" class="btn btn-light btn-sm">
                        update
                    </button>
                </div>
                <div class="col-xxl-11 col-xl-10 col-lg-10 col-md-10 col-9">
                    <marquee behavior="" direction="" onmouseover="this.stop();" onmouseout="this.start();">The
                        authenticity check for the products will only be
                        considered
                        genuie when checked
                        through Patanajli domain <a href="https://www.patanjaliayurved.net/"
                            target="_blank">patanjaliayurved.net</a></marquee>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
                <i class='bx bxs-x-circle'></i>
            </button>
        </div>
    </div>
    <!-- top-bar-end -->
    <!-- login card -->
    <section class="login-ui">
        <div class="container">
            <div class="row">
                <div class="col-xxl-4 col-xl-4 col-lg-5 col-md-8 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <div class="patanjaliayurved">
                                <img src="../Patanjali/assets/img/logo.svg" alt="logo" class="patanjali-logo">
                            </div>
                            <div class="login-tab" id="lg-liv">
                                <h5 class="card-title">Forget Password!</h5>
                                <p class="card-text">Enter your mail ID to know your password.</p>
                                <form action=""
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3 needs-validation"
                                    novalidate>
                                    <div class="col">
                                        <label for="userName" class="form-label">Email ID<span>*</span></label>
                                        <input type="text" class="form-control" id="txtUserName" 
                                            placeholder="user@example.com" required>
                                        <div class="invalid-feedback">
                                            Required
                                        </div>
                                    </div>

                                    <div class="col">
                                        <button type="button" id="btnforgotpassword" onclick="forgotpassword();" class="btn">submit</button>
                                        
                                    </div>
                                </form>
                            </div>
                            <div class="login-tab" id="fp-liv" style="display: none;">
                                <div class="success-icon">
                                    <img src="img/Animation - 1713875681199.gif" alt="">
                                </div>
                      
                                <p class="card-text">Your Password has been sent to your Email Id.</p>
                                <a href="">Back to login <i
                                    class="fa-solid fa-arrow-right"></i></a>
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
                    <p class="text-md-start text-center">© 2024 Patanjali Ayurved Limited All Rights Reserved.</p>
                </div>
                <div class="col">
                    <p class="text-md-end text-center">Design and development by <a href="https://www.vcqru.com/"
                            target="_blank">VCQRU
                            Private Limited.</a></p>
                </div>
            </div>
        </div>
    </footer>
    <!-- footer-end -->
    <!-- js -->
    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('login').addEventListener('click', function () {
            // Hide login-ui and show fp-ui
            document.getElementById('lg-liv').style.display = 'none';
            document.getElementById('fp-liv').style.display = 'block';
        });

       
    </script>
</body>
</html>
