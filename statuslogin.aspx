<%@ Page Language="C#" AutoEventWireup="true" CodeFile="statuslogin.aspx.cs" Inherits="statuslogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registration Form</title>
    <!-- css -->
    <link rel="stylesheet" href="statuslogin/assets/css/css.css" />
    <link rel="stylesheet" href="statuslogin/assets/css/responsive.css" />
    <link rel="stylesheet" href="statuslogin/assets/css/style.css" />
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
  <%--  <form id="form1" runat="server">--%>
        <section class="user-form">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mx-auto">
                    <div class="web-heading">
                        <h1>Login Form</h1>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <form id="form22" runat="server" action="" onsubmit="return validateForm()">
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
<%--    </form>--%>
</body>
</html>
