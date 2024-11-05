<%@ Page Title="VCQRU Participating In  IPLCM Expo 2024" Language="C#" MasterPageFile="~/event/event-layout.master" AutoEventWireup="true" CodeFile="iplcm-event.aspx.cs" Inherits="event_iplcm_event" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <title>INTERNATIONAL PRIVATE LABEL & CONTRACT MANUFACTURING EXPO'24</title>
    <meta name="title" content="INTERNATIONAL PRIVATE LABEL & CONTRACT MANUFACTURING EXPO'24" />
    <meta name="description" content="International Private Label And Contract Manufacturing Expo 2024 with us at our Booth No : E-11 in Mumbai. IPLCM EXPO'24 is a leading B2B event that is solely dedicated to the Private Label, White Label, and Contract Manufacturing industry." />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section class="services-details-header">
          <div class="container">
               <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Default.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="../news-event.aspx">News Event</a></li>
                        <li class="breadcrumb-item active" aria-current="page">VCQRU Participating In IPLCM
                            Expo 2024</li>
                    </ol>
                </nav>
            </div>
            <!-- end -->
            <div class="row g-4">
                <div class="col-xxl-6 col-xl-6 col-lg-6 order-lg-1 order-2">
                    <h1 class="fs-1">VCQRU <br> Participating In IPLCM <br>  Expo 2024</h1>
                    <h5>Hurry up!</h5>
                    <p>Welcome to VCQRU, where we bridge the gap between IT technologies and label printing and
                        packaging. As an organization, we provide a unique platform that caters to brands across diverse
                        domains such as healthcare, automobile, paint and building materials, plywood, FMCG, and more.
                    </p>
                </div>
                <div class="col-xxl-6 col-xl-6 col-lg-6 order-lg-2 order-1">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Submit your details to get your free passes of the Iplcm Expo 2024</h5>
                            <!-- form -->
                            <form action="" novalidate id="myForm" method="post"  class="needs-validation">
                                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-4">
                                    <div class="col">
                                        <label for="fullName" class="form-label">Full Name<span>*</span></label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" value=""
                                             pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="email" class="form-label">Email Address<span>*</span></label>
                                        <input type="emailID" class="form-control" id="emailID" name="emailID" value=""
                                            required>
                                        <div class="invalid-feedback">Please enter your email.</div>
                                    </div>
                                    <div class="col">
                                        <label for="phoneRpf" class="form-label">Phone Number<span>*</span></label>
                                        <input type="number" class="form-control" id="phoneRpf" name="phoneRpf" value=""
                                            required maxlength="10"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');">
                                        <div class="invalid-feedback">Please enter your mobile number.</div>
                                    </div>
                                      <div class="col">
                                        <label for="compname" class="form-label">Company Name<span>*</span></label>
                                        <input type="text" class="form-control" id="compname" name="compname" value=""
                                             pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your company name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="visitor" class="form-label">No .of Visitors<span>*</span></label>
                                        <input type="number" class="form-control" id="visitor" name="visitor" value=""
                                            pattern="[1-10 ]+" required>
                                        <div class="invalid-feedback">Please enter your No of visitors.</div>
                                    </div>
                                    <div class="col d-none">
                                        <label for="eventname" class="form-label">No .of Visitors<span>*</span></label>
                                        <input type="text" class="form-control" id="eventname" name="eventname" value=""
                                            pattern="[1-50 ]+" required>
                                        <div class="invalid-feedback">Please enter Exhibition Name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="" class="form-label text-white">.</label><br>
                                        <button type="button" class="btn btn-primary px-5"
                                        onclick="submitForm()">Submit</button>
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
                <h1>How VCQRU help your business to grow</h1>
                <p>We desire that the current generation and the generations to come, do not have to worry about the
                    fakes and counterfeits. We believe in " connecting with the heart and mind of consumers", and our
                    technology and offerings are all centered on it.</p>
            </div>
            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-anticounterfiet-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-anticounterfiet" type="button" role="tab" aria-controls="pills-anticounterfiet"
                        aria-selected="true">
                        <img src="../NewContent/front-assets/img/product-icons/anti-counterfeit.svg"
                            alt="Anti-counterfiet">
                        Anti-counterfiet
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-packing-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-packing" type="button" role="tab" aria-controls="pills-packing"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/packing-icon.svg"
                            alt="Packing">
                           Packing
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-smartlabel-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-smartlabel" type="button" role="tab" aria-controls="pills-smartlabel"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/smart-labels.svg"
                            alt="Anti-counterfiet">
                            Smart Labels
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-tracktrace-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-tracktrace" type="button" role="tab" aria-controls="pills-tracktrace"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/track-trace.svg"
                            alt="Anti-counterfiet">
                             Track and Trace
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-ewarranty-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-ewarranty" type="button" role="tab" aria-controls="pills-ewarranty"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/e-warranty.svg"
                            alt="Anti-counterfiet">
                           E-warranty
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-digitalmarket-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-digitalmarket" type="button" role="tab" aria-controls="pills-digitalmarket"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/digital-marketing.svg"
                            alt="Anti-counterfiet">
                           Digital Marketing
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-cashtransfer-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-cashtransfer" type="button" role="tab" aria-controls="pills-cashtransfer"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/cash-transfer.svg"
                            alt="Anti-counterfiet">
                           Cash Transfer
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-serviceprogram-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-serviceprogram" type="button" role="tab" aria-controls="pills-serviceprogram"
                        aria-selected="false">
                        <img src="../NewContent/front-assets/img/product-icons/referral-services.svg"
                            alt="Anti-counterfiet">
                          Referral Services
                    </button>
                </li>
                
            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-anticounterfiet" role="tabpanel" aria-labelledby="pills-anticounterfiet-tab"
                    tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Anti-counterfiet</h5>
                            <p>VCQRU is an Anti Counterfeit solution that uses advanced technology like QR codes, unique
                                codes, and blockchain to provide foolproof security against counterfeit products.</p>
                            <p>Counterfeit products have become a pervasive issue, impacting brands, consumers, and
                                economies on a global scale. At VCQRU, we understand the gravity of this problem, and we
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
                <div class="tab-pane fade" id="pills-packing" role="tabpanel" aria-labelledby="pills-packing-tab"
                    tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Anti-counterfiet solutions for packing</h5>
                            <p>Anti-counterfeit solutions for packaging are measures that are put in place to prevent the production and distribution of counterfeit products that are often packaged to look like genuine products.</p>
                            <p>VCQRU is a company that provides a range of anti-counterfeit solutions for various industries, including pharmaceuticals, food and beverages, and packing.</p>
                            <a href="../packaging.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/industries-header/e-commerce-header.png" alt="packing"
                                class="img-fluid">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="pills-smartlabel" role="tabpanel" aria-labelledby="pills-smartlabel-tab"
                    tabindex="0">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                        <div class="col">
                            <h5>Smart Labels</h5>
                           <p>Smart labels are affixed with the products and packaging to provide detailed information about the items. They can also be used to track and monitor the item through the supply chain, making it easy to manage inventory, reduce waste and prevent counterfeiting.</p>
                           <p>VCQRU is one of the leading providers of smart labels for different industries across various domains. Apart from protecting duplicity, our smart labels solution helps you in increasing supply chain visibility, brand authentication, customer engagement and business growth</p>
                            <a href="../smart-labels-qr-code.aspx">read more</a>
                        </div>
                        <div class="col">
                            <img src="../NewContent/front-assets/img/smart_labels copy-header.png" alt="smartlabels"
                                class="img-fluid">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="pills-tracktrace" role="tabpanel" aria-labelledby="pills-tracktrace-tab"
                tabindex="0">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                    <div class="col">
                        <h5>Track and Trace</h5>
                      <p>In today's fast-paced world, it is crucial for brands to have visibility into their product's journey from manufacturing to end-users. This is where track and trace technology comes into play. Track and trace is a process that enables companies to monitor and trace their products throughout the supply chain. This technology can help businesses to identify potential bottlenecks, improve efficiencies, and ultimately ensure that products reach their intended destinations.</p>
                        <a href="../track-and-trace-solutions.aspx">read more</a>
                    </div>
                    <div class="col">
                        <img src="../NewContent/front-assets/img/track_and_trace-header.png" alt="traceandtrace"
                            class="img-fluid">
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="pills-ewarranty" role="tabpanel" aria-labelledby="pills-ewarranty-tab"
            tabindex="0">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                <div class="col">
                    <h5>E-Warranty</h5>
                  <p>A e warranty services is one solution that has made the warranty claim process easy for customers, manufacturers, and retailers. It is a good opportunity for customers to directly connect with the manufacturers.</p>
                  <p>An e warranty services is one solution that has made the warranty claim process easy for customers, manufacturers, and retailers. It is a good opportunity for customers to directly connect with the manufacturers.

                  </p>
                    <a href="../digital-e-warranty-management-solution.aspx">read more</a>
                </div>
                <div class="col">
                    <img src="../NewContent/front-assets/img/e-warranty-header.png" alt="traceandtrace"
                        class="img-fluid">
                </div>
            </div>
            </div>
            <div class="tab-pane fade" id="pills-digitalmarket" role="tabpanel" aria-labelledby="pills-digitalmarket-tab"
            tabindex="0">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
                <div class="col">
                    <h5>Digital Marketing</h5>
                  <p>According to the Global Digital Marketing Market Report, the global digital marketing market is aided by the increasing number of internet users and the growing adoption of intelligent devices. The market is projected to grow at a CAGR of around 9.1% between 2022-27. Digital marketing also referred to as internet marketing and online marketing, is a popular activity by brands and businesses to build their online presence. Digital marketing means promoting your brand or business via digital platforms. The digital channels include social media, search engines, email, content marketing, and many more.</p>
                    <a href="https://digitalmarketing.vcqru.com/" target="_blank">read more</a>
                </div>
                <div class="col">
                    <img src="../NewContent/front-assets/img/digital_marketing-header.png" alt="digital-marketing"
                        class="img-fluid">
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="pills-cashtransfer" role="tabpanel" aria-labelledby="pills-cashtransfer-tab"
        tabindex="0">
        <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
            <div class="col">
                <h5>Cash Transfer</h5>
            <p>It's a form of cash incentive, generally offered to customers when they buy certain products and receive a cash refund after their purchase.</p>
            <p>It's a form of cash incentive, generally offered to customers when they buy certain products and receive a cash refund after their purchase.</p>
                <a href="../cash-transfer-system.aspx">read more</a>
            </div>
            <div class="col">
                <img src="../NewContent/front-assets/img/cash_transfer-header-.png" alt="cash-transfer"
                    class="img-fluid">
            </div>
        </div>
    </div>
    <div class="tab-pane fade" id="pills-serviceprogram" role="tabpanel" aria-labelledby="pills-serviceprogram-tab"
    tabindex="0">
    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 g-4">
        <div class="col">
            <h5>Customer Referral Services Program</h5>
       <p>The referral marketing program is one of the most cost-effective marketing ways where businesses use current customers to spread the message about their brand.</p>
       <p>Best Referral Marketing Program For All Types of Businesses one of the most cost-effective marketing ways where businesses use current customers to spread the message about their brand.</p>
            <a href="../customer-referral-program.aspx">read more</a>
        </div>
        <div class="col">
            <img src="../NewContent/front-assets/img/referral_service-header.png" alt="cash-transfer"
                class="img-fluid">
        </div>
    </div>
