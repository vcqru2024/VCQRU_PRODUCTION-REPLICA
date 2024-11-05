<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="ZYDEX_Login" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zydex Login</title>
    <!-- css -->
    <link rel="stylesheet" href="assets/css/css.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- icon -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
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
</head>

<body>
    <section class="login-page">
        <div class="top-header">
            <div class="container">
                <h5>Zydex Track & Trace Solution</h5>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <img src="assets/img/logo.svg" alt="logo" class="logo">
                            <h5 class="card-title">Hey, Welcome back!</h5>
                            <p class="card-text">Enter your details to log in to your Zydex Dashboard account.</p>
                            <form runat="server" class="needs-validation" novalidate>
                                <div
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                                    <div class="col">
                                        <label for="Username" class="form-label">Username<span>*</span></label>
                                        <asp:TextBox ID="txtusername" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div class="invalid-feedback">
                                            Please enter a username.
                                       
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="Password" class="form-label">Password<span>*</span></label>
                                        <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div class="invalid-feedback">
                                            Please enter a password.
                                        </div>
                                    </div>
                                    <div class="col">
                                       <asp:Button ID="btnlogin" Text="Login" OnClick="btnlogin_Click" runat="server" CssClass="btn" />
                                    </div>
                                    <div class="col">
                                        <div class="for-support">
                                            <hr>
                                            <span>For support</span>
                                            <ul>
                                                <li>
                                                    <i class="bx bxs-phone-call"></i>
                                                    <a href="tel:9355903128">+91-9355903128</a>

                                                </li>
                                                <li>
                                                    <i class="bx bxs-envelope"></i>
                                                    <a href="mailto:keshav@vcqru.com ">keshav@vcqru.com </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="footer">
        <div class="container">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                <div class="col">
                    <p>Copyright © 2024 Zydex Group. All Rights Reserved.</p>
                </div>
                <div class="col text-md-end">
                    <p>Designed and Developed by VCQRU Private Limited.</p>
                </div>
            </div>
        </div>
    </div>
   

</body>

</html>
