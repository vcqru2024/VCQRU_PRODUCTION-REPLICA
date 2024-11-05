<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="../NewContent/front-assets/css/owl.carousel.min.css">
    <meta name="title" content="Leading and Most Trusted IT Company in Anti-counterfeit" />
    <meta name="description"
        content="VCQRU is a leading and most trusted IT Company in Anti-counterfeit, offering a wide range of custom QR code, smart packaging, loyalty programs, labels stickers, e-warranty solutions, security labels & digital marketing services." />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="header">
        <div class="overlay-header"></div>
        <video playsinline="true"  autoplay="true" loop="true" runat="server" controlslist="nodownload" msallowfullscreen="true" muted="true">
                <source src="../NewContent/front-assets/video/home-page-video-header.mp4" type="video/mp4">
            </video>
    </section>
    <!-- counter -->
    <section class="counter">
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <div class="counter-col">
                                <ul>
                                    <li>
                                        <div class="count-img">
                                            <img src="../NewContent/front-assets/img/counter/anti-counterfeit.svg"
                                                alt="anti-counterfeit">
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
                                            <img src="../NewContent/front-assets/img/counter/build-loyalty.svg"
                                                alt="build-loyalty">
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
                                            <img src="../NewContent/front-assets/img/counter/e-warranty.svg"
                                                alt="e-warranty">
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
                                            <img src="../NewContent/front-assets/img/counter/production-monitoring.svg"
                                                alt="production-monitoring">
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
    <!-- gif section-slider -->
    <section class="video-section">
        <div class="container">
            <div
                class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-2 row-cols-1 g-xxl-5 g-xl-5 g-lg-4 g-md-3 g-3">
                <div class="col">
                    <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                        msallowfullscreen="true" muted="true"
                        src="../NewContent/front-assets/video/happy-cleint.mp4">
                    </video>
                    <p>happy client</p>
                </div>
                <div class="col">
                    <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                        msallowfullscreen="true" muted="true"
                        src="../NewContent/front-assets/video/how-to-stop-fake.mp4">
                    </video>
                    <p>how to stop fake</p>
                </div>
                <div class="col">
                    <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                        msallowfullscreen="true" muted="true"
                        src="../NewContent/front-assets/video/VCQRU-smart-services.mp4">
                    </video>
                    <p>VCQRU smart services</p>
                </div>
                <div class="col">
                    <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                        msallowfullscreen="true" muted="true"
                        src="../NewContent/front-assets/video/How-we-work.mp4">
                    </video>
                    <p>how we work</p>
                </div>
            </div>
        </div>
    </section>
    <!-- company over-view -->
    <section class="company-overview">
        <div class="container">
            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-4">
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/quality_control.svg"
                                        alt="quality_control">
                                </li>
                                <li>
                                    <h5 class="card-title">Quality
                                        <br>
                                        Control</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Quality assurance processes for the production of anti-counterfeit
                                    materials.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/cost-efeective.svg"
                                        alt="cost-efeective">
                                </li>
                                <li>
                                    <h5 class="card-title">Cost
                                        <br>
                                        Effectiveness</h5>
                                </li>
                            </ul>
                            <p class="card-text">Competitive pricing and transparent cost structures.</p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/expertise-experience.svg"
                                        alt="expertise-experience">
                                </li>
                                <li>
                                    <h5 class="card-title">Expertise and
                                        <br>
                                        Experience</h5>
                                </li>
                            </ul>
                            <p class="card-text">Years of experience in the anti-counterfeit industry.</p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Technology.svg" alt="Technology">
                                </li>
                                <li>
                                    <h5 class="card-title">Technology and
                                        <br>
                                        Innovation.</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Utilization of cutting-edge technologies like RFID, blockchain,
                                    holograms, & more.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/data_security.svg" alt="data_security">
                                </li>
                                <li>
                                    <h5 class="card-title">Data
                                        <br>
                                        Security</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Strong data protection measures to safeguard sensitive information.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Customer.svg" alt="Customer">
                                </li>
                                <li>
                                    <h5 class="card-title">24*7 Customer
                                        <br>
                                        Support</h5>
                                </li>
                            </ul>
                            <p class="card-text">Our expert team are available 24*7 for solving your queries.</p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/digital-physical.png"
                                        alt="digital-physical">
                                </li>
                                <li>
                                    <h5 class="card-title">Digital and
                                        <br>
                                        Physical</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                We provide combined physical & digital security for your products
                                    and
                                    brand.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/transparency.png" alt="transparency">
                                </li>
                                <li>
                                    <h5 class="card-title">Transparancy</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Clear and open client communication. Detailed reports & analytics
                                    on
                                    Anti Counterfeit performance.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/ready-to-go-solution.png"
                                        alt="ready-to-go-solution">
                                </li>
                                <li>
                                    <h5 class="card-title">Ready to
                                        <br>
                                        go Solution</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                We offer various options for new brands to address
                                    anti-counterfeiting
                                    concerns in a comprehensive & customizable way.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/continues_improvemnt.png"
                                        alt="continues_improvemnt">
                                </li>
                                <li>
                                    <h5 class="card-title">Continuous<br>
                                        Improvement </h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Commitment to stay ahead of counterfeiters by developing and
                                    improving
                                    anti-counterfeiting solutions.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/global_reach.png" alt="global_reach">
                                </li>
                                <li>
                                    <h5 class="card-title">Global
                                        <br>
                                        Reach </h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                A global presence or partnerships to address counterfeiting on a
                                    global scale.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/scalability.png" alt="scalability">
                                </li>
                                <li>
                                    <h5 class="card-title">Scalability</h5>
                                </li>
                            </ul>
                            <p class="card-text">
                                Ability to scale solutions to meet the needs of both small and
                                    large
                                    businesses.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mx-auto">
                    <div class="cta">
                        <a href="../contact-us.aspx" class="btn btn-primary btn-lg w-100">Get A Free Demo</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Our Industries Associations -->
    <section class="industries">
        <div class="container">
            <div class="web-heading">
                <h1>Trusted By 1000+ Clients</h1>
                <p>Let's join our famous class, the knowledge provided will definitely be useful for you.</p>
            </div>
            <div class="industries-logo">
                <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
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
    <!-- about us -->
    <section class="about-us">
        <div class="container">
            <div class="row g-3">
                <div class="col-xxl-8 col-xl-8 col-lg-12 col-md-12">
                    <div class="about-content">
                        <h1>Grow with <span>VCQRU</span> Family</h1>
                        <p>
                            Welcome to VCQRU, where we bridge the gap between IT technologies and label printing and
                                packaging. As an organization, we provide a unique platform that caters to brands across
                                diverse
                                domains such as healthcare, automobile, paint and building materials, plywood, FMCG, and
                                more.
                        </p>
                        <p>
                            Our goal is to offer comprehensive, one-stop solutions for all your technological and
                                packaging
                                needs. We offer an array of smart labels and packaging solutions, anti-counterfeit
                                solutions,
                                personalized QR codes, e-warranty, loyalty building, web design and development, digital
                                marketing services, Track & Trace, cash transfer, referral services as well as gift
                                vouchers.
                        </p>
                    </div>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-12 col-md-12">
                    <div class="about-video">
                        <video playsinline="true" autoplay="true" loop="true" controlslist="nodownload"
                            msallowfullscreen="true" muted="true">
                            <source src="../NewContent/front-assets/video/about-us.mp4" type="video/mp4">
                        </video>
                    </div>
                </div>
                <div class="col-12">
                    <p class="text-secondary">
                        In addition to our cutting-edge label and packaging offerings, VCQRU provides cost-effective
                            printing services, with or without security features. Our expert team assists you throughout
                            the
                            end-to-end process, from designing to printing and packaging.
                    </p>
                    <p class="text-secondary mb-0">
                        Join us at VCQRU and experience the convergence of technology, innovation, and outstanding
                            service for your brand's success.
                    </p>
                </div>
            </div>
            <div class="about-icons">
                <div class="row g-3">
                    <div class="col-xl-3 col-lg-6 col-md-6">
                        <ul>
                            <li>
                                <img src="../NewContent/front-assets/img/Technology-about.svg"
                                    alt="Technology-about">
                            </li>
                            <li>
                                <div>
                                    <h3>100+</h3>
                                    <p>Domain experts</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col-xl-3 col-lg-6 col-md-6">
                        <ul>
                            <li>
                                <img src="../NewContent/front-assets/img/Client-satisfation.svg"
                                    alt="Client-satisfation">
                            </li>
                            <li>
                                <div>
                                    <h3>4.5/5</h3>
                                    <p>Client satisfaction score</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col-xl-3 col-lg-6 col-md-6">
                        <ul>
                            <li>
                                <img src="../NewContent/front-assets/img/brand-manufaturer.svg"
                                    alt="brand-manufaturer">
                            </li>
                            <li>
                                <div>
                                    <h3>600+</h3>
                                    <p>Brands & Manufacturer Clients</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="col-xl-3 col-lg-6 col-md-6">
                        <ul>
                            <li>
                                <img src="../NewContent/front-assets/img/industries-served-clients.svg"
                                    alt="industries-served-clients">
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
            <div class="text-center">
                <a href="../contact-us.aspx" class="btn btn-primary btn-lg px-5">Contact Us</a>
            </div>
        </div>
    </section>
    <!-- What’s Makes Us Different -->
    <section class="why-choose">
        <div class="container">
            <div class="web-heading mb-5">
                <h1>What’s Makes Us Different</h1>
                <p>
                    We are a product-based IT organization. Our headquarter is in Gurgaon and our marketing team
                        works
                        from Kolkata, Pune, Mumbai, Punjab, Hyderabad, Ahmedabad, Bangalore, UP -Kanpur,
                        Jaipur/Rajasthan,
                        Daman & Diu, Nagpur, Baddi.
                </p>
            </div>
            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-4">
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/PAN-India.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">PAN India
                                        <br>
                                        Service</h5>
                                </li>
                            </ul>
                            <p>
                                Last 10 years we are delivering our services to 600+ clients at PAN India. Trusted by
                                    industry leaders like Mahindra & Mahindra, JPC, JAL, Patanjali, Sky Decor, Alstone,
                                    and
                                    many more.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Multiple-Verification.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">Multiple Verification
                                        <br>
                                        Modes</h5>
                                </li>
                            </ul>
                            <p>
                                Unlocking identity with versatility! VCQRU ensures top-notch user verification with
                                    Multiple Verification Modes that align with community standards and ensures user
                                    identity.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Industries-Serving.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">20+ Industries
                                        <br>
                                        Serving</h5>
                                </li>
                            </ul>
                            <p>
                                We are delivering solutions to 20+ industries! Our dedicated team excels in
                                    delivering
                                    tailored solutions across diverse market domains. Meet our team and get customize
                                    solutions for your business.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Pending-Technology.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">Patent Pending
                                        <br>
                                        Technology</h5>
                                </li>
                            </ul>
                            <p>
                                Revolutionizing with our patent-pending tech! Committed to innovation, we track
                                    industry
                                    trends and collaborate with clients for constant improvement.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Compromise.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">No Compromise
                                        <br>
                                        in Quality</h5>
                                </li>
                            </ul>
                            <p>
                                Replace with " Award Wining "
                                    VCQRU proudly stands out! Being recognized by a reputable media outlet is an
                                    important
                                    achievement,
                                    Recognized by Hindustan Times as a top Anti-Counterfeit IT company.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <div class="card-body">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/Language.svg" alt="One">
                                </li>
                                <li>
                                    <h5 class="card-title">Multi Language
                                        <br>
                                        Support</h5>
                                </li>
                            </ul>
                            <p>
                                We have a multi-lingual support system in 12 different languages. Our multi-lingual
                                    team
                                    is fluent in diverse languages and caters to your needs, providing assistance in
                                    your
                                    preferred language!
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Explore Our Services -->
    <section class="our-services">
        <div class="container">
            <div class="web-heading mb-5">
                <h1>Explore Our Services</h1>
                <p>
                    We desire that the current generation and the generations to come, do not have to worry about
                        the
                        fakes and counterfeits. We believe in " connecting with the heart and mind of consumers", and
                        our
                        technology and offerings are all centered on it.
                </p>
            </div>
            <div class="row g-4 row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1">
                <div class="col d-flex">
                    <div class="card" style="background-color: #DEF2EB;">
                        <div class="card-body">
                            <a href="../anti-counterfeiting-solutions.aspx">
                                <img src="../NewContent/front-assets/img/product-icons/anti-counterfeit.svg"
                                    alt="Anti-counterfeit">
                                <h5 class="card-title">Anti-Counterfeit Solution </h5>
                                <p class="card-text">
                                    Counterfeit products have serious consequences for brands and consumers. For
                                        brands,
                                        they cause financial losses, harm their reputation and brand image.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #e2deff;">
                        <div class="card-body">
                            <a href="../customer-loyalty-program.aspx">
                                <img src="../NewContent/front-assets/img/product-icons/build-loyalty.svg"
                                    alt="Build-Loyalty/ Coupon">
                                <h5 class="card-title">Build-Loyalty Program</h5>
                                <p class="card-text">
                                    Customer loyalty is a major challenge for businesses today, as customers now
                                        have
                                        more
                                        power and options than ever before.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #ffe8e8;">
                        <div class="card-body">
                            <a href="../digital-e-warranty-management-solution.aspx">
                                <img src="../NewContent/front-assets/img/product-icons/e-warranty.svg"
                                    alt="E-warranty">
                                <h5 class="card-title">E-Warranty Services</h5>
                                <p class="card-text">
                                    E-warranty services simplify the warranty claim process for customers,
                                        manufacturers,
                                        and retailers, providing a direct connection between customers and
                                        manufacturers.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #FFF5D7;">
                        <div class="card-body">
                            <a href="../anti-counterfeit-solution-for-ecommerce-industry.aspx">
                                <img src="../NewContent/front-assets/img/product-icons/Ecommerce.svg"
                                    alt="E-commerce">
                                <h5 class="card-title">E-commerce Solutions</h5>
                                <p class="card-text">
                                    Counterfeiting is a big problem in e-commerce, as it allows counterfeiters to
                                        easily
                                        sell fake products to unaware customers. To address this issue.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #F0F5F2;">
                        <div class="card-body">
                            <a href="../website-design-and-development-company.aspx">
                                <img src="../NewContent/front-assets/img/product-icons/website-design-development.svg"
                                    alt="Web & App Development">
                                <h5 class="card-title">Web & App Development</h5>
                                <p class="card-text">
                                    Being recognized by a reputable media outlet is an important
                                        achievement, VCQRU takes
                                        pride featured in Hindustan Times as one of the leading IT companies in
                                        Anti-Counterfeit.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card" style="background-color: #ffe9f4;">
                        <div class="card-body">
                            <a href="https://digitalmarketing.vcqru.com/" target="_blank">
                                <img src="../NewContent/front-assets/img/product-icons/digital-marketing.svg"
                                    alt="Digital Marketing Services">
                                <h5 class="card-title">Digital Marketing Services</h5>
                                <p class="card-text">
                                    According to the Global Digital Marketing Market Report, the
                                        global
                                        digital marketing market is aided by the increasing number of internet users and
                                        the
                                        growing adoption of intelligent devices.
                                </p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="../contact-us.aspx" class="btn btn-primary px-5 btn-lg">Let's Connect</a>
            </div>
        </div>
    </section>
    <!-- Reviews From Our Client -->
    <section class="reviews">
        <div class="container">
            <div class="row g-xl-4 g-lg-4 g-md-3 g-3">
                <div class="col-lg-4">
                    <div class="web-heading">
                        <h1>What our Clients Say</h1>
                        <p>
                            We desire that the current generation and the generations to come, do not have to worry
                                about
                                the fakes and counterfeits.
                        </p>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="reviews-card">
                        <div id="reviewsSliders" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="row g-3">
                                        <div class="col-md-6 d-flex">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="../NewContent/front-assets/img/user.png"
                                                                alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Abhishek Singh</h5>
                                                            <p>CEO of Tech Pvt. Ltd.</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>
                                                        This company have unique and advanced technical services to
                                                            grow
                                                            the business. The company services helped us to connect
                                                            directly
                                                            to our customers, so that we could make our marketing and
                                                            business strategies better.
                                                    </p>
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
                                        <div class="col-md-6 d-flex">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="../NewContent/front-assets/img/user.png"
                                                                alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Rajesh Mishra</h5>
                                                            <p>Customer</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>
                                                        VCQRU has done a great job keeping in mind about our business
                                                            idea and developing software as per our niche
                                                            specifications.
                                                            The team is technically strong and creative. Thanks, and
                                                            keep up
                                                            the same service and hard work!
                                                    </p>
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
                                <div class="carousel-item">
                                    <div class="row g-3">
                                        <div class="col-md-6 d-flex">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="../NewContent/front-assets/img/user.png"
                                                                alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Vikash Rathi</h5>
                                                            <p>Customer</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>
                                                        VCQRU is driven by passionate employees to create and deliver
                                                            on
                                                            new ideas which is reflected in their work. It is a team
                                                            that
                                                            strives for excellence and is open to experimenting and
                                                            creating
                                                            new trends in the business.
                                                    </p>
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
                                        <div class="col-md-6 d-flex">
                                            <div class="card">
                                                <div class="card-body">
                                                    <ul>
                                                        <li>
                                                            <img src="../NewContent/front-assets/img/user.png"
                                                                alt="User Img">
                                                        </li>
                                                        <li>
                                                            <h5>Rajeeb Shukhla</h5>
                                                            <p>Client</p>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body">
                                                    <p>
                                                        Thank you VCQRU for your valuable support to our business.
                                                            You
                                                            have not only shown the commitment and dedication in our
                                                            project, but also focused on those minute details that were
                                                            missing from our end. Great Job!
                                                    </p>
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
    <!-- Industries We Cover -->
    <section class="industries-section">
        <div class="container">
            <div class="web-heading">
                <h1>Industries We Cover</h1>
                <p>
                    We desire that the current generation and the generations to come, do not have to worry about the
                        fakes and counterfeits. We believe in " connecting with the heart and mind of consumers", and
                        our
                        technology and offerings are all centered on it.
                </p>
            </div>
            <div class="row">
                <div class="col-xxl-10 col-xl-10 col-lg-11 mx-auto">
                    <div class="card">
                        <div class="card-body">
                            <div
                                class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-3 row-cols-md-2 row-cols-1 g-4">
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-fmcg-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/FMCG.svg" alt="FMCG">
                                        FMCG
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-cosmetic-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/cosmetics.svg"
                                            alt="Cosmetics">
                                        Cosmetics
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-consumer-electronics-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/consumer-electronics.svg"
                                            alt="Consumer">
                                        Consumer Electronics
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeiting-solutions-for-auto-parts-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/auto-parts.svg"
                                            alt="Auto Parts">
                                        Auto Parts
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-health-supplements-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/health-supplements.svg"
                                            alt="Health Supplements">
                                        Health Supplements
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-agro-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/agro.svg" alt="Agro">
                                        Agro
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-tobacco-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/tobacco.svg"
                                            alt="Tobacco">
                                        Tobacco
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-liquor-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/liquor.svg"
                                            alt="Liquor">
                                        Liquor
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-bfsi-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/bfsi.svg" alt="BFSI">
                                        BFSI
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-consumer-electronics-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/electronic-electricals.svg"
                                            alt="Electronics &amp; Electricals">
                                        Electronics &amp; Electricals
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solution-for-ecommerce-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/ecommerce.svg"
                                            alt="E-Commerce">
                                        E-Commerce
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-education-and-stationery-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/education-stationery.svg"
                                            alt="education">
                                        Education &amp; Stationery
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../brand-protection-solutions-for-sports-fitness-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/sports-fitness.svg"
                                            alt="Sports and Fitness">
                                        Sports &amp; Fitness
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-apparel-and-fashion-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/apparels-fashion.svg"
                                            alt="Apparels Fashion">
                                        Apparels &amp; Fashion
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeiting-solutions-for-government-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/government.svg"
                                            alt="Government">
                                        Government
                                    </a>
                                </div>
                                <div class="col d-flex">
                                    <a href="../anti-counterfeit-solutions-for-pharma-industry.aspx">
                                        <img src="../NewContent/front-assets/img/industry-icon/pharma.svg"
                                            alt="Pharma">
                                        Pharma
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- You can Find on -->
    <section class="findon">
        <div class="container">
            <div class="row g-xl-4 g-md-3 g-3">
                <div class="col-lg-5">
                    <div class="web-heading">
                        <h1>You can Find on</h1>
                        <p>
                            We desire that the current generation and the generations to come, do not have to worry
                                about
                                the
                                fakes and counterfeits. We believe in " connecting with the heart and mind of
                                consumers",
                                and our technology and offerings are all centered on it.
                        </p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div id="carouselExampleRide" class="carousel slide" data-bs-ride="true">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <div class="card">
                                    <div class="card-body">
                                        <img src="../NewContent/front-assets/img/silicon-india.svg"
                                            alt="SiliconIndia">
                                        <h5>VCQRU: Bringing Customers Closer To Their Brands</h5>
                                        <p>
                                            In this era of modernization and sustainability, age-old plastic coupons
                                                and
                                                loyalty programs are not just outdated but also a hazard. Since QR codes
                                                surfaced in the market, it has become one of the most brilliant tools
                                                when
                                                it comes to marketing known to boost customer engagement and therefore,
                                                driving customer loyalty.
                                        </p>
                                        <a href="https://enterprise-services.siliconindia.com/vendor/vcqru-bringing-customers-closer-to-their-brands-cid-15348.html"
                                            target="_blank" class="btn btn-outline-primary">Read more</a>
                                    </div>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="card">
                                    <div class="card-body">
                                        <img src="../NewContent/front-assets/img/psa-logo-2.jpg"
                                            alt="packagingsouthasia">
                                        <h5>Webinar on credible traceability</h5>
                                        <p>
                                            While traceability is becoming a regulatory requirement across many
                                                industries, there is a need to move from traditional models to
                                                comprehensive
                                                copy-proof protection. Today’s supply chain is impacted by the
                                                clonability
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
     <!-- Our Awards And Recognitions -->
    <section class="our-certificate" id="slider">
        <div class="container">
            <div class="web-heading">
                <h1>Our Awards And Recognitions</h1>
                <p>Honoring Achievements: Our Recent Awards And Recognitions</p>
            </div>
            <div class="slider">
                <div class="owl-carousel">
                    <div class="slider-card">
                        <img src="../NewContent/front-assets/img/awards-one.png" alt="certificate">
                    </div>
                    <div class="slider-card">
                        <img src="../NewContent/front-assets/img/awards-two.png" alt="certificate">
                    </div>
                    <div class="slider-card">
                        <img src="../NewContent/front-assets/img/awards-three.png" alt="certificate">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Our Awards And Recognitions-end -->
    <!-- map -->
    <section class="map">
        <div class="container">
            <div class="card">
                <div class="card-body">
                    <div class="row g-xl-4 g-md-3 g-3">
                        <div class="col-lg-6">
                            <iframe
                                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3509.4125455030717!2d76.99300607974406!3d28.40680613188903!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d3d454eeaaaab%3A0x1dd4a599f59dbdc9!2sVCQRU%20Private%20Limited!5e0!3m2!1sen!2sin!4v1701198102375!5m2!1sen!2sin"
                                width="100%" height="100%" style="border: 0;" allowfullscreen="" loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                        <div class="col-lg-6">
                            <ul>
                                <li>
                                    <img src="../NewContent/front-assets/img/support-map.svg" alt="Support">
                                </li>
                                <li>
                                    <h3>Cover PAN India Level
                                        <br>
                                        <span>VCQRU</span></h3>
                                </li>
                            </ul>
                            <p>
                                We are providing our tech driven expert services in Pan India. At VCQRU we understand
                                    that each business has specific needs and challenges when it comes to
                                    anti-counterfeiting. That is why we are working closely with our clients to provide
                                    customized solutions which are that are both effective and affordable. Our goal is
                                    to
                                    help you with brand protection while ensuring the safety of your customers.
                            </p>
                            <a href="../contact-us.aspx" class="btn btn-primary px-5">Get Connect With Us</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="../NewContent/front-assets/js/owl.carousel.min.js"></script>
     <script>
         $(document).ready(function () {
             $(".owl-carousel").owlCarousel({
                 loop: true,
                 margin: 10,
                 nav: true,
                 autoplay: true,
                 autoplayTimeout: 3000,
                 autoplayHoverPause: true,
                 center: true,
                 navText: [
                     "<i class='fa fa-angle-left'></i>",
                     "<i class='fa fa-angle-right'></i>"
                 ],
                 responsive: {
                     0: {
                         items: 1
                     },
                     600: {
                         items: 1
                     },
                     1000: {
                         items: 3
                     }
                 }
             });
         });
     </script>
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
</asp:Content>