</div>
    </section>
    <!-- event-date -->
    <section class="exhibition-schedule">
        <div class="container">
            <div class="web-heading">
                <h1>Exhibition Schedule</h1>
                <p>Our schedule table</p>
            </div>
            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pills-dateOne-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateOne" type="button" role="tab" aria-controls="pills-dateOne"
                        aria-selected="true">
                        <h5>Thursday</h5>
                        <p>08-Feb-2024</p>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-dateTwo-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateTwo" type="button" role="tab" aria-controls="pills-dateTwo"
                        aria-selected="false">
                        <h5>Friday</h5>
                        <p>09-Feb-2024</p>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-dateThree-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-dateThree" type="button" role="tab" aria-controls="pills-dateThree"
                        aria-selected="false">
                        <h5>Saturday</h5>
                        <p>10-Feb-2024</p>
                    </button>
                </li>
            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-dateOne" role="tabpanel"
                    aria-labelledby="pills-dateOne-tab" tabindex="0">
                    <p>Join us to be part of a global movement against counterfeit products and Smart packaging.
                        Together, let's work towards a world where consumers can trust the authenticity of the products
                        they purchase, and legitimate businesses can thrive without the fear of illicit competition.</p>
                </div>
                <div class="tab-pane fade" id="pills-dateTwo" role="tabpanel" aria-labelledby="pills-dateTwo-tab"
                    tabindex="0">
                    <p>Throughout the event, there will be dedicated exhibition spaces where our anti-counterfeiting
                        technology experts, solution developers, and Packaging solution stakeholders will showcase their
                        products and services. Attendees will have the opportunity to interact with exhibitors, witness
                        live demonstrations, and explore potential partnerships to enhance their anti-counterfeiting
                        efforts.</p>
                </div>
                <div class="tab-pane fade" id="pills-dateThree" role="tabpanel" aria-labelledby="pills-dateThree-tab"
                    tabindex="0">
                    <p>The final day of the event focuses on fostering collaboration among stakeholders, including
                        industry players, government agencies, law enforcement authorities, and consumer organizations.
                        Engage in panel discussions, workshops, and networking sessions to explore opportunities for
                        joint initiatives, information sharing, and coordinated efforts to combat counterfeiting
                        effectively.</p>
                </div>
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
                                    <img src="../NewContent/front-assets/img/logos/ColorValley-logo.png" alt="ColorValley">
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
                                    <img src="../NewContent/front-assets/img/logos/johnson-paints.png" alt="johnson-paints">
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
                                    <img src="../NewContent/front-assets/img/logos/pp_organics-logo.png" alt="pp_organics">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- submitForm -->
    <script>
        function submitForm() {
            // Show loading spinner
            document.getElementById('loader-wrapper').style.visibility = 'visible';
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^\d{10,10}$/; // Adjust the regex based on your mobile number format
            // Get form values
            debugger;
            var fullName = document.getElementById('fullName').value.trim();
            var emailID = document.getElementById('emailID').value.trim();
            var phoneRpf = document.getElementById('phoneRpf').value.trim();
            var compname = document.getElementById('compname').value.trim();
            var visitor = document.getElementById('visitor').value.trim();
            var eventname = document.getElementById('eventname').value.trim();


            // Validate form
            if (fullName === "" || emailID === "" || phoneRpf === "" || compname === "" || visitor === "" || eventname === "" || !emailRegex.test(emailID) || !phoneRegex.test(phoneRpf)) {
                (() => {
                    'use strict'
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    const forms = document.querySelectorAll('.needs-validation')
                    // Validate email using regex
                    if (!emailRegex.test(emailID)) {
                        // Show email validation styles and prevent submission
                        Array.from(forms).forEach(form => {
                            form.classList.add('was-validated');
                        });
                        return false;
                    }

                    // Validate phone number using regex
                    if (!phoneRegex.test(phoneRpf)) {
                        // Show phone number validation styles and prevent submission
                        Array.from(forms).forEach(form => {
                            form.classList.add('was-validated');
                        });
                        return false;
                    }


                    // Loop over them and prevent submission
                    Array.from(forms).forEach(form => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    });
                })();
                // Hide loading spinner
                document.getElementById('loader-wrapper').style.visibility = 'hidden';
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
                // alert(xhr.response);
                // Hide loading spinner
                document.getElementById('loader-wrapper').style.visibility = 'hidden';
                if (xhr.status === 200) {
                    // Reset form fields to null
                    document.getElementById('myForm').reset();
                    // Redirect to ../thank-you.aspx after a successful form submission
                    window.location.href = '../../thank-you.aspx';
                }
            };

            // Define the callback function in case of an error
            xhr.onerror = function (error) {
                // Hide loading spinner
                console.error('Error:', error);
            };

            // Send the request
            xhr.send();
        }
    </script>
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
            /* debugger;*/
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
            var vars = {};
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for (var i = 0; i < hashes.length; i++) {
                var hash = hashes[i].split('=');
                vars[hash[0]] = decodeURIComponent(hash[1]);
            }

            return vars;
        }


        document.getElementById('eventname').value = getUrlVars()["eventname"];
    </script>
</asp:Content>

