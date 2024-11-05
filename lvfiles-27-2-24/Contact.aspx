<%@ Page Title="Contact Us | VCQRU" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
    body.scroll-lock {
        overflow-y: scroll;
    }
    .card-body{
        background:none !important ;
        border:none !important;
        outline:none !important;

    }
    .anchorTag{
        text-decoration:none !important;
        cursor:pointer;
        color:#fff;
    }
    .iconColor{
        color:#fff;
    }

    .body-container-wrapper {
        border-top: 101px solid rgb(243, 245, 249) !important;
    }

    /* .card .column__inner {
        padding: 30px 27px 35px;
    }*/

    input.form-control.mb-3 {
        border: 1px solid #c1bfbf;
        background: #fff;
    }

    .modal-content {
        background: #f3f5f9;
    }

    #myModal-2 {
        padding: 0px;
    }

    #myModal {
        padding: 0px;
    }

    @media only screen and (width: 280px) {
        .contact-links__link {
            padding: 14px 17px;
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <main class="body-container-wrapper">
    <div class="flex-top-full">
        <span id="hs_cos_wrapper_flex-top-full" class="hs_cos_wrapper hs_cos_wrapper_widget_container hs_cos_wrapper_type_widget_container" style="" data-hs-cos-general-type="widget_container" data-hs-cos-type="widget_container">
            <div id="hs_cos_wrapper_widget_1618326431216" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">



                <div class="nested-layout module  module--padding-large  module--on-dark  module--bg-white">



                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-50 module__background-inner--alignment-top full-width  module--bg-dark">
                            <div class="module__underlay">



                            </div>


                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">


                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                            <div class="module__section-header-inner constrain--6">
                                <h1>Contact us</h1>
                                <p>If you have any questions or concerns, please do not hesitate to contact us. Our team is always available to assist you in any way we can</p>
                            
                                 <h5>For sales related enquiries you may call our Business Development team on :</h5>
                                 <a href="tel:9355903102" class="anchorTag"><%--<i class="fa fa-phone iconColor" aria-hidden="true" style="transform: rotate(90deg)"></i>--%>+919355903102,</a>,
                                 <a href="tel:9355903103" class="anchorTag"><%--<i class="fa fa-phone iconColor" aria-hidden="true" style="transform: rotate(90deg)"></i>--%>+919355903103,</a> 
                                 <a href="tel:9355903104" class="anchorTag"><%--<i class="fa fa-phone iconColor" aria-hidden="true" style="transform: rotate(90deg)"></i>--%>+919355903104,</a> 
                                 <a href="tel:9355903105" class="anchorTag"><%--<i class="fa fa-phone iconColor" aria-hidden="true" style="transform: rotate(90deg)"></i>--%>+919355903105,</a>
                                 <a href="tel:9355903107" class="anchorTag"><%--<i class="fa fa-phone iconColor" aria-hidden="true" style="transform: rotate(90deg)"></i>--%>+919355903107</a>
                            
                            
                            </div>

                        </div>




                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--two-col nested-layout__grid--card--white nested-layout__grid--desktop-card">


                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/request-for-proposal.png" alt="writing icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Request for proposal</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>RFP - If you're interested in our services and would like to receive a Request for Proposal (RFP), please send us your details and we'll respond to your request as soon as possible.</p>


                                                        <div class="column__content-modal-container">


                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal">
                                                                Submit RFP
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/career-promotion.png" alt="mail">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Career opportunities</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>Career Opportunity - Are you interested in learning more about our company culture or career opportunities? Our HR and recruitment teams would be more than happy to speak with you. </span></p>


                                                        <div class="column__content-modal-container">
                                                            
                                                            <div class="column__content-modal-container">
                                                                <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                    Contact Us
                                                                </a>
                                                            </div>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/reporter.png" alt="Bell icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>For media and press</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>Press And Media - If you're a member of the media or have a PR opportunity and need to speak with someone on our team, please reach out to us here</span></p>


                                                        <div class="column__content-modal-container">
                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                Contact Us
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/handshake.png" alt="group icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>For partnership opportunities</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>For partnership opportunities - Are you interested in partnering with us? We're always looking for innovative companies to join our Partner Program</span></p>


                                                        <div class="column__content-modal-container">
                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                Contact Us
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                </div>



                                <div class="nested-layout__grid nested-layout__grid--mobile nested-layout__grid--two-col nested-layout__grid--card--white nested-layout__grid--mobile-stacked">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/request-for-proposal.png" alt="writing icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Request for proposal</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>RFP - If you're interested in our services and would like to receive a Request for Proposal (RFP), please send us your details and we'll respond to your request as soon as possible.</p>


                                                        <div class="column__content-modal-container">


                                                           

                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal">
                                                                Submit RFP
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/career-promotion.png" alt="mail">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Career opportunities</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>Career Opportunity - Are you interested in learning more about our company culture or career opportunities? Our HR and recruitment teams would be more than happy to speak with you. </span></p>


                                                        <div class="column__content-modal-container">
                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                Contact Us
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/reporter.png" alt="Bell icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>For media and press</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>Press And Media - If you're a member of the media or have a PR opportunity and need to speak with someone on our team, please reach out to us here</span></p>


                                                        <div class="column__content-modal-container">
                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                Contact Us
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card card card--white">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/handshake.png" alt="group icon">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>For partnership opportunities</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p><span>For partnership opportunities - Are you interested in partnering with us? We're always looking for innovative companies to join our Partner Program</span></p>


                                                        <div class="column__content-modal-container">
                                                            <a class="cta-btn cta-btn--medium cta-btn--stroke modal-trigger data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                                                Contect Us
                                                            </a>
                                                        </div>

                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                </div>




                            </div>
                        </div>


                    </div>
                </div>





               <div class="container mb-5">
                                <div class="card">
                                    <div class="card-body w-100 h-100">
                                        <div class="module__section-header-inner constrain--10 mb-4">
                                            <h2>Get in touch</h2>
                                            <p class="mb-0">For any queries feel free to contact us and our expert
                                                support team will get back to you as soon as
                                                possible!</p>
                                        </div>
                                        <div class="row">
                                            <div class="col-xxl-3 col-xl-3 col-lg-3 col-md-3 mb-3">
                                                <div class="contact-links__section p-0 w-100 d-block">
                                                    <h3 class="h4 mb-1">Write to us</h3>
                                                    <a class="contact-links__link p-0 bg-white border-0 w-100 mb-0"
                                                        href="mailto:sales@vcqru.com">
                                                        <img class="contact-links__link-icon"
                                                            src="mailto:sales@vcqru.com" alt="">
                                                        <i class="fa fa-envelope" aria-hidden="true"></i>
                                                        sales@vcqru.com
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-xxl-3 col-xl-3 col-lg-3 col-md-3 mb-3">
                                                <div class="contact-links__section p-0 w-100 d-block">
                                                    <h3 class="h4 mb-1">Talk to us</h3>
                                                    <a class="contact-links__link p-0 bg-white border-0 w-100 mb-0"
                                                        href="tel:+911245181074">
                                                        <img class="contact-links__link-icon"
                                                            src="" alt="">
                                                        <i class="fa fa-phone" style="transform: rotate(90deg)" aria-hidden="true"></i>
                                                        +91 124 5181074
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-xxl-6 col-xl-6 col-lg-6 col-md-6 mb-3">
                                                <div class="contact-links__section w-100 p-0 d-block">
                                                    <h3 class="h4 mb-1">Our Corporate Office</h3>
                                                    <a class="contact-links__link p-0 border-0 bg-white w-100 mb-0">
                                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                        <b>VCQRU PRIVATE LIMITED</b><br />
                                                        Unit: 1502-3, 15th Floor, Tower-4,
                                                        DLF Corporate Greens, Sector-74A,
                                                        Gurgaon, Haryana - 122004.
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <h3 class="h4 my-3">Other Offices</h3>
                                <div class="row g-4">
                                    <div class="col-lg-6 d-flex">
                                        <div class="card w-100">
                                            <div class="card-body h-100 w-100">
                                                <div class="contact-links__section w-100 p-0 d-block">
                                                    <a class="contact-links__link p-0 border-0 bg-white w-100 mb-0">
                                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                        <b>West Bengal</b><br />
                                                        Unit 806, Tower 2 Godrej Waterside,
                                                        Plot DP 5, Sector V, Bidhannagar, Kolkata, West Bengal
                                                        700091
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 d-flex">
                                        <div class="card w-100">
                                            <div class="card-body w-100 h-100">
                                                <div class="contact-links__section w-100 p-0 d-block">
                                                    <a class="contact-links__link p-0 border-0 bg-white w-100 mb-0">
                                                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                                                        <b>Telangana</b><br />
                                                        Insta Office Coworking, Gachibowli
                                                        Survey No. 55, Plot No. 108, NYN Arcade, 3rd Floor Lumbini
                                                        Society,
                                                        Off, Hitech City Main Rd, Gachibowli, Telangana 500032
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                <div id="widget_1618326431216__modal-1" class="modal modal--form module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__form">
                                    <span id="hs_cos_wrapper_widget_1618326431216_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                        <h3 id="hs_cos_wrapper_form_335983086_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text">Submit RFP</h3>

                                        <div id="hs_form_target_form_335983086"></div>

                                    </span>
                                </div>


                                <div class="modal__spacer"></div>
                            </div>
                        </div>
                        <button class="modal__close" title="Close modal">
                            <svg xmlns="http://www.w3.org/2000/svg" width="23.363" height="23.357" viewbox="0 0 23.363 23.357">
                                <g transform="translate(0 -0.07)">
                                    <path d="M19.947,3.486a11.678,11.678,0,1,0,0,16.524A11.7,11.7,0,0,0,19.947,3.486ZM18.667,18.73a9.874,9.874,0,1,1,0-13.964A9.886,9.886,0,0,1,18.667,18.73Z"></path>
                                    <path d="M175.189,171.476l-2.562-2.559,2.562-2.559a.905.905,0,1,0-1.28-1.281l-2.564,2.56-2.564-2.56a.905.905,0,1,0-1.28,1.281l2.562,2.559-2.562,2.559a.905.905,0,0,0,1.28,1.281l2.564-2.56,2.564,2.56a.905.905,0,1,0,1.28-1.281Z" transform="translate(-159.605 -157.226)"></path>
                                </g>
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="widget_1618326431216__modal-2" class="modal modal--form module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__form">
                                    <span id="hs_cos_wrapper_widget_1618326431216_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                        <h3 id="hs_cos_wrapper_form_122132263-1682874912417_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text">Careers</h3>

                                        <div id="hs_form_target_form_122132263-1682874912417"></div>


                                    </span>
                                </div>


                                <div class="modal__spacer"></div>
                            </div>
                        </div>
                        <button class="modal__close" title="Close modal">
                            <svg xmlns="http://www.w3.org/2000/svg" width="23.363" height="23.357" viewbox="0 0 23.363 23.357">
                                <g transform="translate(0 -0.07)">
                                    <path d="M19.947,3.486a11.678,11.678,0,1,0,0,16.524A11.7,11.7,0,0,0,19.947,3.486ZM18.667,18.73a9.874,9.874,0,1,1,0-13.964A9.886,9.886,0,0,1,18.667,18.73Z"></path>
                                    <path d="M175.189,171.476l-2.562-2.559,2.562-2.559a.905.905,0,1,0-1.28-1.281l-2.564,2.56-2.564-2.56a.905.905,0,1,0-1.28,1.281l2.562,2.559-2.562,2.559a.905.905,0,0,0,1.28,1.281l2.564-2.56,2.564,2.56a.905.905,0,1,0,1.28-1.281Z" transform="translate(-159.605 -157.226)"></path>
                                </g>
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="widget_1618326431216__modal-3" class="modal modal--form module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__form">
                                    <span id="hs_cos_wrapper_widget_1618326431216_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                        <h3 id="hs_cos_wrapper_form_908024147-1682874912419_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text">Media and press</h3>

                                        <div id="hs_form_target_form_908024147-1682874912419"></div>

                                    </span>
                                </div>


                                <div class="modal__spacer"></div>
                            </div>
                        </div>
                        <button class="modal__close" title="Close modal">
                            <svg xmlns="http://www.w3.org/2000/svg" width="23.363" height="23.357" viewbox="0 0 23.363 23.357">
                                <g transform="translate(0 -0.07)">
                                    <path d="M19.947,3.486a11.678,11.678,0,1,0,0,16.524A11.7,11.7,0,0,0,19.947,3.486ZM18.667,18.73a9.874,9.874,0,1,1,0-13.964A9.886,9.886,0,0,1,18.667,18.73Z"></path>
                                    <path d="M175.189,171.476l-2.562-2.559,2.562-2.559a.905.905,0,1,0-1.28-1.281l-2.564,2.56-2.564-2.56a.905.905,0,1,0-1.28,1.281l2.562,2.559-2.562,2.559a.905.905,0,0,0,1.28,1.281l2.564-2.56,2.564,2.56a.905.905,0,1,0,1.28-1.281Z" transform="translate(-159.605 -157.226)"></path>
                                </g>
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="widget_1618326431216__modal-4" class="modal modal--form module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__form">
                                    <span id="hs_cos_wrapper_widget_1618326431216_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                        <h3 id="hs_cos_wrapper_form_956725909-1682874912421_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text">Partnership opportunities</h3>

                                        <div id="hs_form_target_form_956725909-1682874912421"></div>

                                    </span>
                                </div>


                                <div class="modal__spacer"></div>
                            </div>
                        </div>
                        <button class="modal__close" title="Close modal">
                            <svg xmlns="http://www.w3.org/2000/svg" width="23.363" height="23.357" viewbox="0 0 23.363 23.357">
                                <g transform="translate(0 -0.07)">
                                    <path d="M19.947,3.486a11.678,11.678,0,1,0,0,16.524A11.7,11.7,0,0,0,19.947,3.486ZM18.667,18.73a9.874,9.874,0,1,1,0-13.964A9.886,9.886,0,0,1,18.667,18.73Z"></path>
                                    <path d="M175.189,171.476l-2.562-2.559,2.562-2.559a.905.905,0,1,0-1.28-1.281l-2.564,2.56-2.564-2.56a.905.905,0,1,0-1.28,1.281l2.562,2.559-2.562,2.559a.905.905,0,0,0,1.28,1.281l2.564-2.56,2.564,2.56a.905.905,0,1,0,1.28-1.281Z" transform="translate(-159.605 -157.226)"></path>
                                </g>
                            </svg>
                        </button>
                    </div>
                </div>

            </div>
            <div id="hs_cos_wrapper_widget_1619235986669" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">



            </div>
    </div>


    
</main>

<div class="modal" id="myModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content ">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Contact VCQRU</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div class="two-column__form">
                    <div class="two-column__form-content">



                    </div>
                    <div class="two-column__form-inner">
                        <span id="hs_cos_wrapper_widget_1617729660512_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                            <h3 id="hs_cos_wrapper_form_977481405_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>

                            <div id="hs_form_target_form_977481405">


                                <form class="services_form">
                                    <div id="div_cont">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Frist Name</label>
                                                    <input type="text" id="fname_cont" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Last Name</label>
                                                    <input type="text" id="lname_cont" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Company name*</label>
                                                    <input type="text" id="comp_cont" class="form-control mb-3" aria-describedby="textHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Email*</label>
                                                    <input type="email" id="email_cont" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Phone*</label>
                                                    <input type="text" id="phone_cont" class="form-control mb-3" aria-describedby="phoneHelp">

                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Additional information</label>
                                                    <input type="text" id="addi_cont" class="form-control mb-3" aria-describedby="textHelp">

                                                </div>
                                            </div>
                                            <label id="lbl_cont"></label>
                                            <div class="col-lg-12">
                                                <div class="form-check my-3">
                                                    <input type="checkbox" class="form-check-input" id="check_cont">
                                                    <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx"> Privacy Policy</a> on how your information may be used*</label>
                                                </div>


                                                <button type="submit" id="btn_cont" class="btn btn-primary">Submit</button>
                                            </div>

                                        </div>
                                    </div>
                                    <div id="div_success" style="display:none">
                                        <div class="text-center">
                                            <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                            <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thank you for your interest!</h2>
                                            <p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>


                                        </div>
                                    </div>
                                </form>
                            </div>

                        </span>
                    </div>
                </div>
            </div>

            <!-- Modal footer -->
           

        </div>
    </div>
</div>



<div class="modal" id="myModal-2">
    <div class="modal-dialog modal-lg">
        <div class="modal-content ">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Contact VCQRU</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div class="two-column__form">
                    <div class="two-column__form-content">



                    </div>
                    <div class="two-column__form-inner">
                        <span id="hs_cos_wrapper_widget_1617729660512_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                            <h3 id="hs_cos_wrapper_form_977481405_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>

                            <div id="hs_form_target_form_977481405">


                                <form class="services_form">
                                    <div id="div_cont2">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Frist Name</label>
                                                    <input type="text" id="fname_cont2" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Last Name</label>
                                                    <input type="text" id="lname_cont-2" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>



                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Email*</label>
                                                    <input type="email" id="email_cont2" class="form-control mb-3" aria-describedby="emailHelp">

                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label for="exampleInputname">Phone*</label>
                                                    <input type="text" id="phone_cont2" class="form-control mb-3" aria-describedby="phoneHelp">

                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <div class="form-group">
                                                    <label for="exampleInputname">How can we help?*</label>
                                                    <input type="text" id="addi_cont2" class="form-control mb-3" aria-describedby="textHelp">

                                                </div>
                                            </div>
                                            <label id="lbl_cont2"></label>
                                            <div class="col-lg-12">
                                                <div class="form-check my-3">
                                                    <input type="checkbox" class="form-check-input" id="check_cont2">
                                                    <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx"> Privacy Policy</a> on how your information may be used*</label>
                                                </div>
                                                <button type="submit" id="btn_cont2" class="btn btn-primary">Submit</button>
                                            </div>

                                        </div>
                                    </div>
                                    <div id="div_success2" style="display:none">
                                        <div class="text-center">
                                            <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                            <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thank you for your interest!</h2>
                                            <p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>


                                        </div>
                                    </div>
                                </form>
                            </div>

                        </span>
                    </div>
                </div>
            </div>

            <!-- Modal footer -->
            


        </div>
    </div>
</div>
</asp:Content>

