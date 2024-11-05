<%@ Page Title="Best digital marketing services | VCQRU " Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="digitalmarketing.aspx.cs" Inherits="digitalmarketing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="We help make your product or company more visible online. Get the best digital marketing service at best price " />
<meta name="keywords" content="digital marketing company, digital marketing services, digital marketing agency, seo service, smo service, ppc services, smm marketing, internet marketing" />

<link rel="canonical" href="https://www.vcqru.com/digital-marketing.aspx" />
<meta property="og:title" content="Best Digital Marketing Company, SEO, SMO, PPC Services in Gurugram, India | VCQRU" />
<meta property="og:type" content="website" />
<meta property="og:url" content="https://www.vcqru.com/digital-marketing.aspx" />
<meta property="og:image" content="https://www.vcqru.com/image/logo-1.png" />
<meta property="og:site_name" content="VCQRU" />
<meta property="og:description" content="Looking for increasing your brand visibility? VCQRU India's best digital marketing company in Gurugram, providing one-stop digital marketing services, seo, smo, ppc at the best price." />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:site" content="@Vcqru_Official" />
<meta name="twitter:title" content="Best Digital Marketing Company, SEO, SMO, PPC Services in Gurugram, India | VCQRU" />
<meta name="twitter:description" content="Looking for increasing your brand visibility? VCQRU India's best digital marketing company in Gurugram, providing one-stop digital marketing services, seo, smo, ppc at the best price." />
<meta name="twitter:image" content="https://www.vcqru.com/image/logo-1.png" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" integrity="sha512-5A8nwdMOWrSz20fDsjczgUidUBR8liPYU+WymTZP1lmY9G6Oc7HlZv156XqnsgNUzTyMefFTcsFH/tnJE/+xBg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="Content/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="/Content/js/toastr.min.js"></script>
    <link href="Content/css/toastr.min.css" rel="stylesheet" />
    <script>
        function sendquerymail(pageTitle) {
            debugger;
            toastr.clear();
            //alert(pageTitle);

            if ($('#cemail').val() == '') {
                toastr.error("Please enter email"); msg = "no"; $('#cemail').focus(); return false
            }
            else {
                var emailid = $('#cemail').val();
                //alert(emailid);
               
                var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                var valid = emailReg.test($('#cemail').val());
                if (!valid) {
                    toastr.error("Please enter the correct email."); return false;
                }
                /*else if (startsWith(emailidsVar, mailExt) != '') {
                    toastr.error("Please enter official email"); msg = "no"; return false
                }*/
                else {
                    //alert('ool');
                    $("#submitbtnMail").hide();
                    $('#lblNameProcess').text('Pleasee be wait, Send data is in process!');
                    // var pageTitle = $('#pageName').val();
                    $('#progress').show();
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=sendqueryMail&email=' + $('#cemail').val() + '&pageName=' + pageTitle,
                        success: function (data) {
                            $('#progress').hide();
                            $('#cemail').val('');
                            toastr.info(data);

                            location.href = "Thanks.aspx";
                        },
                        error: function (data) {
                            toastr.info(data);
                        },
                    });


                }
            }

            $('#progress').hide();
        }

    </script>
    <style>

*{
    margin:0;
    padding:0;
}

.comm0n-para-1
{
    color: #333;
    line-height: 30px;
    /* padding-top: 30px; */
    display: block;
    text-align: justify;
}
/*banner strat*/

    .web-design-bg {
    background-image: url(assets/images/slider/warranty-bg.jpg);
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    padding: 65px 5px;
}

    .fa-arrow-circle-o-right:before {
    content: "\f18e";
}



    .web-design-bg h1 {
    font-size: 78px;
    font-weight: 600;
    color: #0d7aa0;
    text-shadow: 0px 4px 1px #49c9f2;
    margin: 13% 0% 14% 0px;
}

    .web-design-bg a {
    font-size: 18px;
    background-color: #004792;
    color: #fff;
    padding: 10px 40px;
    margin-right: 10px;
    border-radius: 9px;

    margin-right: 30px;
    cursor: pointer;
}

    .web-design-bg a:hover {
    background: #36a2eb;
    color: #ffffff;
}

    button.btn.btn2.section-5-button:hover {
    box-shadow: 10px 6px 0px 1px #0856a9;
    background-color: #5ca2ec;
}

    .web-design-bg span {
    margin-right: 10px;
    cursor: pointer;
}

   .customer_action .features-item {
    border-top: 0px;
    box-shadow: 0px 15px 36px -15px #85b9f1;
    padding: 0px 20px 24px 20px;
    margin-bottom: 35px;
}

   .features-item h4 {
    margin: auto;
    background-color: #0856a9;
    padding: 8px 30px;
    /* border-top-right-radius: 50px; */
    color: #fff;
    box-shadow: 10px 6px 0px 1px #5ca2ec;
    font-weight: 700;
    margin-bottom: 30px;
    text-align: center;
    width: 60%;
}


