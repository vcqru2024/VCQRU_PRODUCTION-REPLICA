<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuantiqueLogin.aspx.cs" Inherits="QuantiqueLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registration Form</title>
    <!-- css -->
    <link rel="stylesheet" href="quantique/assets/css/css.css" />
    <link rel="stylesheet" href="quantique/assets/css/responsive.css" />
    <link rel="stylesheet" href="quantique/assets/css/style.css" />
     <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- css-end -->
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet" />
    <!-- font-family-end -->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
    <!-- Boxicons CSS-end -->
    <style>
        h5 {
        }
    </style>
</head>
<body>
    <!-- navbar -->
    <div class="app-navbar">
        <div class="container">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <img src="quantique/assets/img/logo.png" alt="logo">
                    </a>
                    <button class="navbar-toggler bg-white shadow-none" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="tel:9967015695">
                                    <i class='bx bxs-phone-call'></i>
                                    +91 99670 15695
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="mailto:contactus@quantique.ai">
                                    <i class='bx bxs-envelope'></i>
                                    contactus@quantique.ai
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- app-navbar-end -->
    <!-- form -->
    <section class="user-form">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mx-auto">
                    <div class="web-heading">
                        <h1>Login Form</h1>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <form id="form1" runat="server" action="" novalidate class="needs-validation" onsubmit="return validateForm()">
                                <div class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-4">
                                    <div class="col">
                                        <label for="txtUsername" class="form-label">Email Address*</label>
                                        <asp:TextBox ID="txtUsername" TextMode="Email" CssClass="form-control form-control-lg" runat="server" oninput="clearErrorMessage('error_txtUsername')"></asp:TextBox>
                                        <div id="error_txtUsername" class="invalid-feedback d-block"></div>
                                    </div>
                                    <div class="col">
                                        <label for="txtPassword" class="form-label">Password*</label>
                                        <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control form-control-lg" runat="server" oninput="clearErrorMessage('error_txtPassword')"></asp:TextBox>
                                        <div id="error_txtPassword" class="invalid-feedback d-block"></div>
                                    </div>
                                    <div class="col">
                                        <asp:Button ID="btnLogin" runat="server" Text="SIGN IN" CssClass="btn btn-lg w-100" OnClick="btnLogin_Click" />
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="lblMessage" runat="server" Style="color: red" Text="Label" Visible="false"></asp:Label>
                                    </div>
                                </div>
                            </form>

                            <script>
                                $(document).ready(function () {
                                    //// Clear lblMessage on document ready
                                    //$('#lblMessage').text('');

        // Bind input event listener to clear lblMessage on input
        $('#txtUsername, #txtPassword').on('input', function () {
            $('#lblMessage').text(''); // Clear lblMessage on input
        });
    });

                                function validateForm() {
                                    $('#lblMessage').text('');
                                    var username = document.getElementById('<%= txtUsername.ClientID %>').value.trim();
        var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();

                                    // Clear previous error messages
                                    clearErrorMessage('error_txtUsername');
                                    clearErrorMessage('error_txtPassword');

                                    var isValid = true;

                                    // Stop form submission if email field is empty
                                    if (username === '') {
                                        document.getElementById('error_txtUsername').innerText = 'Please enter your email address.';
                                        return false; // Stop form submission
                                    }

                                    // Email validation using regex
                                    var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                    if (!emailRegex.test(username)) {
                                        document.getElementById('error_txtUsername').innerText = 'Please enter a valid email address.';
                                        isValid = false;
                                    }
                                    if (password === '') {
                                        document.getElementById('error_txtPassword').innerText = 'Please enter your password.';
                                        isValid = false;
                                    }

                                    return isValid;
                                }

                                function clearErrorMessage(errorId) {
                                    document.getElementById(errorId).innerText = '';
                                }
                            </script>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- form-end -->
    <!-- footer -->
    <footer class="footer">
        <div class="container">
            <p>Copyright © 2024 QUANTIQUE METADATA PRIVATE LIMITED</p>
        </div>
    </footer>
    <!-- footer-end -->
    <!-- js -->
   <%-- <script src="assets/js/index.js"></script>--%>
    <!-- validation -->
    <script>
        //// Example starter JavaScript for disabling form submissions if there are invalid fields
        //(() => {
        //    'use strict'

        //    // Fetch all the forms we want to apply custom Bootstrap validation styles to
        //    const forms = document.querySelectorAll('.needs-validation')

        //    // Loop over them and prevent submission
        //    Array.from(forms).forEach(form => {
        //        form.addEventListener('submit', event => {
        //            if (!form.checkValidity()) {
        //                event.preventDefault()
        //                event.stopPropagation()
        //            }

        //            form.classList.add('was-validated')
        //        }, false)
        //    })
        //})()
    </script>
</body>
</html>
