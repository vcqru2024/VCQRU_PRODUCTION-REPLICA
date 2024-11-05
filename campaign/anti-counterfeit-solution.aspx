<%@ Page Language="C#" AutoEventWireup="true" CodeFile="anti-counterfeit-solution.aspx.cs" Inherits="anti_counterfeit_solution" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anti-Counterfeit Solutions, Custom QR Code Generator, Smart Packaging Company | VCQRU</title>
    <!-- css -->
    <link rel="stylesheet" href="assets1/css/css.css">
    <link rel="stylesheet" href="assets1/css/responsive.css">
    <link rel="stylesheet" href="assets1/css/style.css">
    <!-- landing-css -->
    <link rel="stylesheet" href="assets1/css/landing.css">
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
        rel="stylesheet">
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

</head>
<body>
    <!-- navbar -->
    <div class="landing-navbar">
        <div class="container">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.html">
                        <img src="https://www.vcqru.com/NewContent/img-home/logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler shadow-none" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="mailto:madan@vcqru.com"><i class="fa-solid fa-envelope"></i>
                                    madan@vcqru.com</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="tel:9350726162"><i class="fa-solid fa-phone"></i> +91
                                    9350726162</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- navbar-end -->
    <!-- headers -->
    <div class="landing-header" id="landing-header">
        <div class="container">
            <div class="row g-4 align-items-center">
                <div class="col-xxl-7 col-xl-8 col-lg-7 col-md-6" data-aos="fade-up" data-aos-duration="1000">
                    <h1>Protect Your Brand From Counterfeiters And Stop Losing Revenues!</h1>
                    <p class="mb-0">For Brands, counterfeit products not only result in lost revenue and profits, but
                        also damage
                        their reputation and brand image.</p>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-5 col-md-6 offset-xxl-1">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Contact VCQRU</h5>
                            <form id="contact-form" class="needs-validation needs-validation" novalidate>
                                <div class="row align-items-center g-3">
                                    <div class="col-12">
                                        <input type="text" maxlength="50" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)" class="form-control" id="fname_cont2" placeholder="Full name"  required>
                                    </div>
                                    <div class="col-12">
                                        <input type="email" maxlength="40" class="form-control" id="email_cont2" placeholder="Email"
                                            required>
                                    </div>
                                    <div class="col-12">
                                        <input type="number" maxlength="10"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                            class="form-control" id="phone_cont2" placeholder="Mobile number" required>
                                    </div>
                                    <div class="col-12">
                                          <input type="text" maxlength="50" class="form-control" id="comp_mdl3" placeholder="Company Name" required>
                                    </div>
                                     <label id="lbl_cont2"></label>
                                    <div class="col-lg-12">
                                        <button type="button" id="btn_cont2" class="btn btn-primary" >submit</button>
                                        <button type="submit" style="display: none" id="btnloadsubmit" class="btn btn-primary"><i class="fa fa-spinner fa-spin"></i> Loading..</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- headers -->
    <!-- counter -->
    <section class="counter" data-aos="fade-up" data-aos-duration="1000">
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <div class="counter-col">
                                <ul>
                                    <li>
                                        <div class="count-img">
                                            <img src="assets1/img/product.png" alt="">
                                        </div>
                                    </li>
                                    <li>
                                        <h5 id="counter1"></h5>
                                        <p>Product's Authenticity Verified</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col count-left-border">
                            <div class="counter-col">
                                <ul>
                                    <li>
                                        <div class="count-img">
                                            <img src="assets1/img/build_loyalty.png" alt="">
                                        </div>
                                    </li>
                                    <li>
                                        <h5 id="counter2"></h5>
                                        <p>Products with Loyalty Campaigns</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col count-left-border">
                            <div class="counter-col">
                                <ul>
                                    <li>
                                        <div class="count-img">
                                            <img src="assets1/img/anti-counterfeit.png" alt="">
                                        </div>
                                    </li>
                                    <li>
                                        <h5 id="counter3"></h5>
                                        <p>Products under E-Warranty</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col count-left-border">
                            <div class="counter-col">
                                <ul>
                                    <li>
                                        <div class="count-img">
                                            <img src="assets1/img/E-warranty.png" alt="">
                                        </div>
                                    </li>
                                    <li>
                                        <h5 id="counter4"></h5>
                                        <p>Production Line Monitoring</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end -->
    <!-- about us -->
    <section class="landing-about-us">
        <div class="container">
            <div class="row">
                <div class="col-xxl-8 col-xl-8 col-lg-12" data-aos="fade-up" data-aos-duration="1000">
                    <h4>Safeguard Your Products Authenticity and Preserving Brand Trust with Advance
                        Anti-Counterfeit
                        Solution</h4>
                    <p class="mb-3">In today's global marketplace, Protecting products from duplicities and
                        maintaining the
                        authenticity
                        of your products and preserving brand trust and ensuring consumers confidence is a major
                        challenge
                        for many brands across various industries. Due to counterfeit products many companies/brands
                        loosing
                        our revenue and reputation as well as consumer safety. To address this challenge, many brand
                        owners
                        investing in comprehensive anti-counterfeiting solutions is not just choice; there is need.
                        Anti
                        Counterfeiting plays an important role in preventing and detecting counterfeiting
                        activities,
                        protecting the integrity of the brand and ensure consumer confidence in the authenticity of
                        products.</p>
                    <p class="mb-3">If we talk about Anti Counterfeit service providers then in market many are
                        available. On
                        those VCQRU
                        is one, where we bridge the gap between IT technologies and label printing and packaging. As
                        an
                        organization, we provide a unique platform that caters to brands across diverse domains such
                        as
                        healthcare, automobile, paint and building materials, plywood, FMCG, and more.</p>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-12 mb-3" data-aos="fade-up" data-aos-duration="2000">
                    <img src="assets1/img/landing-icons/anticounterfeit solution.jpg" alt=""
                        class="img-fluid w-100 border border-2">
                </div>
                <div class="col-lg-12" data-aos="fade-up" data-aos-duration="3000">
                    <p class="mb-3">A Through our cutting-edge holographic technologies, dynamic QR codes, serial
                        numbers, and
                        tamper-evident packaging solutions, we provide a multi-layered approach to brand security.
                        These
                        sophisticated features not only deter counterfeiters but also allow consumers to verify the
                        authenticity of your products with ease. In addition to our cutting-edge label and packaging
                        offerings, VCQRU provides cost-effective printing services, with or without security
                        features. Our
                        expert team assists you throughout the end-to-end process, from designing to printing and
                        packaging.
                    </p>
                    <p class="mb-0">Our comprehensive suite of services encompasses everything from design and
                        implementation to
                        ongoing
                        monitoring and analysis. Join us at VCQRU and experience the convergence of technology,
                        innovation,
                        and outstanding service for your brand's success.</p>
                </div>
            </div>
            <!--  -->
            <div class="about-icons mt-5">
                <div
                    class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-2 row-cols-1 g-xl-5 g-lg-4 g-md-4 g-3">
                    <div class="col" data-aos="fade-up" data-aos-duration="1000">
                        <ul>
                            <li>
                                <img src="assets1/img/Technology-about.svg" alt="Technology Professionals experts">
                            </li>
                            <li>
                                <div>
                                    <h3>10+</h3>
                                    <p>Technology Professionals experts</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col" data-aos="fade-up" data-aos-duration="1500">
                        <ul>
                            <li>
                                <img src="assets1/img/Client-satisfation.svg" alt="Client satisfaction score">
                            </li>
                            <li>
                                <div>
                                    <h3>4.5/5</h3>
                                    <p>Client satisfaction score</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col" data-aos="fade-up" data-aos-duration="2000">
                        <ul>
                            <li>
                                <img src="assets1/img/brand-manufaturer.svg" alt="Brands & Manufactrurer Clients">
                            </li>
                            <li>
                                <div>
                                    <h3>600+</h3>
                                    <p>Brands & Manufactrurer Clients</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col" data-aos="fade-up" data-aos-duration="2500">
                        <ul>
                            <li>
                                <img src="assets1/img/industries-served-clients.svg" alt="Industries Served Client">
                            </li>
                            <li>
                                <div>
                                    <h3>18+</h3>
                                    <p>Industries Served Client</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end -->
    <!-- why choose us -->
    <section class="why-choose-landing">
        <div class="container">
            <div class="card mb-5" data-aos="fade-up" data-aos-duration="1000">
                <div class="card-body">
                    <div class="row g-4">
                        <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 d-flex">
                            <img src="assets1/img/landing-icons/what-makes-us-different2.jpg" alt="Why choose us"
                                class="w-100 rounded">
                        </div>
                        <div class="col-xxl-8 col-xl-8 col-lg-8 col-md-12 d-flex">
                            <div class="w-100">
                                <h3 class="card-title">What makes us different from others.</h3>
                                <p>We empower small & medium-sized businesses by connecting them with customers,
                                    increasing
                                    customer retention through loyalty programs, breaking down the data barrier, and
                                    preventing counterfeit products. </p>
                                <div class="why-choose-list">
                                    <ul>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <h6>Ensuring Product Authenticity</h6>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Digital Authentication Platforms</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Strengthening Supply Chain Integrity</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Collaborative Measures</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Global Partnerships</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Consumer Education Initiatives</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Legal Action Against Counterfeiters</h6>
                                            </div>
                                        </li>
                                        <li>
                                            <img src="assets1/img/arrow-right-circle.svg" alt="arrow-right-circle">
                                            <div>
                                                <h6>Future-Ready Solutions</h6>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="landing-cal-outs">
                                <div
                                    class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-2 row-cols-2  g-3">
                                    <div class="col" data-aos="fade-up" data-aos-duration="1000">
                                        <img src="assets1/img/landing-icons/pan_india.png" alt="PAN India Services">
                                        <p>PAN India Services</p>
                                    </div>
                                    <div class="col" data-aos="fade-up" data-aos-duration="1500">
                                        <img src="assets1/img/landing-icons/cost_effective.png" alt="Cost-effective">
                                        <p>Cost-effective</p>
                                    </div>
                                    <div class="col" data-aos="fade-up" data-aos-duration="2000">
                                        <img src="assets1/img/landing-icons/hassle_free.png"
                                            alt="Hassle free implementation">
                                        <p>Hassle free implementation</p>
                                    </div>
                                    <div class="col" data-aos="fade-up" data-aos-duration="2500">
                                        <img src="assets1/img/landing-icons/24x7.png" alt="24*7 Customer Support">
                                        <p>24*7 Customer Support</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="how-our-landing" data-aos="fade-up" data-aos-duration="1000">
                <img src="assets1/img/landing-icons/How-our-Anti-Counterfeit-Services-are-different-from-others.jpg"
                    alt="" class="img-fluid h-50 w-100">
                <div class="card">
                    <div class="card-body">
                        <div class="web-heading">
                            <h3 class="card-title">How our Anti-Counterfeit Services are different from others?</h3>
                            <p>We employ a unique algorithm to generate security codes that are resistant to
                                guessing and
                                cannot be
                                generated through human-perceivable permutations and combinations. We guarantee that
                                only
                                authorized
                                and legitimate brand owners with product ownership can access our services.
                                The Anticounterfeit service achieves foolproof security through a synergy of human,
                                machine,
                                and
                                AI-based anticounterfeiting analysis.
                            </p>
                            <div class="text-center mt-4">
                                <a href="Landing.aspx" class="btn btn-primary btn-lg">Have Any Query?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--  -->
    <!-- end -->
    <!-- Reviews From Our Client -->
    <section class="reviews">
        <div class="container">
            <div class="row g-xl-4 g-lg-4 g-md-3 g-3">
                <div class="col-lg-4">
                    <div class="web-heading">
                        <h1>What our Clients Say</h1>
                        <p>We desire that the current generation and the generations to come, do not have to worry about
                            the fakes and counterfeits.</p>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="reviews-card">
                        <div id="reviewsSliders" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active" data-bs-interval="10000">
                                    <div class="row g-3">
                                        <div class="col-md-6 d-flex d-md-block d-none" data-aos="fade-up" data-aos-duration="1000">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="assets1/img/user.png" alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Abhishek Singh</h5>
                                                            <p>CEO of Tech Pvt. Ltd.</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>This company have unique and advanced technical services to grow
                                                        the business. The company services helped us to connect directly
                                                        to our customers, so that we could make our marketing and
                                                        business strategies better.</p>
                                                    <div class="reviews-star">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 d-flex" data-aos="fade-up" data-aos-duration="2000">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="assets1/img/user.png" alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Rajesh Mishra</h5>
                                                            <p>Customer</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>VCQRU has done a great job keeping in mind about our business
                                                        idea and developing software as per our niche specifications.
                                                        The team is technically strong and creative. Thanks, and keep up
                                                        the same service and hard work!</p>
                                                    <div class="reviews-star">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <div class="row g-3">
                                        <div class="col-md-6 d-flex d-md-block d-none" data-aos="fade-up" data-aos-duration="1000">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="assets1/img/user.png" alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Vikash Rathi</h5>
                                                            <p>Customer</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>VCQRU is driven by passionate employees to create and deliver on
                                                        new ideas which is reflected in their work. It is a team that
                                                        strives for excellence and is open to experimenting and creating
                                                        new trends in the business.</p>
                                                    <div class="reviews-star">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                        <i class="fa fa-star text-secondary"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 d-flex" data-aos="fade-up" data-aos-duration="2000">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="assets1/img/user.png" alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Rajeeb Shukhla</h5>
                                                            <p>Client</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>Thank you VCQRU for your valuable support to our business. You
                                                        have not only shown the commitment and dedication in our
                                                        project, but also focused on those minute details that were
                                                        missing from our end. Great Job!</p>
                                                    <div class="reviews-star">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- <button class="carousel-control-prev" type="button"
                                data-bs-target="#reviewsSliders" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button> -->
                            <button class="carousel-control-next" type="button" data-bs-target="#reviewsSliders"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true">></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Our Industries Associations -->
    <section class="industries bg-white">
        <div class="container">
            <div class="web-heading mb-4">
                <h1>Trusted By 1000+ Clients</h1>
                <p>Let's join our famous class, the knowledge provided will definitely be useful for you.</p>
            </div>
            <div class="industries-logo border rounded-3">
                <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <ul>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/mahindra.png"
                                        alt="Mahinder-Rise">
                                </li>
                                <li>
                                    <img src="assets1/img/Jal.svg" alt="Jal">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/pp_organics-logo.png"
                                        alt="TigerCoat">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/flora.png" alt="Flora">
                                </li>
                                <li>
                                    <img src="assets1/img/bsc-paints.svg" alt="bsc-paints">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/mealo.png" alt="bsc-paints">
                                </li>
                            </ul>
                        </div>
                        <div class="carousel-item">
                            <ul>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/ColorValley-logo.png"
                                        alt="Mahinder-Rise">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/mealo.png" alt="Jal">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/oci-cable.png" alt="TigerCoat">
                                </li>
                                <li>
                                    <img src="assets1/img/Flora.svg" alt="Flora">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/pink_lotus.png"
                                        alt="bsc-paints">
                                </li>
                                <li>
                                    <img src="https://www.vcqru.com/NewContent/img-home/auto-park.png" alt="bsc-paints">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--  -->
    <!-- You can Find on -->
    <section class="findon">
        <div class="container">
            <div class="row g-xl-4 g-md-3 g-3">
                <div class="col-lg-5">
                    <div class="web-heading">
                        <h1>You can Find on</h1>
                        <p>We desire that the current generation and the generations to come, do not have to worry about
                            the
                            fakes and counterfeits. We believe in " connecting with the heart and mind of consumers",
                            and our technology and offerings are all centered on it.</p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div id="carouselExampleRide" class="carousel slide" data-bs-ride="true">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <div class="card">
                                    <div class="card-body">
                                        <img src="assets1/img/silicon-india.svg" alt="SiliconIndia">
                                        <h5>VCQRU: Bringing Customers Closer To Their Brands</h5>
                                        <p>In this era of modernization and sustainability, age-old plastic coupons and
                                            loyalty programs are not just outdated but also a hazard. Since QR codes
                                            surfaced in the market, it has become one of the most brilliant tools when
                                            it comes to marketing known to boost customer engagement and therefore,
                                            driving customer loyalty.</p>
                                        <a href="https://enterprise-services.siliconindia.com/vendor/vcqru-bringing-customers-closer-to-their-brands-cid-15348.html"
                                            target="_blank" class="btn btn-outline-primary">Read more</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="card">
                                    <div class="card-body">
                                        <img src="assets1/img/psa-logo-2.jpg" alt="packagingsouthasia">
                                        <h5>Webinar on credible traceability</h5>
                                        <p>While traceability is becoming a regulatory requirement across many
                                            industries, there is a need to move from traditional models to comprehensive
                                            copy-proof protection. Today’s supply chain is impacted by the clonability
                                            of barcodes and QR Codes despite the track and trace solutions in place.
                                        </p>
                                        <a href="https://packagingsouthasia.com/application/webinar-on-traceability/"
                                            target="_blank" class="btn btn-outline-primary">Read more</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleRide"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button> -->
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleRide"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true">></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- footer -->
    <footer>
        <div class="landing-footer">
            <div class="container">
                <div class="row align-items-center g-3">
                    <div class="col-lg-6">
                        <p class="text-lg-start text-md-center">© Copyright 2023 VCQRU Private Limited | All Rights
                            Reserved.</p>
                    </div>
                    <div class="col-lg-6">
                        <ul>
                            <li>
                                <a href="https://www.vcqru.com/Terms_Conditions.aspx" target="_blank">Terms of Use</a>
                            </li>
                            |
                            <li>
                                <a href="https://www.vcqru.com/Privacy_Policy.aspx" target="_blank">Privacy Policy</a>
                            </li>
                            |
                            <li>
                                <a href="https://www.vcqru.com/about-us.aspx" target="_blank">About Us</a>
                            </li>
                            |
                            <li>
                                <a href="https://www.vcqru.com/Contact.aspx" target="_blank">Contact Us</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- js -->
    <script src="assets1/js/index.js"></script>
    <!-- counter -->
    <script>
        let upto1 = 9950000;
        let upto2 = 8950000;
        let upto3 = 40598;
        let upto4 = 9157;

        let countElement1 = document.getElementById("counter1");
        let countElement2 = document.getElementById("counter2");
        let countElement3 = document.getElementById("counter3");
        let countElement4 = document.getElementById("counter4");

        function updateCounter1() {
            countElement1.innerHTML = ++upto1;
            if (upto1 === 1500) {
                clearInterval(counter1);
            }
        }

        function updateCounter2() {
            countElement2.innerHTML = ++upto2;
            if (upto2 === 2500) {
                clearInterval(counter2);
            }
        }

        function updateCounter3() {
            countElement3.innerHTML = ++upto3;
            if (upto3 === 3500) {
                clearInterval(counter3);
            }
        }

        function updateCounter4() {
            countElement4.innerHTML = ++upto4;
            if (upto4 === 4500) {
                clearInterval(counter4);
            }
        }

        let counter1 = setInterval(updateCounter1, 500); // Counter 1 increments every 500ms
        let counter2 = setInterval(updateCounter2, 700); // Counter 2 increments every 700ms
        let counter3 = setInterval(updateCounter3, 900); // Counter 3 increments every 900ms
        let counter4 = setInterval(updateCounter4, 1100); // Counter 4 increments every 1100ms
    </script>
     <script>
         // Example starter JavaScript for disabling form submissions if there are invalid fields
         (() => {
             'use strict'

             // Fetch all the forms we want to apply custom Bootstrap validation styles to
             const forms = document.querySelectorAll('.needs-validation')

             // Loop over them and prevent submission
             Array.from(forms).forEach(form => {
                 form.addEventListener('submit', event => {
                     if (!form.checkValidity()) {
                         event.preventDefault()
                         event.stopPropagation()
                     }

                     form.classList.add('was-validated')
                 }, false)
             })
         })()

     </script>
    <!-- validdation-->

    <script src="https://qa.vcqru.com/vendor/jquery/jquery.min.js"></script>
    <!--  -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>
