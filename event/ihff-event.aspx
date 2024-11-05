<%@ Page Title="VCQRU Participating In IHFF Expo 2024" Language="C#" MasterPageFile="~/event/event-layout.master"
    AutoEventWireup="true" CodeFile="ihff-event.aspx.cs" Inherits="event_ihff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="services-details-header">
        <div class="container">
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Default.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="../news-event.aspx">News Event</a></li>
                        <li class="breadcrumb-item active" aria-current="page">VCQRU Participating In IHFF Expo 2024</li>
                    </ol>
                </nav>
            </div>
            <!-- end -->
            <div class="row g-4">
                <div class="col-xxl-6 col-xl-6 col-lg-6 order-lg-1 order-2">
                    <h1 class="fs-1">VCQRU
                        <br>
                        Participating In IHFF
                        <br>
                        Expo 2024</h1>
                    <h5>Hurry up!</h5>
                    <p>
                        Discover the forefront of healthcare innovation at the International Health & Fitness
                            Festival (IHFF) in Delhi! We're excited to invite you to Booth No: 64, where you'll be a
                            part of an expo that brings together over 500+ top global healthcare brands and service
                            providers. This expo is your gateway to the latest advancements and trends in healthcare
                            services and products.
                    </p>
                </div>
                <div class="col-xxl-6 col-xl-6 col-lg-6 order-lg-2 order-1">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Submit your details to confirm your attendance at the IHFF Expo
                                    2024</h5>
                            <!-- form -->
                            <form action="" novalidate id="myForm" method="post" class="needs-validation">
                                <div
                                    class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                                    <div class="col">
                                        <label for="fullName" class="form-label">Full Name<span>*</span></label>
                                        <input type="text" class="form-control" id="fullName" name="fullName"
                                            value="" pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="emailID" class="form-label">Email Address<span>*</span></label>
                                        <input type="email" name="emailID" class="form-control" id="emailID"
                                            autocomplete="off" minlength="8" maxlength="40"
                                            onkeypress="return validateEmail(event)"
                                            oninput="validateInputMail(this)" pattern="[a-z0-9._-]{2,}$"
                                            title="Please enter valid email address" required>
                                        <div class="invalid-feedback">Please enter valid email address </div>

                                    </div>
                                    <div class="col">
                                        <label for="phoneRpf" class="form-label">Phone Number<span>*</span></label>
                                        <input type="number" class="form-control" id="phoneRpf" name="phoneRpf" required maxlength="10"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);
                         if (this.value.length !== 10 || !/^[6-9]\d{9}$/.test(this.value)) this.setCustomValidity('Phone number must be exactly 10 digits and start with a digit between 6 and 9.');
                         else this.setCustomValidity('');">
                                        <div class="invalid-feedback">Please enter your mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="compname" class="form-label">Company Name<span>*</span></label>
                                        <input type="text" class="form-control" id="compname" name="compname"
                                            value="" required>
                                        <div class="invalid-feedback">Please enter your company name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="visitor" class="form-label">
                                            No .of
                                                Visitors<span>*</span></label>
                                        <input type="number" class="form-control" id="visitor" name="visitor"
                                            value="" pattern="[1-10 ]+" maxlength="04" required>
                                        <div class="invalid-feedback">Please enter your No of visitors.</div>
                                    </div>
                                    <div class="col d-none">
                                        <label for="eventname" class="form-label">
                                            No .of
                                                Visitors<span>*</span></label>
                                        <input type="text" class="form-control" id="eventname" name="eventname"
                                            value="" required>
                                        <div class="invalid-feedback">Please enter Exhibition Name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="" class="form-label text-white">.</label><br>
                                        <button type="button" class="btn btn-primary px-5"
                                            onclick="EventForm()">
                                            Submit</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--  -->
    <section class="events-tabs">
        <div class="container">
            <div class="web-heading">
                <h1>How VCQRU Help Your Business To Grow</h1>
                <p>
                    We desire that the current generation and the generations to come, do not have to worry about the
                        fakes and counterfeits. We believe in " connecting with the heart and mind of consumers", and
                        our
                        technology and offerings are all centered on it.
                </p>
            </div>
            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-anticounterfiet-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-anticounterfiet" type="button" role="tab"
                        aria-controls="pills-anticounterfiet" aria-selected="true">
                        <img src="../NewContent/front-assets/img/product-icons/anti-counterfeit.svg"
                            alt="Anti-counterfiet">
                        Anti-counterfiet
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-buildloyalty-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-buildloyalty" type="button" role="tab"
                        aria-controls="pills-buildloyalty" aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/digital-marketing.svg"
                            alt="Anti-counterfiet">
                        Build Loyalty
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-ewarranty-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-ewarranty" type="button" role="tab" aria-controls="pills-ewarranty"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/e-warranty.svg"
                            alt="Anti-counterfiet">
                        Website Design Development
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-digitalmarket-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-digitalmarket" type="button" role="tab"
                        aria-controls="pills-digitalmarket" aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/digital-marketing.svg"
                            alt="Anti-counterfiet">
                        Digital Marketing
                    </button>
                </li>

            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-anticounterfiet" role="tabpanel"
                    aria-labelledby="pills-anticounterfiet-tab" tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-4">
                        <div class="col">
                            <h5>Anti-counterfiet</h5>
                            <p>
                                VCQRU is an Anti Counterfeit solution that uses advanced technology like QR codes,
                                    unique
                                    codes, and blockchain to provide foolproof security against counterfeit products.
                            </p>
                            <p>
                                Counterfeit products have become a pervasive issue, impacting brands, consumers, and
                                    economies on a global scale. At VCQRU, we understand the gravity of this problem,
                                    and we
                                    are dedicated to providing effective solutions to protect your valuable products.
                            </p>
                            <a href="../anti-counterfeiting-solutions.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/build_loayalty-header.png" alt="build_loayalty-header"
                                class="img-fluid">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="pills-buildloyalty" role="tabpanel"
                    aria-labelledby="pills-buildloyalty" tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Build Loyalty</h5>
                            <p>
                                In today's competitive market, retaining your end users is more crucial than ever.
                                    Even the smallest oversight on your part could prompt them to switch to a
                                    competitor's offering. In the modern business, customer loyalty is paramount to
                                    sustained success. A robust loyalty program serves as a powerful tool to not only
                                    retain existing customers but also to attract new ones. These programs not only
                                    encourage repeat purchases but also enhance customer engagement and brand loyalty.
                            </p>

                            <a href="../customer-loyalty-program.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/industries-header/e-commerce-header.png"
                                alt="packing" class="img-fluid">
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-ewarranty" role="tabpanel"
                    aria-labelledby="pills-ewarranty-tab" tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Website Design Development</h5>
                            <p>
                                Creating a unique and visually appealing website that resonates with your brand
                                    identity and objectives is paramount in today's digital realm. At VCQRU, Our custom
                                    web design and development services are meticulously crafted to cater to the
                                    specific needs and preferences of your business. From the initial consultation,
                                    research, and development phase, we ensure that your website reflects the essence of
                                    your business and effectively communicates your message to your audience.
                            </p>
                            <a href="../website-design-and-development-company.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/e-warranty-header.png" alt="traceandtrace"
                                class="img-fluid">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="pills-digitalmarket" role="tabpanel"
                    aria-labelledby="pills-digitalmarket-tab" tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Digital Marketing</h5>
                            <p>
                                According to the Global Digital Marketing Market Report, the global digital marketing
                                    market is aided by the increasing number of internet users and the growing adoption
                                    of intelligent devices. The market is projected to grow at a CAGR of around 9.1%
                                    between 2022-27. Digital marketing also referred to as internet marketing and online
                                    marketing, is a popular activity by brands and businesses to build their online
                                    presence. Digital marketing means promoting your brand or business via digital
                                    platforms. The digital channels include social media, search engines, email, content
                                    marketing, and many more.
                            </p>
                            <a href="https://digitalmarketing.vcqru.com/" target="_blank">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/digital_marketing-header.png"
                                alt="digital-marketing" class="img-fluid">
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="pills-serviceprogram" role="tabpanel"
                    aria-labelledby="pills-serviceprogram-tab" tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Customer Referral Services Program</h5>
                            <p>
                                The referral marketing program is one of the most cost-effective marketing ways where
                                    businesses use current customers to spread the message about their brand.
                            </p>
                            <p>
                                Best Referral Marketing Program For All Types of Businesses one of the most
                                    cost-effective marketing ways where businesses use current customers to spread the
                                    message about their brand.
                            </p>
                            <a href="../customer-referral-program.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/referral_service-header.png"
                                alt="cash-transfer" class="img-fluid">
                        </div>
                    </div>
                </div>
    </section>
    <!-- event-date -->
    <section class="exhibition-schedule"
        style="background: linear-gradient( 90deg, rgba(0, 0, 0, 0.7) 100%, rgba(0, 0, 0, 0.7) 100% ),url('../NewContent/front-assets/img/news-events/bg-gym.png');">
        <div class="container">
            <div class="web-heading">
                <h1>Exhibition Schedule</h1>
                <p class="text-white">Our schedule table</p>

            </div>
            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-dateOne-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateOne" type="button" role="tab" aria-controls="pills-dateOne"
                        aria-selected="true">
                        <h5>Friday</h5>
                        <p>07-June-2024</p>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-dateTwo-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateTwo" type="button" role="tab" aria-controls="pills-dateTwo"
                        aria-selected="false">
                        <h5>Saturday</h5>
                        <p>08-June-2024</p>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-dateThree-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateThree" type="button" role="tab" aria-controls="pills-dateThree"
                        aria-selected="false">
                        <h5>Sunday</h5>
                        <p>09-June-2024</p>
                    </button>
                </li>
            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-dateOne" role="tabpanel"
                    aria-labelledby="pills-dateOne-tab" tabindex="0">
                    <p>
                        Join us to be part of a global movement against counterfeit products and Smart packaging.
                            Together, let's work towards a world where consumers can trust the authenticity of the
                            products
                            they purchase, and legitimate businesses can thrive without the fear of illicit competition.
                    </p>
                </div>
                <div class="tab-pane fade" id="pills-dateTwo" role="tabpanel" aria-labelledby="pills-dateTwo-tab"
                    tabindex="0">
                    <p>
                        Throughout the event, there will be dedicated exhibition spaces where our anti-counterfeiting
                            technology experts, solution developers, and Packaging solution stakeholders will showcase
                            their
                            products and services. Attendees will have the opportunity to interact with exhibitors,
                            witness
                            live demonstrations, and explore potential partnerships to enhance their anti-counterfeiting
                            efforts.
                    </p>
                </div>
                <div class="tab-pane fade" id="pills-dateThree" role="tabpanel"
                    aria-labelledby="pills-dateThree-tab" tabindex="0">
                    <p>
                        The final day of the event focuses on fostering collaboration among stakeholders, including
                            industry players, government agencies, law enforcement authorities, and consumer
                            organizations.
                            Engage in panel discussions, workshops, and networking sessions to explore opportunities for
                            joint initiatives, information sharing, and coordinated efforts to combat counterfeiting
                            effectively.
                    </p>
                </div>
            </div>
            <div class="visit text-center">
                <h2>Why Visit Our Booth?</h2>
                <p>Exclusive Insights:Learn about cutting-edge healthcare solutions from leading experts.</p>
                <p>Networking Opportunities: Connect with industry leaders and like-minded professionals.</p>
                <p>
                    Innovative Products: Explore the newest healthcare products and services designed to improve
                        health outcomes.
                </p>
                <p>Expert Demonstrations: Witness live demonstrations and interactive sessions.</p>
                <p>
                    Don't miss this opportunity to be at the heart of the healthcare industry's most influential
                        event. Join us at Booth No: 64 and take your first step towards pioneering healthcare
                        excellence.
                </p>

            </div>
        </div>

    </section>

    <section class="industries bg-white">
        <div class="container">
            <div class="industries-logo border rounded-3 border-2">
                <div id="companyLogos" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/patanjali.png" alt="patanjali">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/mahindra.png" alt="mahindra">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/auto-park.png" alt="auto-park">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/bsc-paints.svg" alt="bsc-paints">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/ColorValley-logo.png"
                                        alt="ColorValley">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/flora.png" alt="flora">
                                </li>
                            </ul>
                        </div>
                        <div class="carousel-item">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/jal_logo.png" alt="jal_logo">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/johnson-paints.png"
                                        alt="johnson-paints">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/mealo.png" alt="mealo">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/oci-cable.png" alt="oci-cable">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/pink_lotus.png" alt="pink_lotus">
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/logos/pp_organics-logo.png"
                                        alt="pp_organics">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <head>
        <!-- Other head content -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <!-- submitForm -->
    <script>

        function EventForm() {
            // Show loading spinner
            document.getElementById('loader-wrapper').style.visibility = 'visible';
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^\d{10}$/; // Adjust the regex based on your mobile number format
            debugger;
            // Get form values
            var fullName = document.getElementById('fullName').value.trim();
            var emailID = document.getElementById('emailID').value.trim();
            var phoneRpf = document.getElementById('phoneRpf').value.trim();
            var compname = document.getElementById('compname').value.trim();
            var visitor = document.getElementById('visitor').value.trim();
            var eventname = document.getElementById('eventname').value.trim();

            // Validate form
            if (fullName === "" || emailID === "" || phoneRpf === "" || compname === "" || visitor === "" || eventname === "" || !emailRegex.test(emailID) || !phoneRegex.test(phoneRpf)) {
                // Hide loading spinner
                document.getElementById('loader-wrapper').style.visibility = 'hidden';

                // Show SweetAlert for validation errors
                //swal.fire({
                //    title: 'validation error',
                //    text: 'please ensure all fields are filled out correctly.',
                //    icon: 'error',
                //    confirmbuttontext: 'ok'
                //});

                // Show validation styles
                (() => {
                    'use strict';
                    const forms = document.querySelectorAll('.needs-validation');

                    if (!emailRegex.test(emailID)) {
                        Array.from(forms).forEach(form => {
                            form.classList.add('was-validated');
                        });
                        return false;
                    }

                    if (!phoneRegex.test(phoneRpf)) {
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

            // Create a new XMLHttpRequest object
            var xhr = new XMLHttpRequest();

            // Define the AJAX request
            xhr.open('POST', 'https://www.vcqru.com/Info/MasterHandler.ashx?method=GetYourFreePass&Name=' + encodeURIComponent(fullName) + '&Email=' + encodeURIComponent(emailID) + '&Mobile=' + encodeURIComponent(phoneRpf) + '&Visitor=' + encodeURIComponent(visitor) + '&Comp=' + encodeURIComponent(compname) + '&Exibitionname=' + encodeURIComponent(eventname), true);

            // Set the content type for POST requests
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

            // Define the callback function when the request is successful
            xhr.onload = function () {
                // Hide loading spinner
                document.getElementById('loader-wrapper').style.visibility = 'hidden';

                if (xhr.status === 200) {
                    // Reset form fields to null
                    document.getElementById('myForm').reset();

                    // Show SweetAlert for successful form submission
                    Swal.fire({
                        title: 'Submit',
                        text: 'Thank you for submitting your details! We appreciate your interest in our services and look forward to connecting with you soon. ',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    });//.then((result) => {
                    //    if (result.isConfirmed) {
                    //        // Redirect to thank-you.aspx after a successful form submission
                    //        window.location.href = '../../thank-you.aspx';
                    //    }
                    //});
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
    <!--  -->
    <script>
        function validateEmail(event) {
            const key = event.key;
            if (key == "%" || key == "#" || key == "~" || key == "+" || key == "(" || key == ")" || key == "!" || key == "*" || key == "^" || key == "$" || key == "&" || key == "{" || key == "}" || key == ":" || key == ";" || key == '`' || key == "'" || key == '"' || key == '|' || key == '/' || key == "]" || key == "[" || key == "?" || key == "," || key == "<" || key == ">") {
                return false;
            }
        }
        function validateInputMail(input) {
            const emailInput = $("#emailID").val();
            const lengthAfterDot = getLengthAfterDot(emailInput);
            if (emailInput.includes(".") == false) {
                input.setCustomValidity('Invalid.');
            } else if (lengthAfterDot < 2) {
                input.setCustomValidity('Invalid.');
            }
            else {
                input.setCustomValidity('');

            }
        }
        function validateInputMailAll(input) {
            const emailInput = $("#emailAll").val();
            const lengthAfterDot = getLengthAfterDot(emailInput);
            if (emailInput.includes(".") == false) {
                input.setCustomValidity('Invalid.');
            } else if (lengthAfterDot < 2) {
                input.setCustomValidity('Invalid.');
            }
            else {
                input.setCustomValidity('');

            }
        }
        function getLengthAfterDot(emailID) {
            const parts = emailID.split('.');
            // Get the last part (substring after the last dot)
            const lastPart = parts[parts.length - 1];
            return lastPart.length;
        }
        function checkWhitespace(str) {
            var spaceCount = 0;

            for (var i = 0; i < str.length; i++) {
                if (str[i] === ' ') {
                    spaceCount++;
                }
            }
            return spaceCount;
        }

    </script>
    <!--  -->
    <!-- loder -->
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
        function getUrlVars() {
             debugger;
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        };
        function getUrlVars() {
            debugger;
            var vars = {};
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for (var i = 0; i < hashes.length; i++) {
                var hash = hashes[i].split('=');
                vars[hash[0]] = decodeURIComponent(hash[1]);
            }

            return vars;
        }


         document.getElementById('eventname').value = getUrlVars()["eventname"];
       alert(eventnamenew);
          //  getUrlVars()["eventname"];
    </script>

</asp:Content>
