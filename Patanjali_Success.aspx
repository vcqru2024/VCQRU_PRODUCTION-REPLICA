<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Patanjali_Success.aspx.cs" Inherits="Patanjali_Success" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Patanjali</title>
        <!-- bootstrap css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
        <!-- css -->
        <link rel="stylesheet" href="../Patanjali/assets/css/css.css" />
        <link rel="stylesheet" href="../Patanjali/assets/css/reponsive.css" />
        <!-- font family -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet" />
        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
        <!-- owl -->
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script type="text/javascript" language="javascript">

            function DisableBackButton() {
                window.history.forward()
            }
            DisableBackButton();
            window.onload = DisableBackButton;
            window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
            window.onunload = function () { void (0) }


           
            var lat = "";
            var long = "";
           
            var getPosition = function (options) {
                return new Promise(function (resolve, reject) {

                    debugger;
                    navigator.geolocation.getCurrentPosition(resolve, reject, options);


                }
                );
            }

            $(document).ready(function () {

                firstfunction();
            });


            async function firstfunction() {

                debugger;
                if (navigator.geolocation) {
                    await getPosition()
                        .then((position) => {


                            
                            $('#lat').val(position.coords.latitude);
                            $('#long').val(position.coords.longitude);
                            var latitude = position.coords.latitude;
                            var longitude = position.coords.longitude;
                            lat = latitude;
                            long = longitude;

                           
                        })
                        .catch((err) => {

                            //$('#divpincode').show();
                            console.error(err.message);
                        });
                } else {

                    // x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }
           
        </script>

    </head>
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

    <body class="bg-light">
        <div class="update-msg">
            <div class="container">

                

                <marquee behavior="" direction="" onmouseover="this.stop();" onmouseout="this.start();">
                    The authenticity of the products can only be checked through patanjali domain <a
                        href="https://www.patanjaliayurved.net/" target="_blank">patanjaliayurved.net</a></marquee>
            </div>
        </div>
        <div class="header">
            <div class="container">
                <img src="img/Patanjali_Logo.png" alt="Patanjali_Logo" class="logo">
            </div>
        </div>
        <!--  -->
        <form runat="server">

             <asp:HiddenField ID="long" runat="server" />
                <asp:HiddenField ID="lat" runat="server" />
        </form>
        <section class="sucess-msg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 mx-auto">
                        <div class="card">
                            <div class="card-body">
                                <img id="Image1" runat="server" src="img/success.gif" alt="success.gif" />
                                <h5 class="card-title" id="htitle" runat="server">Success</h5>
                                <p class="card-text" id="ResponseContent" runat="server">Some quick example text to
                                    build on the card title and make up the bulk
                                    of the
                                    card's content.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- You can purchase from our other products range! -->
        <div class="patanjali-products">
            <div class="container">
                <div class="section-title">
                    <h2>Discover more authentic products from Patanjali here</h2>
                </div>
                <div class="owl-carousel">
                    <div class="item">
                        <div class="card">
                            <div class="card-body">
                                <div class="row g-0">
                                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-8 col-8 d-flex">
                                        <div class="w-100">
                                            <h6>Natural Health Care</h6>
                                            <h5 class="card-title">Patanjali Cow's Ghee</h5>
                                            <h5 class="card-title">(1ltr)</h5>
                                            <p class="card-text">In India, ghee has a sacred significance and is
                                                considered a traditional symbol of auspiciousness and sound
                                                well-being...</p>
                                            <div>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star-half'></i>
                                                <span>45 Reviews</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-4 col-4 d-flex">
                                        <a href="https://www.patanjaliayurved.net/product/natural-health-care/ghee/patanjali-cows-ghee/806"
                                            target="_blank" class="stretched-link">
                                            <img src="https://www.patanjaliayurved.net/assets/product_images/400x500/1692619002Ghee1LTR1.png"
                                                alt="product-one" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="card">
                            <div class="card-body">
                                <div class="row g-0">
                                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-8 col-8 d-flex">
                                        <div class="w-100">
                                            <h6>Natural Health Care</h6>
                                            <h5 class="card-title">Aastha Cow Ghee</h5>
                                            <h5 class="card-title">(200 ml)</h5>
                                            <p class="card-text">Aastha pure cow's desi ghee makes your worship
                                                meaningful, the fragrance of its purity gives the power of Satvik energy
                                                to your...</p>
                                            <div>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star-half'></i>
                                                <span>21 Reviews</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-4 col-4 d-flex">
                                        <a id="productone" runat="server"
                                            href="https://www.patanjaliayurved.net/product/herbal-home-care/pooja-essentials/aastha-cow-ghee/1528"
                                            target="_blank" class="stretched-link">
                                            <img src="https://www.patanjaliayurved.net/assets/product_images/400x500/1688793287AasthaGhee200g1.png"
                                                alt="product-one" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="card">
                            <div class="card-body">
                                <div class="row g-0">
                                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-8 col-8 d-flex">
                                        <div class="w-100">
                                            <h6>Natural Health Care</h6>
                                            <h5 class="card-title">Aastha Cow Ghee</h5>
                                            <h5 class="card-title">(750 ml)</h5>
                                            <p class="card-text">Aastha pure cow's desi ghee makes your worship
                                                meaningful, the fragrance of its purity gives the power of Satvik energy
                                                to your...</p>
                                            <div>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star-half'></i>
                                                <span>47 Reviews</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-4 col-4 d-flex">
                                        <a id="producttwo" runat="server"
                                            href="https://www.patanjaliayurved.net/product/herbal-home-care/pooja-essentials/aastha-cow-ghee/4046"
                                            target="_blank" class="stretched-link">
                                            <img src="https://www.patanjaliayurved.net/assets/product_images/400x500/1675055333400x500.jpg"
                                                alt="product-one" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="card">
                            <div class="card-body">
                                <div class="row g-0">
                                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-8 col-8 d-flex">
                                        <div class="w-100">
                                            <h6>Natural Health Care</h6>
                                            <h5 class="card-title">Desi Ghee</h5>
                                            <h5 class="card-title">(500 ml)</h5>
                                            <p class="card-text">Aastha pure cow's desi ghee makes your worship
                                                meaningful, the fragrance of its purity gives the power of Satvik energy
                                                to your...</p>
                                            <div>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star-half'></i>
                                                <span>35 Reviews</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-4 col-4 d-flex">
                                        <a id="productthree" runat="server"
                                            href="https://www.patanjaliayurved.net/product/natural-health-care/ghee/desi-ghee/4218"
                                            target="_blank" class="stretched-link">
                                            <img src="https://www.patanjaliayurved.net/assets/product_images/400x500/1694089043DesiGhee1ltr1.png"
                                                alt="product-one" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="card">
                            <div class="card-body">
                                <div class="row g-0">
                                    <div class="col-xxl-7 col-xl-7 col-lg-7 col-md-8 col-8 d-flex">
                                        <div class="w-100">
                                            <h6>Natural Health Care</h6>
                                            <h5 class="card-title">AASTHA GHEE BATTI - 80N</h5>
                                            <h5 class="card-title">(167 G)</h5>
                                            <p class="card-text">
                                                AASTHA GHEE BATTI - 80N</p>
                                            <div>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star'></i>
                                                <i class='bx bxs-star-half'></i>
                                                <span>15 Reviews</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xxl-5 col-xl-5 col-lg-5 col-md-4 col-4 d-flex">
                                        <a id="productfour" runat="server"
                                            href="https://www.patanjaliayurved.net/product/herbal-home-care/pooja-essentials/aastha-ghee-batti-80n/4418"
                                            target="_blank" class="stretched-link">
                                            <img src="https://www.patanjaliayurved.net/assets/home_images/sample.jpg"
                                                alt="product-one" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
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
        <!-- chat box -->
        <div class="main-chat-box">
            <button class="open-chat-button btn btn-light" type="button" data-bs-toggle="modal"
                data-bs-target="#exampleModal">
                <img src="../assets/images/patanjali/img/chat-icon.svg" id="chat-icon">
            </button>
            <div class="modal fade" id="exampleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-sm modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header py-2">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Send us a Message</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form id="exampleModalform" class="needs-validation" enctype="multipart/form-data" novalidate>
                            <div class="modal-body">
                                <div
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-1">
                                    <div class="col">
                                        <label for="name" class="form-label">Name<span>*</span></label>
                                        <input type="text" id="name" class="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" placeholder="Enter Name" required>
                                        <div class="invalid-feedback">
                                            Enter valid name
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="mob" class="form-label">Mobile No<span>*</span></label>
                                        <input type="number" class="form-control" maxlength="10" id="mob"
                                            placeholder="920XX77XX6"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            required>
                                        <div class="invalid-feedback">
                                            Enter valid mobile number
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="email" class="form-label">Email Address<span>*</span></label>
                                        <input type="email" class="form-control" id="email"
                                            placeholder="example@xyz.com" required>
                                        <div class="invalid-feedback">
                                            Enter a valid email address.
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="city" class="form-label">City<span>*</span></label>
                                        <input type="text" class="form-control" id="city"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" placeholder="Gurugram" required>
                                        <div class="invalid-feedback">
                                            Enter valid city
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="uploadCoupon" class="form-label">Upload coupon</label>
                                        <input type="file" name="image" class="form-control" id="uploadCoupon"
                                            placeholder="" style="background-image: none;">
                                        <div class="invalid-feedback">
                                            Please Upload coupon
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="enquiry" class="form-label">Enquiry<span>*</span></label>
                                        <textarea class="form-control" id="enquiry" rows="1" required></textarea>
                                        <div class="invalid-feedback">
                                            Enter valid message
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer pt-0 border-0">
                                <button type="submit" class="btn btn-primary w-100">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- bootstrap js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Include jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- Include Owl Carousel JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
        <script>
            function showAlert(title, text, icon) {
                Swal.fire({
                    title: title,
                    text: text,
                    icon: icon,
                    confirmButtonText: 'OK'
                });
            }

            $(document).ready(function () {
                // Attach a submit event listener to the form
                $('#exampleModalform').submit(function (e) {
                    e.preventDefault(); // Prevent the default form submission behavior

                    // Show the loader overlay
                    $('#overlay').show();

                    // Validate the form
                    if (!this.checkValidity()) {
                        // If the form is invalid, hide the loader and show the validation feedback
                        $('#overlay').hide();
                        $(this).addClass('was-validated');
                        return;
                    }

                    // Prepare form data using FormData object to handle file upload
                    var formData = new FormData();
                    formData.append('Name', $('#name').val());
                    formData.append('city', $('#city').val());
                    formData.append('mobile', $('#mob').val());
                    formData.append('useremail', $('#email').val());
                    formData.append('image', $('#uploadCoupon')[0].files[0]); // Use files array to get the selected file
                    formData.append('enquiry', $('#enquiry').val());
                    formData.append('userid', 'Dipak Tiwari');
                    formData.append('email', 'dipak.tiwari@vcqru.com'); // You can set a default email here or get it from another source

                    // Make a POST request using AJAX
                    $.ajax({
                        type: 'POST',
                        url: 'Info/PatanjaliHandler.ashx?method=PatanjaliContactus',
                        data: formData,
                        contentType: false, // Set to false when sending FormData object
                        processData: false, // Set to false when sending FormData object
                        success: function (data) {
                            // Handle success response
                            console.log('Inquiry submitted successfully');
                            // Close the modal form
                            $('#exampleModal').modal('hide');
                            // Clear all input fields
                            $('#exampleModalform')[0].reset();
                            // Show a success message using SweetAlert
                            showAlert('Success!', 'Your Enquiry has been submitted successfully.', 'success');
                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error('Failed to submit inquiry:', error);
                            // Show an error message using SweetAlert
                            showAlert('Error!', 'Failed to submit your inquiry. Please try again later.', 'error')
                        },
                        complete: function () {
                            // Hide the loader overlay when the AJAX request is complete
                            $('#overlay').hide();
                        }
                    });
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                $('.owl-carousel').owlCarousel({
                    loop: true,
                    margin: 10,
                    nav: true,
                    autoplay: true, // Enable autoplay
                    autoplayTimeout: 20000, // Autoplay interval in milliseconds
                    autoplayHoverPause: true, // Pause autoplay when hovering over carousel
                    responsive: {
                        0: {
                            items: 1
                        },
                        600: {
                            items: 2
                        },
                        1000: {
                            items: 3
                        }
                    }
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                $('.stretched-link').click(function (e) {
                    e.preventDefault(); // Prevent default action of anchor tag
                    var href = $(this).attr('href');

                    debugger;
                    // Make AJAX call
                    $.ajax({

                        type: "POST",
                        url: "Patanjali_Success.aspx/HandleImageClick",
                        data: JSON.stringify({ href: href, lat: lat, longitude:long}),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {

                            // Redirect to the href URL after successful AJAX call
                            window.location.href = href;
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                        }
                    });
                });
            });

        </script>
    </body>

    </html>