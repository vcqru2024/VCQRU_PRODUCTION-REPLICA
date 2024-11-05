﻿<%@ Page Title="Job Apply for Lead/demand Generation" Language="C#" MasterPageFile="~/jobs/jobs-layout.master" AutoEventWireup="true" CodeFile="job-details-lead-demand-genration.aspx.cs" Inherits="jobs_job_details_lead_demand_genration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
      <link rel="canonical" href="https://www.vcqru.com/jobs/job-details-lead-demand-genration.aspx"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section class="my-5">
        <div class="container">
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Default.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="../career.aspx">career</a></li>
                        <li class="breadcrumb-item active text-transform-unset" aria-current="page">Lead/Demand
                            Generation</li>
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
                    <h1>Lead/Demand Generation</h1>
                    <div class="job-heading">
                        <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-4 row-cols-2 g-4">
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/experience.svg" alt="Experience">
                                <h5>0-3 Years</h5>
                                <p>Total Experience</p>
                            </div>
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/full-time.svg" alt="Full Time">
                                <h5>Full Time</h5>
                                <p>Job Type</p>
                            </div>
                            <div class="col">
                                <img src="../NewContent/front-assets/img/career/opening.svg" alt="Openings">
                                <h5>04</h5>
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
                        <h5>ABOUT US</h5>
                        <p>An organization of young but experienced people with a clear mission and
                            objectives, quality
                            standards are an integral part of our business practices and we believe, that these quality
                            standards contribute immensely in the overall performance of the organization.</p>
                        <p>Every person has the right to know whether the product they are buying is
                            genuine or not. We
                            use truly secure and encrypted codes printed on the labels of the product which are
                            impossible to replicate. With the help of secure mobile/web tools, the authenticity of the
                            product can be checked</p>
                        <h5>KEY RESPONSIBILITIES</h5>
                        <ul>
                            <li>Research, track, maintain and update leads.</li>
                            <li>Make outgoing calls to develop new business.</li>
                            <li>Contact prospects to qualify leads.</li>
                            <li>Direct email marketing to key clients and prospects.</li>
                            <li>Conduct customer research.</li>
                            <li>Conduct client or market surveys to obtain information about potential leads.</li>
                            <li>Participate in the preparation of proposals and/or sales presentations.</li>
                            <li>Provide accurate and timely information to management.</li>
                            <li>Develop a strong knowledge of the company’s products and services in order to facilitate
                                the sales process.</li>

                        </ul>
                        <h5>SKILLS REQUIRED</h5>
                        <ul>
                            <li>Excellent English communication (verbal and written).</li>
                            <li>Experience with cold calling.</li>
                            <li>Experience with research and maintaining databases.</li>
                            <li>Proficient in MS Office including Word, Excel, and Outlook.</li>
                            <li>Experience in using CRM.</li>
                            <li>Strong project and time management skills.</li>
                        </ul>
                        <h5>QUALIFICATION/EXPERIENCE REQUIRED</h5>
                        <ul>
                            <li>Bachelor’s degree in any field.</li>
                            <li>Experience in sales or relevant field.</li>
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
           // document.getElementById('loader-wrapper').style.visibility = 'visible';
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^\d{10,10}$/; // Adjust the regex based on your mobile number format
            // Get form values
            var name = document.getElementById('name').value;
            var email = document.getElementById('email').value;
            var jobType = document.getElementById('jobType').value;
            var cmobile = document.getElementById('cmobile').value;
            var resumePath = document.getElementById('resumePath').value;

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
                /*loaderWrapper.style.visibility = 'hidden';*/
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

