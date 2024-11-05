<%@ Page Title="Human Resource Executive" Language="C#" MasterPageFile="~/jobs/jobs-layout.master" AutoEventWireup="true" CodeFile="job-details-human-resource-executive.aspx.cs" Inherits="jobs_job_details_human_resource_executive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="canonical" href="https://www.vcqru.com/jobs/job-details-human-resource-executive.aspx?jobType=Human-Resource-Executive-Manager" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section class="my-5">
        <div class="container">
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../default.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="../career.aspx">career</a></li>
                        <li class="breadcrumb-item active text-transform-unset" aria-current="page">Human Resource Executive </li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>
     <!--  -->
    <section class="job-details">
        <div class="container">
            <div class="row g-4">
                <div class="col-xxl-8 col-xl-8 col-lg-8 col-md-12">
                    <h1>Human Resource Executive/Manager</h1>
                    <div class="job-heading">
                        <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-4 row-cols-2 g-4">
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/experience.svg" alt="Experience">
                                <h5>0-4 Years</h5>
                                <p>Total Experience</p>
                            </div>
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/full-time.svg" alt="Full Time">
                                <h5>Full Time</h5>
                                <p>Job Type</p>
                            </div>
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/opening.svg" alt="Openings">
                                <h5>01</h5>
                                <p>No. of Openings</p>
                            </div>
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/location.svg" alt="Location">
                                <h5>Gurgaon</h5>
                                <p>Location</p>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="job-text">
                        <h5>Company description:</h5>
                       <p>VCQRU PRIVATE LIMITED is a technology and packaging solutions provider located in Gurugram.
                         We offer comprehensive, one-stop solutions for all your technological and packaging needs.
                          Our portfolio includes patent-pending technologies that deliver exceptional anti-counterfeit and loyalty services, 
                          seamlessly incorporated into your product labels and packaging. In addition to our offerings, we provide cost-effective 
                          printing services with or without security features to help your business grow in the digital age. Join us at VCQRU and 
                          experience the convergence of technology, innovation, and outstanding service for your brand's success.</p>
                        <h5>Position Overview:</h5>
                        <p>As an HR Executive/Manager at VCQRU, you will play a pivotal role in shaping our organizational culture and driving strategic
                             HR initiatives. You will work closely with senior leadership to develop and implement HR strategies that align with our business
                              objectives and promote employee engagement and retention. This role offers an exciting opportunity to make a meaningful impact on
                               the success of our organization while advancing your career in HR.</p>
                        <h5>KEY RESPONSIBILITIES</h5>
                        <ul>
                            <li>Collaborate with department heads to understand staffing needs and develop recruitment strategies to attract top talent.</li>
                            <li>Lead the end-to-end recruitment process, including job postings, screening resumes, conducting interviews, and extending job offers.</li>
                            <li>Develop and implement effective onboarding programs to ensure new hires are integrated seamlessly into the organization.</li>
                            <li>Oversee employee relations activities, including conflict resolution, performance management, and disciplinary actions.</li>
                            <li>Manage employee benefits programs and serve as a point of contact for employee inquiries related to benefits.</li>
                            <li>Develop and implement training and development programs to enhance employee skills and competencies.</li>
                            <li>Ensure compliance with relevant employment laws and regulations and maintain accurate employee records.</li>
                            <li>Analyze HR metrics and provide insights to senior leadership to drive data-driven decision-making.</li>
                            <li>Stay abreast of industry trends and best practices in HR and implement innovative approaches to enhance the employee experience.</li>
                            
                        </ul>
                        <h5>Qualifications:</h5>
                        <ul>
                            <li>Experience in Human Resources, Business Administration, or a related field.</li>
                            <li>0 - 4 Years of experience in HR roles, with a proven track record of success in recruitment, employee relations, and HR operations.</li>
                            <li>Strong knowledge of employment laws and regulations.</li>
                            <li>Excellent communication and interpersonal skills, with the ability to build rapport with employees at all levels of the organization.</li>
                            <li>Proven leadership skills with the ability to effectively manage a team and drive results.</li>
                            <li>Highly organized with strong attention to detail and the ability to manage multiple priorities in a fast-paced environment.</li>
                            <li>Proficiency in HRIS and other HR software applications.</li>
                            <li>Ability to build rapport.</li>
                            <li>Time management and planning skills.</li>

                        </ul>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <form action="" class="needs-validation" novalidate id="myForm" method="post">
                                <div class="row row-cols-1 g-4">
                                    <div class="col">
                                        <label for="name" class="form-label">Name<span>*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" value=""
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="email" class="form-label">email<span>*</span></label>
                                        <input type="email" class="form-control" id="email" name="email" value=""
                                            required>
                                        <div class="invalid-feedback">Please enter your email.</div>
                                    </div>
                                    <div class="col d-none">
                                        <label for="jobType" class="form-label">Apply For<span>*</span></label>
                                        <input type="text" class="form-control" id="jobType" name="jobType" value=""
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" required>
                                        <div class="invalid-feedback">Please enter your position.</div>
                                    </div>
                                    <div class="col">
                                        <label for="cmobile" class="form-label">mobile number<span>*</span></label>
                                        <input type="number" class="form-control" id="cmobile" name="cmobile" value=""
                                            required maxlength="10"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');">
                                        <div class="invalid-feedback">Please enter your mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="resumePath" class="form-label">resume Path<span>*</span></label>
                                        <input type="file" class="form-control" id="resumePath" name="resumePath"
                                            value="" accept=".pdf" required>
                                        <div class="invalid-feedback">Please upload a resume.</div>
                                    </div>
                                    <div class="col" id="btformsubmit">
                                         <label for="resumePath" class="form-label text-white">.</label><br>
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
    <script>
        var mybutton = document.getElementById("top-btn"); function scrollFunction() { document.body.scrollTop > 20 || document.documentElement.scrollTop > 20 ? mybutton.style.visibility = "visible" : mybutton.style.visibility = "hidden" } function topFunction() { document.body.scrollTop = 0, document.documentElement.scrollTop = 0 } window.onscroll = function () { scrollFunction() };
    </script>
    <!-- Loader-js -->
    <script>
        // window-loader
        document.addEventListener("DOMContentLoaded", function () {
            // Hide the loader once the page has finished loading
            var loader = document.getElementById("loader-wrapper");
            loader.style.visibility = "hidden";
        });
    </script>
    <!-- submitForm -->
    <script>
        function submitForm() {
            // Show loading spinner
            //document.getElementById('loader-wrapper').style.visibility = 'visible';
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^\d{10,10}$/; // Adjust the regex based on your mobile number format
            // Get form values
            var name = document.getElementById('name').value.trim();
            var email = document.getElementById('email').value.trim();
            var jobType = document.getElementById('jobType').value.trim();
            var cmobile = document.getElementById('cmobile').value.trim();
            var resumePath = document.getElementById('resumePath').value.trim();

            // Validate form
            if (name == "" || email == "" || cmobile == "" || resumePath == "" || jobType == "" || !emailRegex.test(email) || !phoneRegex.test(cmobile)) {
                (() => {
                    'use strict'
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    const forms = document.querySelectorAll('.needs-validation')
                    // Validate email using regex
                    if (!emailRegex.test(email)) {
                        // Show email validation styles and prevent submission
                        Array.from(forms).forEach(form => {
                            form.classList.add('was-validated');
                        });
                        return false;
                    }

                    // Validate phone number using regex
                    if (!phoneRegex.test(cmobile)) {
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
                /*document.getElementById('loader-wrapper').style.visibility = 'hidden';*/
                return false;
            }

        //    // Create a new XMLHttpRequest object
        //    var xhr = new XMLHttpRequest();

        //    // Define the AJAX request
        //    xhr.open('POST', 'https://qa.vcqru.com/Info/MasterHandler.ashx?method=sendqueryOpenings&name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email) + '&jobType=' + encodeURIComponent(jobType) + '&cmobile=' + encodeURIComponent(cmobile) + '&resumePath=' + encodeURIComponent(resumePath), true);

        //    // Set the content type for POST requests
        //    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

        //    // Define the callback function when the request is successful
        //    xhr.onload = function () {
        //        // alert(xhr.response);
        //        // Hide loading spinner
        //        document.getElementById('loader-wrapper').style.visibility = 'hidden';
        //        if (xhr.status === 200) {
        //            // Reset form fields to null
        //            document.getElementById('myForm').reset();
        //            // Redirect to ../thank-you.aspx after a successful form submission
        //            window.location.href = '../../thank-you.aspx';
        //        }
        //    };

        //    // Define the callback function in case of an error
        //    xhr.onerror = function (error) {
        //        // Hide loading spinner
        //        console.error('Error:', error);
        //    };

        //    // Send the request
        //    xhr.send();
        //}
            var fd = new FormData();
            var files = $('#resumePath')[0].files[0];
            fd.append('file', files);
            document.getElementById('loader-wrapper').style.visibility = 'hidden';

            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                data: fd,
                url: 'https://www.vcqru.com/Info/MasterHandler.ashx?method=sendqueryOpenings&name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email) + '&jobType=' + encodeURIComponent(jobType) + '&cmobile=' + encodeURIComponent(cmobile) + '&resumePath=' + encodeURIComponent(resumePath),
                success: function (data) {
                    //$('#progress').hide();
                    $('#btformsubmit').hide();

                    document.getElementById('myForm').reset();
                    window.location.href = '../thank-you.aspx';
                },
                error: function (data) {

                    console.error('Error:', error);
                },
            });



        }
    </script>
    <!-- submitForm -->
    <script>
        document.onreadystatechange = function () {
            var loaderWrapper = document.getElementById('loader-wrapper');

            // Show loader when the page is still loading
            if (document.readyState === 'loading') {
               /* loaderWrapper.style.visibility = 'visible';*/
            } else {
                // Hide loader once the page has fully loaded
               /* loaderWrapper.style.visibility = 'hidden';*/
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
        document.getElementById('jobType').value = getUrlVars()["jobType"];
    </script>
</asp:Content>