/*banner end*/


/*content-1-start*/




.card-web-design {
    padding: 10px;
    background: #fff;
    box-shadow: 4px 2px 3px #cbcacc;
    text-align:center;
    border-bottom: 3px solid #82c3f9;
}

.card-web-design:hover {
    background: #82c3f9;
    border-bottom: 2px solid #007bff;
    color: #fff;
}

.card-web-design h4:hover {


    color: #fff;
}

.common-head:after {
    content: '';
    position: absolute;
    bottom: -23px;
    left: 15px;
    height: 3px;
    width: 20%;
    background: #004792;
    transition: .22s ease;
}

h1.common-head {
    font-size: 32px;

}

/*content-1-start*/

/*content-2-strat*/
.section-1-artical img {
    float: right;
    display: inline-block;
    max-width: 50%;

}

/*setion-3-start*/
.section-3-artical img {
    float: left;
    display: inline-block;
    max-width: 50%;
    margin-right: 31px;
}

/*section-3-end*/


/*content-2-end*/
.section-4 {
    background-image: url(assets/images/background/web-img-6.png);
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    /* height: 100vh; */
    /* height: 100%; */


}

.web-design-00 {
    width: 326px;
    float: left;
}

.section-6-artical img {
    float: right;
    display: inline-block;
    max-width: 50%;
    margin-left: 31px;
}

/*content-5-start*/

        .card-1 {
            padding: 20px;
            background: #fff;
            /* border-radius: 96px 3px 96px; */
            border-radius: 8px;
            -webkit-text-stroke: 2px 4px solid greenyellow;
            -webkit-text-stroke-color: 3px 4px saddlebrown;
            box-shadow: -5px 5px 1px #49c9f2;
        }

button.btn.btn2.section-5-button {
   color: #fff;
    background: #007bff;
    box-shadow: 0px 15px 36px -15px #85b9f1;
    margin: auto;
    background-color: #0856a9;
    padding: 8px 30px;
    /* border-top-right-radius: 50px; */
    color: #fff;
    box-shadow: 10px 6px 0px 1px #5ca2ec;
    font-weight: 700;
    margin-bottom: 30px;
    text-align: center;
}

.section-2-track
{
    margin-left: 15px !important;
}


