<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ihff-contact-form.aspx.cs" Inherits="ihff_contact_form" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>IHFF</title>
        <!-- css -->
        <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' rel='stylesheet' />
        <!--font aewsome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
            integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet' />
        <!-- font-family -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet" />


        <style>
            /* body {
                background-color: skyblue !important;
            } */

            * {
                box-sizing: border-box;
                padding: 0;
                margin: 0;
            }

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
                font-family: 'Poppins', sans-serif !important;
                background: url(./bg.png);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                min-height: 100vh;
            }

            .form-label {
                font-size: 14px;
                font-weight: 600;
                text-transform: capitalize;
            }

            .form-label span {
                color: var(--bs-danger);
            }

            .form-control {
                border-radius: 2px !important;
            }

            /* top-bar */
            .topbar-nav {
                position: sticky;
                top: 0;
                background-color: #160a54;
                z-index: 1000;
            }

            .topbar-nav .navbar {
                padding: 0;
            }

            .topbar-nav .navbar .navbar-nav .nav-item .nav-link {
                display: flex;
                align-items: center;
                gap: 0.25rem;
                font-weight: 500;
                color: var(--bs-light);
            }

            .topbar-nav .navbar .navbar-brand img {
                height: 4rem;
            }

            .topbar-nav .navbar .navbar-nav {
                gap: 1rem;
            }

            /* loader */
            #loader-wrapper {
                position: fixed;
                width: 100%;
                height: 100%;
                left: 0;
                top: 0;
                background: rgba(255, 255, 255, 0.8);
                z-index: 1000000;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            #loader {
                border: 8px solid #f3f3f3;
                border-top: 8px solid var(--bs-primary);
                border-radius: 50%;
                width: 50px;
                height: 50px;
                animation: spin 1s linear infinite;
            }

            /* head-form */
            .head-form {
                /* margin: 2rem 0; */
            }

            .head-form .form-card {
                margin: 2rem 0;
            }

            .head-form .form-card .card {
                border-radius: var(--bs-border-radius-lg);
                border: 2px solid rgba(255, 255, 255, 0.24);
                background-color: rgba(255, 255, 255, 0.08);
                backdrop-filter: blur(2px);
                /* box-shadow: 0 4px 20px #2538581a; */
            }

            .head-form .form-card .card .card-body {
                padding: 1.5rem;
            }

            .head-form .form-card .card .card-body .card-title {
                color: var(--bs-white);
            }

            .head-form .form-card .card .card-body .btn {
                border-radius: 2px;
                text-transform: uppercase;
                font-weight: 500;
            }

            .head-form .call-out-points ul li img {
                height: 4rem;
                border-radius: var(--bs-border-radius-sm);
            }

            .head-form .call-out-points ul li h4 {
                margin-bottom: 0.25rem;
                font-weight: 600;
            }

            .head-form .call-out-points ul li p {
                color: var(--bs-secondary);
                margin-bottom: 0;
            }

            .head-form .call-out-points ul {
                padding: 0;
                list-style: none;
                margin: 0;
                display: flex;
                gap: 1rem;
                width: 100%;
            }

            .call-out-points {
                padding: 2rem 0;
            }

            .head-form .form-card .card .card-body .form-label {
                color: var(--bs-white);
            }

            .head-form .form-card .card .card-body .form-control {
                background-color: transparent;
                color: var(--bs-light);
            }

            .head-form .form-card .card .card-body .form-control:focus {
                box-shadow: 0 0 0 .25rem rgb(255 255 255 / 25%);
            }

            /* footer */
            .footer {
                background-color: var(--bs-black);
                padding: 0.25rem 0;
                /* position: fixed;
                bottom: 0; */
                width: 100%;
            }

            .footer p {
                margin-bottom: 0;
                text-align: center;
                color: var(--bs-white);
                font-size: 14px;
            }
            .left-content {
                color: var(--bs-white);
                margin-top: 2rem;
            }

            .left-content h1 {
                font-weight: 600;
                margin-bottom: 1rem;
                /* line-height: 1.5; */
            }

            .left-content p {
                margin-bottom: 0;
            }

            /* repsonsive */

            @media screen and (max-width:768px) {
                .topbar-nav .navbar .navbar-nav {
                    gap: 0;
                }

                .topbar-nav .navbar .navbar-nav .nav-item .nav-link {
                    padding: 0;
                }
            }

            @media screen and (max-width:425px) {}
        </style>
    </head>

    <body>
        <!-- loader -->
        <div id="loader-wrapper">
            <div id="loader"></div>
        </div>
        <!-- top-bar -->
        <div class="topbar-nav">
            <div class="container">
                <nav class="navbar navbar-expand-lg">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="iplcm-expo-event.html">
                            <img src="./white_logo.png" alt="Logo">
                        </a>
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="tel:+91 124 5181074">
                                    <i class="bx bxs-phone-call"></i>
                                    +91 124 5181074
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="mailto:sales@vcqru.com">
                                    <i class="bx bxs-envelope"></i>
                                    sales@vcqru.com
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!-- end -->
        <section class="head-form">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-7 col-xl-6 col-lg-6 col-md-12 order-lg-1 order-2">
                        <div class="left-content">
                            <h1>VCQRU - Your Trusted Partner in <br> Anti-Counterfeit Protection</h1>
                            <p>At VCQRU Pvt Ltd, we leverage cutting-edge technology to safeguard your brand and ensure
                                your products reach customers in their authentic form. Trust us to defend your business
                                against counterfeit threats with our comprehensive and scalable solutions.</p>
                            <div class="text-center">
                                <img src="./protien.png" alt="" class="img-fluid">
                            </div>
                        </div>
                    </div>
                    <div class="col-xxl-4 col-xl-4 col-lg-6 col-md-12 offset-xl-1 order-lg-2 order-1">
                        <div class="form-card">
                            <div class="card">
                                <div class="card-body">
                                    <form action="" novalidate id="myFormContact" method="post" class="needs-validation">
                                        <div
                                            class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                                            <div class="col">
                                                <label for="name" class="form-label">Full Name<span>*</span></label>
                                                <input type="text" class="form-control" id="name" name="name" value=""
                                                    pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                                <div class="invalid-feedback">Please enter your name.</div>
                                            </div>
                                            <div class="col">
                                                <label for="Designation"
                                                    class="form-label">Designation<span>*</span></label>
                                                <input type="text" class="form-control" id="Designation"
                                                    name="Designation" value="" required>
                                                <div class="invalid-feedback">Please enter Designation.</div>
                                            </div>
                                            <div class="col">
                                                <label for="email" class="form-label">Email
                                                    Address<span>*</span></label>
                                                <input type="email" name="email" class="form-control" id="email"
                                                    autocomplete="off" required>
                                                <div class="invalid-feedback">Please enter valid email address </div>

                                            </div>
                                            <div class="col">
                                                <label for="mobile" class="form-label">Phone
                                                    Number<span>*</span></label>
                                                <input type="number" class="form-control" id="mobile" name="mobile"
                                                    required maxlength="10" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);
                                 if (this.value.length !== 10 || !/^[6-9]\d{9}$/.test(this.value)) this.setCustomValidity('Phone number must be exactly 10 digits and start with a digit between 6 and 9.');
                                 else this.setCustomValidity('');">
                                                <div class="invalid-feedback">Please enter your mobile number.</div>
                                            </div>
                                            <div class="col">
                                                <label for="company_name" class="form-label">Company
                                                    Name<span>*</span></label>
                                                <input type="text" class="form-control" id="company_name"
                                                    name="company_name" value="" required>
                                                <div class="invalid-feedback">Please enter your company name.</div>
                                            </div>
                                            <div class="col">
                                                <label for="city" class="form-label">
                                                    city<span>*</span></label>
                                                <input type="text" class="form-control" id="city" name="city" value=""
                                                    required>
                                                <div class="invalid-feedback">Please enter your city.</div>
                                            </div>
                                            <div class="col d-none">
                                                <label for="ihffevent"
                                                    class="form-label">ihffevent<span>*</span></label>
                                                <input type="text" class="form-control" id="ihffevent" name="ihffevent"
                                                    value="ihffevent" required>
                                                <div class="invalid-feedback">Please enter ihffevent.</div>
                                            </div>
                                            <div class="col">
                                                <button type="button" class="btn btn-primary px-5" onclick="EventForm()">
                                                    Submit</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="call-out-points bg-white">
                <div class="container">
                    <div
                        class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3 justify-content-center">
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/domain-experts.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>100+</h4>
                                        <p>Domain experts</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/client-satisfaction-score.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>4.5/5</h4>
                                        <p>Client satisfaction score</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/loyality-benifit-transfer.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>10Cr+/Mon</h4>
                                        <p>Loyality Benifit Transfer</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/years-of-experience.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>10+</h4>
                                        <p>Years of experience</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/multiple-language-support.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>09</h4>
                                        <p>Multiple Language Support</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/product-counterfeiting-control.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>1k/Min
                                        </h4>
                                        <p>Product Counterfeiting Control</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/manufacturerclients.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>
                                        <h4>600+
                                        </h4>
                                        <p>Brands & Manufacturer Clients</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col d-flex">
                            <ul>
                                <li>
                                    <img src="icon/industries-served-client.svg"
                                        alt="Technology-about">
                                </li>
                                <li>
                                    <div>

                                        <h4>18+
                                        </h4>
                                        <p>Industries Served Client</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        
        </section>
        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <p>© Copyright 2024 VCQRU Private Limited | All Rights Reserved.</p>
            </div>
        </footer>
        <!-- start-code -->
         <script>
             document.getElementById('name').addEventListener('keypress', function (event) {
                 const char = String.fromCharCode(event.which);
                 const namePattern = /^[a-zA-Z\s'-]$/;
                 //alert(char);
                 if (!namePattern.test(char)) {
                     event.preventDefault(); // Prevent the character from being entered
                     //displayErrorMessage('Invalid character: ' + char);
                     return false;
                 } else {
                    // clearErrorMessage();
                 }
             });
             document.getElementById('Designation').addEventListener('keypress', function (event) {
                 const char = String.fromCharCode(event.which);
                 const namePattern = /^[a-zA-Z\s'-]$/;
                 //alert(char);
                 if (!namePattern.test(char)) {
                     event.preventDefault(); // Prevent the character from being entered
                     //displayErrorMessage('Invalid character: ' + char);
                     return false;
                 } else {
                     // clearErrorMessage();
                 }
             });
             document.getElementById('city').addEventListener('keypress', function (event) {
                 const char = String.fromCharCode(event.which);
                 const namePattern = /^[a-zA-Z\s'-]$/;
                // alert(char);
                 if (!namePattern.test(char)) {
                     event.preventDefault(); // Prevent the character from being entered
                     //displayErrorMessage('Invalid character: ' + char);
                     return false;
                 } else {
                     // clearErrorMessage();
                 }
             });

            
    </script>
        <script>

            function EventForm() {

                // Show loading spinner
                document.getElementById('loader-wrapper').style.visibility = 'visible';
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                const phoneRegex = /^\d{10}$/; // Adjust the regex based on your mobile number format
                // Get form values
                //debugger
                var name = document.getElementById('name').value.trim();
                var email = document.getElementById('email').value.trim();
                var mobile = document.getElementById('mobile').value.trim();
                var company_name = document.getElementById('company_name').value.trim();
                var city = document.getElementById('city').value.trim();
                var Designation = document.getElementById('Designation').value.trim();
                var ihffevent = document.getElementById('ihffevent').value.trim();

                // Validate form
                if (name === "" || email === "" || mobile === "" || company_name === "" || city === "" || Designation === "" || ihffevent === "" || !emailRegex.test(email) || !phoneRegex.test(mobile)) {
                    // Hide loading spinner
                    document.getElementById('loader-wrapper').style.visibility = 'hidden';

                    // Show validation styles
                    (() => {
                        'use strict';
                        const forms = document.querySelectorAll('.needs-validation');

                        if (!emailRegex.test(email)) {
                            Array.from(forms).forEach(form => {
                                form.classList.add('was-validated');
                            });
                            return false;
                        }

                        if (!phoneRegex.test(mobile)) {
                            Array.from(forms).forEach(form => {
                                form.classList.add('was-validated');
                            });
                            return false;
                        }

                        Array.from(forms).forEach(form => {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        });
                    })();

                    return false;
                }
                var data = new FormData();
                data.append("name", name);
                data.append("email", email);
                data.append("mobile", mobile);
                data.append("company_name", company_name);
                data.append("city", city);
                data.append("source", "ihffevent");
                data.append("Designation", Designation);

                var xhr = new XMLHttpRequest();
                xhr.withCredentials = true;

                xhr.addEventListener("readystatechange", function () {
                    if (this.readyState === 4) {
                        console.log(this.responseText);
                    }
                });

                xhr.open("POST", "https://www.vcqru.com/info/Masterhandler.ashx?method=ProcessRequestevent");
                // WARNING: Cookies will be stripped away by the browser before sending the request.

                xhr.send(data);
                // Define the callback function when the request is successful
                xhr.onload = function () {
                    // Hide loading spinner
                    document.getElementById('loader-wrapper').style.visibility = 'hidden';
                   // alert(xhr);
                    if (xhr.status === 200) {
                        // Reset form fields to null
                        document.getElementById('myFormContact').reset();
                        // Show SweetAlert for successful form submission
                        Swal.fire({
                            title: 'Submit',
                            text: 'Thank you for submitting your details! We appreciate your interest in our services and look forward to connecting with you soon. ',
                            icon: 'success',
                            confirmButtonText: 'OK'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = './ihff-contact-form.aspx';
                            }
                        });

                        // Remove validation classes
                        //window.location.href ='./ihff-contact-form.aspx'
                        Array.from(forms).forEach(form => {
                            form.classList.remove('was-validated');
                        });

                    } else {
                        Swal.fire({
                            title: 'Error',
                            text: 'There was an error processing your request. Please try again later.',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        });
                    }
                };

                // Define the callback function in case of an error
                xhr.onerror = function (error) {
                    // Hide loading spinner
                    document.getElementById('loader-wrapper').style.visibility = 'hidden';
                    // Show SweetAlert for AJAX error
                    Swal.fire({
                        title: 'Error',
                        text: 'There was an error processing your request. Please try again later.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                };

                // Send the request
                xhr.send();
            }

        </script>


        <script>
            document.onreadystatechange = function () {
                var loaderWrapper = document.getElementById('loader-wrapper');

                // Show loader when the page is still loading
                if (document.readyState === 'loading') {
                    loaderWrapper.style.visibility = 'visible';
                } else {
                    // Hide loader once the page has fully loaded
                    loaderWrapper.style.visibility = 'hidden';
                }
            };
        </script>
        <!-- js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>

    </html>