<script>
    $(document).ready(function () {
        $('#btn_cont2').click(function (e) {
            /* debugger;*/

            e.preventDefault();


            //$('#fname_cont2').on('input', function () {
            //    var inputValue = $(this).val();
            //    var sanitizedValue = inputValue.replace(/[^a-zA-Z]/g, ''); // Remove any non-alphabetical characters
            //    $(this).val(sanitizedValue);
            //});
            var fullName = $('#fname_cont2').val();

            // Check if the first character is a space
            if (fullName.charAt(0) === ' ') {
                $('#lbl_cont2').text('Enter Correct Name');
                $('#lbl_cont2').css("color", "red");
                $('#fname_cont2').focus();
                $('#fname_cont2').val('');
                return false;
            }

            // The rest of your existing validation code

            if (fullName == "") {
                $('#lbl_cont2').text('Field is Required*');
                $('#lbl_cont2').css("color", "red");
                $('#fname_cont2').focus();
                return false;
            }

            var filter = /^[a-zA-Z ]+$/;
            if (!filter.test(fullName)) {
                $('#lbl_cont2').text('Enter valid Name (only letters and spaces)*');
                $('#lbl_cont2').css("color", "red");
                $('#fname_cont2').focus();
                return false;
            }



            var emailID = $('#email_cont2').val();
            if (emailID == "") {
                $('#lbl_cont2').text('Field is Required*');
                $('#lbl_cont2').css("color", "red");
                $('#email_cont2').focus();
                return false;
            }

            var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (!filter.test(emailID)) {
                $('#lbl_cont2').text('Invalid Email Id*');
                $('#lbl_cont2').css("color", "red");
                $('#email_cont2').focus();
                $('#email_cont2').val('');
                return false;
            }
            if (emailID.length > 30) {
                $('#lbl_cont2').text('Email Address is too long (max 30 characters)*');
                $('#lbl_cont2').css("color", "red");
                $('#email_cont2').focus();
                return false;
            }

            var phoneRpf = $('#phone_cont2').val();
            if (phoneRpf == "") {
                $('#lbl_cont2').text('Field is Required*');
                $('#lbl_cont2').css("color", "red");
                $('#phone_cont2').focus();
                return false;
            }
            if (phoneRpf.length != 10) {
                $('#lbl_cont2').text('Please enter 10 digit mobile number*');
                $('#lbl_cont2').css("color", "red");
                $('#phone_cont2').focus();
                return false;
            }


            var filter = /^(\+\d{1,3}[- ]?)?\d{10}$/;
            if (!filter.test(phoneRpf)) {
                $('#lbl_cont2').text('Invalid Mobile Number*');
                $('#lbl_cont2').css("color", "red");
                $('#phone_cont2').focus();
                return false;
            }

            //var companyname = $('#comp_mdl3').val();
            // if (companyname == "") {
            //     $('#lbl_cont2').text('Field is Required*');
            //     $('#lbl_cont2').css("color", "red");
            //     $('#comp_mdl3').focus();
            //     return false;
            // }
            var companyname = $('#comp_mdl3').val();

            // Check if the first character is a space
            if (companyname.charAt(0) === ' ') {
                $('#lbl_cont2').text('Enter Correct Name');
                $('#lbl_cont2').css("color", "red");
                $('#comp_mdl3').focus();
                $('#comp_mdl3').val('');
                return false;
            }

            // The rest of your existing validation code

            if (companyname == "") {
                $('#lbl_cont2').text('Field is Required*');
                $('#lbl_cont2').css("color", "red");
                $('#comp_mdl3').focus();
                return false;
            }

            window.location = "https://www.vcqru.com/campaign/thank-you.aspx";
            // var tesxturl = 'http://localhost:55133/Info/MasterHandler.ashx?method=sendqueryLandingPageContact&name=' + fullName + '&email=' + emailID + '&phone=' + phoneRpf + '&companyName=' + companyname;
            /*  alert(tesxturl);*/
            if (fullName != "" && emailID != "") {
                $("#btn_cont2").show();
                //$('#btn_cont2').text('Sending.......');
                //$('#btn_cont2').css("color", "white");
                //$('#btnloadsubmit').show();
                //$('#btn_cont2').prop('disabled', true);
                $.ajax({
                    type: "POST",
                    url: 'https://www.vcqru.com/Info/MasterHandler.ashx?method=sendqueryLandingPageContact&name=' + fullName + '&email=' + emailID + '&phone=' + phoneRpf + '&companyName=' + companyname,

                    success: function (data) {
                        document.getElementById('contact-form').reset();
                        //alert(data);
                        //$('#div_cont2').hide();
                        //$('#div_success2').show();



                    },
                    error: function (data) {
                        //$('#resultMsg').text(data);
                        //$('#resultMsg').css("color", "red");
                        //$("#submitbtnRFP").show();
                        // alert(data);
                    },
                });
            }


        });

    });


</script>