.introsection-1 {
    text-align: center;
    padding-top: 20px;
    padding-bottom: 14px;
    /* margin-left: 31%; */
    background-color: #003a78;
    margin-bottom: 20px;
    width: 80%;
    border-radius: 10px 50px;
    box-shadow: rgb(0 0 0 / 15%) 1.95px 1.95px 2.6px;
    text-align: center;
    margin: auto;
}

        .introsection-1 h5 {
            color: #fff;
            font-weight: 600;
            font-size: 27px;
            text-align: center;
        }

        .btn2 {
    padding: 10px 50px;
    margin-top: 2%;
    margin-bottom: 1%;
    color: #003a78;
    background-color: #fff;
    cursor: pointer !important;
    font-size: 20px;
    box-shadow: 0px 0px 10px #888484;
}
/*content-5-end*/
.timeline{list-style:none;padding:0 0 20px;position:relative;margin-top:-15px}.timeline:before{top:30px;bottom:25px;position:absolute;content:" ";width:3px;background-color:#ccc;left:25px;margin-right:-1.5px}.timeline>li,.timeline>li>.timeline-panel{margin-bottom:17px;position:relative}.timeline>li:after,.timeline>li:before{content:" ";display:table}.timeline>li:after{clear:both}.timeline>li>.timeline-panel{margin-left:62px;float:left;top:19px;padding:4px 10px 8px 15px; border-radius:5px; box-shadow: 0px 0px 4px #82c3f9; background: #fff;}.timeline>li>.timeline-badge{color:#fff;width:50px;height:50px;line-height:36px;font-size:1.2em;text-align:center;position:absolute;top:26px;left:0px;margin-right:-25px;background-color:#fff;z-index:0;border-radius:50%;border:1px solid #d4d4d4}.timeline>li.timeline-inverted>.timeline-panel{float:left}.timeline>li.timeline-inverted>.timeline-panel:before{border-right-width:0;border-left-width:15px;right:-15px;left:auto}.timeline>li.timeline-inverted>.timeline-panel:after{border-right-width:0;border-left-width:14px;right:-14px;left:auto}.timeline-badge.primary{background-color:#2e6da4!important}.timeline-badge.success{background-color:#3f903f!important}.timeline-badge.warning{background-color:#f0ad4e!important}.timeline-badge.danger{background-color:#d9534f!important}.timeline-badge.info{background-color: #ffffff!important; box-shadow: 0px 0px 4px #c7c2c2;}.timeline-title{margin-top:0;color:inherit}.timeline-body>p,.timeline-body>ul{margin-bottom:0;margin-top:0}.timeline-body>p+p{margin-top:5px}.timeline-badge>.glyphicon{margin-right:0;color:#fff}.timeline-body>h4{margin-bottom:0!important}

/*section-10-strat*/
.img-gradient-button {
    background-image: url(~/assets/images/background/trace-6.png);
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    /* height: 330px; */
    border-radius: 8px;
    padding: 30px 15px;
}

.section-10-head
{
    font-size:29px;
    color:#fff;
}

.section-10-head::after {
    content: "";
    display: block;
    width: 150px;
    height: 3px;
    background: #1ba5dd;
    margin-top: 25px;
}

.input-button-2:hover {
    background: #0e538c;
}

.form-control:focus, .form-control:active, .form-control:hover {
    border-color: #d3d8dd;
}

.scubscribe-button-1 {
    padding: 7px 11px;
    background: #fff;
    margin-top: 55px;
    border-radius: 5px;
}

.input-button-1
{
    position:relative;
    padding: 10px 15px;
}

.input-button-2 {
    position: absolute;
    bottom: 42px;
    right: 36px;
    background: #1ba5dd;
    color: #fff;
    border-radius: 5px;
    padding: 7px 25px;
}

.section-01-artical img
{
    float: left;
    display: inline-block;
    max-width: 50%;
    margin-right: 20px;
}

.row.row-1 {
    place-items: center;
}

.button-seo a {
    font-size: 18px;
    background-color: #004792;
    color: #fff;
    padding: 10px 40px;
    margin-right: 10px;
    border-radius: 9px;
    margin-right: 30px;
    cursor: pointer;
}

.button-seo a:hover{background: #36a2eb;
    color: #ffffff;}




/*section-10-end*/

         media screen and (width: 280px) {

             .input-button-2
             {
                 padding: 4px 10px;
                 right: 31px;
             }

             .input-button-1 {


    font-size: 12px;
}
         }

    media screen and (max-width: 767px){
.web-design-bg h1 {
    font-size: 35px;
}

.img-center-1
{
    text-align:center;
}

.web-design-bg {

    background-position: initial;
    background-size: cover;
    padding: 8px;
    display: table;
}

.web-design-bg a {
    font-size: 9px;
    padding: 8px 16px;
    margin-right: 6px;
}

.web-design-bg span {
    margin-right: 5px;
    font-size: 10px;
}

.web-design-bg i {
    font-size: 10px;
}

.card-web-design
{
    margin-bottom:30px;
    padding: 0px 15px
}

.card-web-design h4
{
    font-size:15px;
}

.section-1-artical img
{
    max-width: 100%;
    margin:auto;
    margin-bottom:25px;
    float:none;
}

h1.common-head {
    font-size: 22px;
}

.web-design-00
{
    width:100%;
}

.timeline
{
    margin:0px 15px;
}

.section-6-artical img
{
    max-width: 100%;
}

.input-button-2
{
    bottom: 11px;
}

.scubscribe-button-1
{
    margin-top: 0px;
}

.section-3-artical img
{
    max-width:100%;
}

.section-01-artical img {
    max-width: 100%;
    margin: auto;
    margin-bottom: 0px;
    margin-top:70px;
    float:none;
}

.column-back
{
    flex-direction:column-reverse;
}

.width-center
{
    text-align:center;
}

    }



 media screen and (min-device-width: 768px) and (max-device-width: 992px) {
    .card-web-design {
    margin-bottom: 30px;
}

    .input-button-2
    {
        bottom:59px;
    }

    .scubscribe-button-1
    {
        margin-top:103px;
    }
}

 media screen and (min-device-width: 980px) and (max-device-width: 1120px) {
    .card-web-design {
    margin-bottom: 30px;
}




    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!-- START SLIDER -->
    <header class="web-design-bg">
        <div class="container">

            <div class="row">
                <div class="col-sm-7">
                    <h1>Digital Marketing</h1>
                    <a href="service-contact.aspx?pgnm=Digital Marketing">Schedule a demo</a> <span>Start free trial</span>
                    <i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>
                </div>
                <div class="col-sm-5 ">
                    <div data-wow-delay="0.5s" class="span3 wow rollIn" style="visibility: visible; animation-delay: 0.5s; animation-name: rollIn;">
                        <img src="~/assets/images/slider/Digital-Marketing-1.png" alt="Digital-Marketing-1" class="img-fluid mt-3 img-center-1">
                    </div>
                </div>
            </div>

        </div>
    </header>
    <!-- END SLIDER -->
    <!--Section-2-start-->
    <div class="section-1 mt-lg-5 mt-3">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="common-head">Get ready to boost your business with digital marketing services.</h1>
                </div>

            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="section-1-artical ">
                        <div class="width-center">
                            <img src="~/assets/images/background/Digital-Marketing-2.png" alt="Digital-Marketing" class="img-fluid section-2-track img-center-1">
                        </div>
                        <p class="mt-sm-5 comm0n-para-1">
                            According to the Global Digital Marketing Market Report, the
                            global digital marketing market is aided by the increasing number of internet users and
                            the growing adoption of intelligent devices. The market is projected to grow at a CAGR
                            of around 9.1% between 2022-27. Digital marketing also referred to as internet marketing
                            and online marketing, is a popular activity by brands and businesses to build their online
                            presence. Digital marketing means promoting your brand or business via digital platforms.
                            The digital channels include social media, search engines, email, content marketing, and many more.
                        </p>




                    </div>

                </div>

            </div>


        </div>

    </div>
    <!--Section-2-end-->
    <div class="section-1 mt-lg-5 mt-3">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="common-head">The power of Digital Marketing</h1>
                </div>

            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="section-01-artical width-center">

                        <img src="~/assets/images/background/Digital-Marketing-3.png" alt="Digital-Marketing-3" class="img-fluid section-2-track img-center-1">
                        <p class="mt-5 comm0n-para-1">
                            Almost everyone has come across zomato's slaying and catchy ads on the zomato app on their smartphones.
                            The constant reminder about food cravings and making its audience hungry is the ultimate motive of zomato. The popularity of
                            zomato has increased since they picked up on this killer strategy. Clever ads and posts on social media have taken over
                            the advertisement industry. Their presence on LinkedIn, Instagram, Twitter, and Facebook is insane and started a hurricane
                            of appreciation and fondness. Zomato's target audience is between the age group of 18-35 years. The targeted people either
                            get food delivered to homes or offices or like dining out. Zomato is rated as the best platform to search for restaurants.
                        </p>

                        <p class="comm0n-para-1">
                            Zomato used social media platforms to post relatable and mouth-watering
                            posts on social media pages, thus, increasing the brand's popularity all over the country.
                            Zomato used trendy topics to engage its audience by creating relatable posts with interactive
                            catchy tag lines encouraging people to comment and share their thoughts. Zomato has put a lot
                            of effort into SEO. As per Ubersuggest data, ranks in India for 816,952 keywords as on July
                            2019. Its organic traffic is 6,719,882 users per month. Zomato takes the top keywords and
                            creates webpage URLs for them. This activity informs the search engine that the pages made
                            are relevant to the user's search query. This strategy is excellent for ensuring that your website ranks.
                        </p>




                    </div>

                </div>

            </div>


        </div>

    </div>
    <!--Section-3-strat-->
    <!--Section-3-strat-->

    <div class="section-10 mt-lg-5 mt-3">
        <div class="container">

            <div class="row">
                <div class="col-md-12">
                    <div class="img-gradient-button">
                        <div class="row">
                            <div class="col-md-6">
                                <h1 class="section-10-head">Digital marketing Services </h1> <p class="comm0n-para-1 text-white" style="font-weight:400;">
                                    We simplify Digital marketing Services
                                    for businesses and make the experience  delightful for end users
                                </p>
                            </div>
                            <div class="col-md-6">
                                <div class="scubscribe-button-1">
                                    <input type="email" class="form-control input-button-1" id="cemail" maxlength="30" placeholder="Enter Your Email" aria-describedby="emailHelp" title="Please enter mail id">
                                    <button class="input-button-2" id="submitbtnMail" type="button" onclick="sendquerymail('Digital Marketing');">Get Start</button>

                                </div>
                                <label id="lblNameProcess" class="text-danger"></label>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!--Section-5-strat-->
    <!--Section-5-end-->

    <section class="customer_action pt-5 ">
        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="common-head">Why should you choose VCQRU's digital marketing services? </h1>
                </div>

            </div>
            <div class="row">
                <div class="col-lg-12">
                    <p class="mt-5 comm0n-para-1">
                        VCQRU is one of the leading digital marketing solutions providers across PAN India.
                        We provide our clients with individualized, expert Digital solutions that drive ROI. Our team brings a rich
                        and diverse background in internet marketing, SEO Services, SMO services, PPC services, and SMM marketing.
                        Our unique approach allows us to deliver exceptional quality of service. With our collective experience,
                        we are always at the helm of affairs, providing unmatched value to our clients, irrespective of the industry
                        sector. We are currently serving Luxe India Tours &Travels, VR Kabel, and Welco Garment & machinery.
                    </p>
                </div>
            </div>

        </div>

    </section>
    <div class="section-1 mt-lg-5 mt-3">
        <div class="container">


            <div class="row row-1 column-back">



                <div class="col-sm-6">
                    <h3 class="">seo</h3>
                    <p class="mt-3 comm0n-para-1">
                        As a professional SEO company in India, we aim to deliver
                        transformational growth to our client's businesses. If you're serious about your
                        business growth and branding, you're at the right place.
                    </p>
                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Seo">Seo</a></div>
                </div>
                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-2.png" alt="Digital-Marketing" class="img-fluid section-2-track float-lg-right img-center-1">
                </div>


            </div>
            <hr />

            <div class="row row-1 ">


                <div class="col-sm-6 width-center ">

                    <img src="~/assets/images/background/Digital-Marketing-5.png" alt="Digital-Marketing" class="img-fluid section-2-track img-center-1 ">
                </div>

                <div class="col-sm-6">
                    <h3 class="">SMO</h3>
                    <p class="mt-3 comm0n-para-1">
                        Are you looking for quality SMO service to boost your brand and business?
                        You are at the right place. At VCQRU, we provide the best SMO services to promote your business all across the globe.
                    </p>

                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Smo">Smo</a></div>
                </div>


            </div>
            <hr />
            <div class="row row-1 column-back">




                <div class="col-sm-6 mt-3">
                    <h3 class="">PPC</h3>
                    <p class="mt-3 comm0n-para-1">
                        Get ready for excellent traffic, leads, and sales at a lower cost in the business. With the most efficient and
                        effective Pay Per Click services, we deliver a better Return on Spending than you can imagine!
                    </p>

                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Ppc">Ppc</a></div>
                </div>

                <div class="col-sm-6 m-auto width-center">

                    <img src="~/assets/images/background/Digital-Marketing-6.png" alt="Digital-Marketing" class="img-fluid section-2-track float-lg-right img-center-1">
                </div>


            </div>
            <hr />

            <div class="row row-1">

                <div class="col-sm-12 mb-5">
                    <h1 class="common-head">Digital marketing Services</h1>
                </div>

                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-7.png" alt="Digital-Marketing-7" class="img-fluid section-2-track img-center-1 ">
                </div>

                <div class="col-sm-6">
                    <h3 class="">Search Engine Marketing</h3>
                    <p class="mt-3 comm0n-para-1">
                        Our Search Engine Marketing (SEM) solutions help accelerate your business
                        growth with an excellent online reputation. We are versed and refined at uplifting all kinds of businesses in the market.
                    </p>
                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Sem">Sem</a></div>
                </div>


            </div>

            <hr />

            <div class="row row-1 column-back">




                <div class="col-sm-6 mt-3">
                    <h3 class="">Social Media Marketing (SMM)</h3>
                    <p class="mt-3 comm0n-para-1">
                        As a professional, experienced, and reputable Social Media Marketing
                        company in Gurugram, VCQRU believes in identifying new audiences and creating engagement opportunities
                        between the customer and your brand. Our experts are determined to boost your brand by posting regularly
                        on your social media platforms to improve networking and engagement.
                        <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Smm">Smm</a></div>
                    </p>
                </div>

                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-8.png" alt="Digital-Marketing-8" class="img-fluid section-2-track float-lg-right img-center-1">
                </div>


            </div>

            <hr />

            <div class="row row-1">



                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-9.png" alt="Digital-Marketing-9" class="img-fluid section-2-track img-center-1">
                </div>

                <div class="col-sm-6">
                    <h3 class="">Content Marketing</h3>
                    <p class="mt-3 comm0n-para-1">
                        With years of experience in content marketing, we provide
                        services that include content strategy development, research, creation, editing,
                        and publishing. We have a skilled content marketing team that gives an excellent
                        blend of informational, promotional, and engaging content.

                    </p>
                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Content-Marketing">Content Marketing</a></div>
                </div>


            </div>

            <hr />

            <div class="row row-1 column-back">




                <div class="col-sm-6 mt-3">
                    <h3 class="">Email Marketing</h3>
                    <p class="mt-3 comm0n-para-1">
                        Are you looking for a cost-effective Email marketing service to grow
                        your business? At VCQRU, we provide a whole suite of email marketing services to all kinds of
                        industries in India and around the globe. We use advanced techniques and strategies to email
                        marketing campaigns successfully.

                    </p>
                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Email-Marketing">Email Marketing</a></div>
                </div>

                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-10.png" alt="Digital-Marketing-8" class="img-fluid section-2-track float-lg-right img-center-1">
                </div>


            </div>

            <hr />


            <div class="row row-1">



                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-11.png" alt="Digital-Marketing-9" class="img-fluid section-2-track img-center-1 ">
                </div>

                <div class="col-sm-6">
                    <h3 class="">Website Design</h3>
                    <p class="mt-3 comm0n-para-1">
                        VCQRU is a leading website design and development company in Gurugram,
                        India. We have an experienced team who works closely with clients to develop a website per their business requirements.


                    </p>
                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Website-Design">Website Design</a></div>
                </div>


            </div>

            <hr />

            <div class="row row-1 column-back">




                <div class="col-sm-6 mt-3">
                    <h3 class="">Affiliate Marketing</h3>
                    <p class="mt-3 comm0n-para-1">
                        If you want to enhance your brand reputation, visibility,
                        and traffic to your website through affiliate marketing, then you have reached the
                        right place. VCQRU is one of the leading service provider companies in affiliate marketing.


                    </p>

                    <div class="button-seo"> <a href="service-contact.aspx?pgnm=Digital Marketing-Affiliate-Marketing">Affiliate Marketing</a></div>

                </div>

                <div class="col-sm-6 width-center">

                    <img src="~/assets/images/background/Digital-Marketing-12.png" alt="Digital-Marketing-8" class="img-fluid section-2-track float-lg-right img-center-1">
                </div>


            </div>




        </div>

    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <p class="mt-3 comm0n-para-1">
                    So it is well, in time, we are informing you about the digital
                    marketing services provided by VCQRU, which can boost your brand and create your brand's identity on digital platforms.


                </p>

            </div>
        </div>
    </div>
    <section class="fmcg-section8 common">
        <div class="container">
            <div class="row introsection-1 mt-lg-5 mt-3">
                <div class="col-md-12">
                    <h5>Want to know how VCQRU’s solution can help <br>boost your profit?</h5>

                    <a href="service-contact.aspx?pgnm=Digital Marketing"><button type="button" class="btn  btn2">Click Here</button></a>
                </div>
            </div>

        </div>


    </section>
</asp:Content>

