<%@ Page Title="News Event | VCQRU" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="news-event.aspx.cs" Inherits="News_event" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="services-details-header">
        <div class="container">
            <!-- breadcrumb -->
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="../Default.aspx">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">News Event</li>
                    </ol>
                </nav>
            </div>
            <!-- end -->
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-4">
                <div class="col order-lg-1 order-2">
                    <h1>VCQRU's News & Events</h1>
                    <p>Stay updated with our latest company news and events, where innovation meets success!</p>
                    <a href="../contact-us.aspx" class="btn btn-primary">Connect with us</a>
                </div>
                <div class="col order-lg-2 order-1 text-lg-end text-center">
                    <img src="../NewContent/front-assets/img/kolkata-event.png" alt="VCQRU's News & Events" class="img-fluid">
                </div>
            </div>
        </div>
    </section>
    <!-- header-end -->
    <!-- event -->
    <section class="news-events">
        <div class="container">
            <div class="web-heading">
                <h1>Our Past Events</h1>
            </div>
            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-2 row-cols-md-1 row-cols-1 g-4">
                <div class="col d-flex">
                    <div class="card">
                        <img src="../NewContent/front-assets/img/news-events/web-banner11.jpg" alt="Event Post" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">VCQRU PARTICIPATING IN IPLCM EXPO 2024</h5>
                            <ul class="events-date">
                                <li>
                                    <img src="../NewContent/front-assets/img/career/location.svg" alt="location">
                                    Booth No : E-11
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/career/date-icon.svg" alt="location">
                                    <span class="badge">08</span>
                                    <span class="badge">09</span>
                                    <span class="badge">10</span>
                                    February 2024
                                </li>
                            </ul>
                            <p class="card-text">Bombay Exhibition Centre, Mumbai, India</p>
                            <p class="card-text">
                                Become part of the leading B2B event "International Private Label And Contract
                                Manufacturing Expo 2024" with us at our Booth No : E-11 in Mumbai. More than 100 top
                                global brands of private-label products are readily available in this expo, which
                                focuses solely on Private Labels, White Labels, and Contract Manufacturing.
                            </p>
                            <a href="../event/iplcm-event.aspx?eventname=IPLCM-EXPO"
                                class="btn btn-outline-primary btn-sm px-3">View More <i
                                    class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <img src="../NewContent/front-assets/img/news-events/cosmotech-event.jpg" alt="Cosmotech-event"
                            class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">VCQRU PARTICIPATING IN COSMOTECH EXPO</h5>
                            <ul class="events-date">
                                <li>
                                    <img src="../NewContent/front-assets/img/career/location.svg" alt="location">
                                    Hall No. 5, Stall No. B26
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/career/date-icon.svg" alt="location">
                                    <span class="badge">19</span>
                                    <span class="badge">20</span>
                                    <span class="badge">21</span>
                                    July 2023
                                </li>
                            </ul>
                            <p class="card-text">Pragati Maidan, New Delhi</p>
                            <p class="card-text">
                                Cosmohome Tech brings together 350+ Exhibitors to display the latest Ingredients,
                                Formulations,
                                Fragrances, Packaging, Machinery, Labelling, and Contract Manufacturing.

                            </p>
                            <p class="card-text">VCQRU will present its smart Packaging, Smart labeling, and Anti
                                Coterfitie Solutions.</p>
                            <a href="../event/cosmotech-event.aspx?eventname=COSMOTECH-EXPO"
                                class="btn btn-outline-primary btn-sm px-3">View More
                                <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col d-flex">
                    <div class="card">
                        <img src="../NewContent/front-assets/img/news-events/packplus-event.jpg" alt="packplus-event"
                            class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">VCQRU PARTICIPATING IN Packplus Event</h5>
                            <ul class="events-date">
                                <li>
                                    <img src="../NewContent/front-assets/img/career/location.svg" alt="location">
                                    Booth No : Hall No.9 Stall No. A35
                                </li>
                                <li>
                                    <img src="../NewContent/front-assets/img/career/date-icon.svg" alt="location">
                                    <span class="badge">10</span>
                                    <span class="badge">11</span>
                                    <span class="badge">12</span>
                                    August 2023
                                </li>
                            </ul>
                            <p class="card-text">Pragati Maidan, New Delhi</p>
                            <p class="card-text">
                                Packplus brings together 350+ Exhibitors to display the latest Ingredients,
                                Formulations, Fragrances, Packaging, Machinery, Labelling, and Contract Manufacturing.
                            </p>
                            <p class="card-text">VCQRU will present its smart Packaging, Smart labeling, and Anti
                                Coterfitie Solutions.</p>
                            <a href="../event/packplus-event.aspx?eventname=Packplus-EXPO"
                                class="btn btn-outline-primary btn-sm px-3">View More <i
                                    class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!---->
    <section class="industries" style="background: var(--bs-light) !important;">
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
</asp:Content>

