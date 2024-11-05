<%@ Page Title="Have You Any Query? Contact Us - VCQRU" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="contact-us.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="title" content="Have You Any Query? Contact Us - VCQRU" />
    <meta name="description" content="Checkout our contact us page for any query related to our services. Here we provided all the contact details which through customer can easily interact with us." />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="contact-us-form" id="contact-us">
        <div class="container">
            <!-- breadcrumb -->
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Default.aspx">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Contact us</li>
                    </ol>
                </nav>
            </div>
            <!-- end -->
            <div class="shadow-sm bg-white">
                <div class="row g-0">
                    <div class="col-xxl-8 col-xl-8 col-lg-7 col-md-12 d-flex">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Send us a Message</h5>
                                <p class="card-text">If you have any questions or concerns, please do not hesitate to
                                    contact us. Our team is always available to assist you in any way we can</p>
                              <form action="" id="myForm" method="post"
                                    class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-4 needs-validation"
                                    novalidate>
                                    <div class="col">
                                        <label for="name" class="form-label">full Name<span>*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" value=""
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your first name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="companyName" class="form-label">Company Name<span>*</span></label>
                                        <input type="text" class="form-control" id="companyName" name="companyName" value=""
                                            required>
                                        <div class="invalid-feedback">Please enter your company name.</div>

                                    </div>
                                    <div class="col">
                                        <label for="phoneRpf" class="form-label">mobile number<span>*</span></label>
                                        <input type="number" class="form-control" id="phoneRpf" name="phoneRpf" value=""
                                            required maxlength="10" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');">
                                        <div class="invalid-feedback">Please enter valid mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="emailID" class="form-label">Email<span>*</span></label>
                                        <input type="email" class="form-control" id="emailID" name="emailID" value=""
                                            required>
                                        <div class="invalid-feedback">Please enter a valid email address.</div>
                                    </div>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                        <label for="commentMsg" class="form-label">Message<span>*</span></label>
                                        <textarea name="commentMsg" id="commentMsg" class="form-control" value=""
                                            required rows="3"></textarea>
                                        <div class="invalid-feedback">Please enter your message.</div>
                                    </div>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                        <button type="button" class="btn btn-primary px-5"
                                            onclick="submitForm()">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-xxl-4 col-xl-4 col-lg-5 col-md-12 d-flex">
                        <div class="card contact-us-info">
                            <div class="card-body">
                                <h5 class="card-title">Contact Information</h5>
                                <p class="card-text mb-0">For any queries feel free to contact us and our expert support
                                    team
                                    will get back to you as soon as possible!</p>
                                <ul class="get-address">
                                    <li>
                                        <p>Our Corporate Office</p>
                                        <h6>Unit: 1502-3, 15th Floor, Tower-4, DLF Corporate Greens, Sector-74 A,
                                            Gurgaon, Haryana - 122004.</h6>
                                    </li>
                                    <li>
                                        <p>Write to us</p>
                                        <h6>
                                            <a href="mailto:sales@vcqru.com">sales@vcqru.com</a>
                                        </h6>
                                    </li>
                                    <li>
                                        <p>Talk to us</p>
                                        <h6>
                                            <a href="tel:+911245181074">+91 124 5181074</a>
                                        </h6>
                                    </li>
                                    <li class="d-flex gap-2 align-items-center">
                                        <a href="https://www.facebook.com/vcqru/" target="_blank">
                                            <i class="fa-brands fa-square-facebook"></i>
                                        </a>
                                        <a href="https://twitter.com/Vcqru_Official" target="_blank">
                                            <i class="fa-brands fa-square-x-twitter"></i>
                                        </a>
                                        <a href="https://www.instagram.com/vcqru_wesecureyou/" target="_blank">
                                            <i class="fa-brands fa-square-instagram"></i>
                                        </a>
                                        <a href="https://www.linkedin.com/company/vcqru-wesecureyou/" target="_blank">
                                            <i class="fa-brands fa-linkedin"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="google-map">
        <div class="container">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3509.4125455030717!2d76.99300607974406!3d28.40680613188903!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d3d454eeaaaab%3A0x1dd4a599f59dbdc9!2sVCQRU%20Private%20Limited!5e0!3m2!1sen!2sin!4v1701198102375!5m2!1sen!2sin"
                width="100%" height="400" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </section>
    <!-- end -->
    <!-- Contact us  -->
    <!-- our offices locations -->
    <section class="other-offices-locations">
        <div class="container">
            <div class="web-heading">
                <h1>Our Other Offices</h1>
                <p>Our tech-driven expert services are expanding across India with multiple locations. We are constantly
                    growing and serving you better, so stay in touch with us to learn more about our widespread
                    presence. Get in touch with us to find out about the services we offer at various locations.</p>
            </div>
            <div
                class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-xl-5 g-lg-4 g-md-4 g-3">
                <div class="col d-flex">
                    <div class="card" style="background-color: #ffeff2; border-color: #ffdfe5;">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="fa fa-thin fa-location-dot"></i>
                                West Bengal
                            </h5>
                            <p class="card-text">Unit 806, Tower 2 Godrej Waterside, Plot DP 5, Sector V, Bidhannagar,
                                Kolkata, West Bengal 700091</p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #eefaf0; border-color: #d2efd8;">
                        <div class="card-body">
                            <h5 class="card-title">
                                <i class="fa fa-thin fa-location-dot"></i>
                                Telangana
                            </h5>
                            <p class="card-text">Insta Office Coworking, Gachibowli Survey No. 55, Plot No. 108, NYN
                                Arcade, 3rd Floor Lumbini Society, Off, Hitech City Main Rd, Gachibowli, Telangana
                                500032</p>
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
             var name = document.getElementById('name').value;
             var emailID = document.getElementById('emailID').value;
             var phoneRpf = document.getElementById('phoneRpf').value;
             var commentMsg = document.getElementById('commentMsg').value;
             var companyName = document.getElementById('companyName').value;
             // var fullName = firstName + " " + lastName;

             // Validate form
             if (name == "" || companyName === "" || phoneRpf == "" || commentMsg == "" || !emailRegex.test(emailID) || !phoneRegex.test(phoneRpf)) {
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
             xhr.open('POST', 'https://www.vcqru.com/Info/MasterHandler.ashx?method=sendqueryMVCRPF&name=' + encodeURIComponent(name) + '&companyName=' + encodeURIComponent(companyName) + '&email=' + encodeURIComponent(emailID) + '&phone=' + encodeURIComponent(phoneRpf) + '&comment=' + encodeURIComponent(commentMsg), true);

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
                     // Redirect to thank-you.html after a successful form submission
                     window.location.href = '../thank-you.aspx';
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
    </script>

</asp:Content>

