<%@ Page Title="Anti-Counterfeit Solutions, Custom QR Code Generator, Smart Packaging Company | VCQRU" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="HomePageNew.aspx.cs" Inherits="HomePageNew" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<meta name="description" content="VCQRU is a leading anti-counterfeiting solutions company in India, offering one-stop solutions for anti-counterfeiting, custom QR code, smart packaging, labels stickers, and e-warranty solutions with dynamic QR code." />
<meta name="keywords" content="dynamic qr code, qr code manufacturer, brand protection, anti-counterfeit solutions, customer loyalty programs, qr code provider, qr code provider in india, customized solution, label provider in india, anti-counterfeit solution company, anti-counterfeit technologies, anti-counterfeiting solutions in india, industrial tags manufacturer, e-warranty, data analysis, cash transfer, customer loyalty service, track & trace services, raffle, run survey, build loyalty, digital marketing, software development, digital marketing services, qr code maker, qr code generator, qr code manufacturer, qr code generator with logo, qr code generator online, custom qr code generator, custom packaging for small business, smart packaging systems, smart packaging solutions" />
<link rel="canonical" href="https://www.vcqru.com/" />
<meta property="og:title" content="Anti-Counterfeit Solutions, Custom QR Code Generator, Smart Packaging Company | VCQRU" />
<meta property="og:type" content="website" />
<meta property="og:url" content="https://www.vcqru.com/" />
<meta property="og:image" content="https://www.vcqru.com/NewContent/img-home/logo.png" />
<meta property="og:site_name" content="VCQRU" />
<meta property="og:description" content="VCQRU is a leading anti-counterfeiting solutions company in India, offering one-stop solutions for anti-counterfeiting, custom QR code, smart packaging, labels stickers, and e-warranty solutions with dynamic QR code." />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:site" content="@Vcqru_Official" />
<meta name="twitter:title" content="Anti-Counterfeit Solutions, Custom QR Code Generator, Smart Packaging Company | VCQRU" />
<meta name="twitter:description" content="VCQRU is a leading anti-counterfeiting solutions company in India, offering one-stop solutions for anti-counterfeiting, custom QR code, smart packaging, labels stickers, and e-warranty solutions with dynamic QR code." />
<meta name="twitter:image" content="https://www.vcqru.com/NewContent/img-home/logo.png" />
<meta name="google-site-verification" content="KIoiLaFt2yT8E3UYsjCd5-o98FMsgrjGK7BXFLU2KO0" />


    <style>

.nested-layout__navigation button {
        display: block;
             margin:0px 10px;
    }

        .nikoltnutrition-bg {
            background-image: url(../img/Background.jpg);
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            /* height:100vh; */
        }
	@media only screen and (max-width: 767px) {

		#wlink {
	    		padding: 0 20px;
		}
	.nikolt-box {
    		margin: auto;
    		width: 100%;
	}
	.nikoltnutrition-bg h5 {
    		padding: 0px 30px 0px 30px;
    		font-size: 18px;
	}
	  }

        .nikoltlogo {
            /* margin: auto; */
            width: 30%;
        }
	.nikolt-box{
	position: absolute;
 	 top: 50%;
 	 left: 50%;
 	 transform: translate(-50%, -50%)!important;
 	 padding: 10px;

	}

        #wlink {
            color: #fff;
	   padding: 20px;
        }

            #wlink a {
                text-decoration: none;
                color: #fff;
            }

        .modal {
            --bs-modal-header-border-color: #dee2e600 !important;
            --bs-modal-footer-border-color: #dee2e600 !important;
        }

        .nikoltnutrition-bg h5 {
            font-weight: 500;
            padding: 0px 30px 30px 30px;
            font-size: 28px;
        }

        .nikoltnutrition-bg h1 {
            color: #0d6efd;
            font-weight: 700;
        }

.nikoltnutrition-bg .btn-close{
filter: invert(1);
    top: 8px;
    position: absolute;
    right: 8px;
}

        .click-btn {
            padding: 6px 35px;
            font-size: 18px;
            margin-bottom: 6px;
        }

        .thanks-btn {
            background: #fff0;
            border: 0px;
        }

        .footer-box {
            display: block;
            text-align: center;
        }

            .footer-box a {
                text-decoration: none;
                color: #fff;
                cursor: pointer;
            }

                .footer-box a:hover {
                    background-color: #5c636a00;
                    color: #fd0d0d;
                }


                 #slider-header{
            position:relative;
        }
        #slider-header h3, #demo h3{
            color: #fff;
            /* padding-bottom: 50%; */
            text-transform: uppercase;
            text-align: left;
            position: absolute;
            top: 15%;
            padding: 10px 114px;
        }

        #slider-header .carousel-inner .carousel-item .carousel-caption a, #demo .carousel-inner .carousel-item .carousel-caption a{
            text-decoration:none;
            font-family: Publica Sans Medium, sans-serif;
            font-size: 22px;
            font-weight: 500;
            text-align: left !important;
            color:#fff !important;
        }
        .countdown-box{
            padding-left: 0px !important;
        }
        #slider-header .carousel-inner .carousel-item .carousel-caption p, #demo .carousel-inner .carousel-item .carousel-caption p{
            color:#fff !important;
            text-align:left;
        }
        #slider-header .carousel-inner .carousel-item .carousel-caption a:hover,#demo .carousel-inner .carousel-item .carousel-caption a:hover{
            color:#18beb7 !important;
            cursor:pointer;
            
        }
        #slider-header .carousel-inner .carousel-item img,#demo .carousel-inner .carousel-item img{
            filter: brightness(0.4);
        }
        #slider-header .carousel-indicators .active,  #demo .carousel-indicators .active  {
            opacity: 1;
            background-color: #18beb7;
        }








         @media (max-width: 767px)
            {
             #slider-header .carousel-inner .carousel-item>div, #demo .carousel-inner .carousel-item>div {
                display: inline;

            }
             #slider-header .carousel-inner .carousel-item .carousel-caption p, #demo .carousel-inner .carousel-item .carousel-caption p{
                 
                    font-size: 14px;
                    margin-bottom: 0px;
             }
             #slider-header h3, #demo h3 {
                padding-bottom: 20%;
            }
             #slider-header h3, #demo h3 {


                padding: 0px 57px !important;
                font-size: 16px;
            }
            .countdown-box li {

                font-size: 10px !important;

                padding: 5px;

            }
            .countdown-box li span {
                font-size: 18px;

            }
            span.date-list {
                padding: 4px;
                font-size: 12px !important;
            }
         }
         @media  (width: 1024px){
            #slider-header h3, #demo h3 {
         
                top: 10%;
                padding: 10px 75px !important;
                font-size: 17px;
            }

         }


         @media  (min-width: 768px) and (max-width: 920px){
            #slider-header .carousel-inner .carousel-item .carousel-caption p, #demo .carousel-inner .carousel-item .carousel-caption p {
            
                font-size: 14px !important;
            }
            #slider-header h3, #demo h3 {

                top: 10%;
                padding: 28px 60px !important;
                font-size: 16px;
            }
            

            .countdown-box li span {
                font-size: 22px !important;

            }
            #slider-header .carousel-inner .carousel-item .carousel-caption p, #demo .carousel-inner .carousel-item .carousel-caption p {
               
                margin-bottom: 7px !important;
            }
            span.date-list {
                padding: 5px;

                font-size: 12px;
            }
        }

    

    </style>
    <!--End Modelpopup-->

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <main class="body-container-wrapper">
    <div class="flex-top-full">
        <span id="hs_cos_wrapper_flex-top-full" class="hs_cos_wrapper hs_cos_wrapper_widget_container hs_cos_wrapper_type_widget_container" style="" data-hs-cos-general-type="widget_container" data-hs-cos-type="widget_container">


            
            <section>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6 p-0">
                            <div id="slider-header" class="carousel slide" data-bs-ride="carousel">

                                  <!-- Indicators/dots -->
                                  <div class="carousel-indicators left-carousel">
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="0" class="active"></button>
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="1"></button>
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="2"></button>
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="3"></button>
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="4"></button>
                                      <button type="button" data-bs-target="#slider-header" data-bs-slide-to="5"></button>
                                  </div>
  
                                  <!-- The slideshow/carousel -->
                                  <div class="carousel-inner">
                                    
                                        <div class="carousel-item active">
                                                
                                          
                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>
                                            <h3>Smart packaging offers new business opportunities based on digitization</h3>
                                            <div class="backgroun-color-blue"></div>
                                          <img src="../NewContent/img-home/vcqru-left-slider-1.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                          
                                            <div class="carousel-caption">
                                            
                                            <p><b>Security Labels:</b> Guard your Products with confidence and let Security Labels be your silent protectors - a shield of trust that leaves no room for counterfeiting!</p>
                                          </div>
                                        </div>


                                      <div class="carousel-item " id="left-demo">

                                        
                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>


                                          <h3></h3>

                                          <img src="../NewContent/img-home/cosmotech-event-home.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                          
                                            <a href="cosmotech-event.aspx">
                                                <div class="carousel-caption">
                                               <%-- <h4>VCQRU Participating in Cosmo Home Tech Expo</h4>
                                                <p><b> Date:</b> <span class="date-list">19</span> <span class="date-list">20</span> <span class="date-list">21</span> <span class="date-month">JULY 2023</span></p>
                                                    <p><b>Location:</b> Hall No. 5, Stall No. B26</p>
                                                    <p><b>PRAGATI MAIDAN-NEW DELHI</b></p>
                                                    <ul class="countdown-box">
                                                        <li><span id="days"></span>days</li>
                                                        <li><span id="hours"></span>Hours</li>
                                                        <li><span id="minutes"></span>Minutes</li>
                                                        <li><span id="seconds"></span>Seconds</li>
                                                    </ul>--%>
                                            <%--<a href="Patients.aspx"> <p>Innovation on Peak - VCQRU is a Patents Pending Company, Changing the Game with Our Groundbreaking Technology.</p></a>
                                          --%>

                                            </div>
                                            </a>
                                        </div>

                                        <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>
                                            
                                          
                                            
                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>
                                            <h3>Smart packaging offers new business opportunities based on digitization</h3>

                                           <img src="../NewContent/img-home/vcqru-left-slider-2.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                              <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                           <p><b>Printing Services: </b> Turn your visions into vibrant reality with our exceptional Printing Services – where quality craftsmanship meets your creative aspirations!</p>
                                          </div>
                                        </div>

                                        <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>
                                            
                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>
                                            <h3>Smart packaging offers new business opportunities based on digitization</h3>
                                           <img src="../NewContent/img-home/vcqru-left-slider-3.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                          <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                            <p><b>Adhesive Label:</b> Embrace the seamless blend of innovation and style with Adhesive Label – where technology meets elegance!</p>
                                          </div>
                                        </div>

                                        <div class="carousel-item">
                                           <%-- <div class="backgroun-color-blue"></div>--%>

                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>
                                            <h3>Smart packaging offers new business opportunities based on digitization</h3>
                                          <img src="../NewContent/img-home/vcqru-left-slider-4.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                            <p><b>Smart Product Labels:</b> Experience the brilliance of technology in every detail with Smart Product Labels – transforming ordinary products into extraordinary experiences.</p>
                                          </div> 
                                        </div>

                                        <div class="carousel-item">
                                            <div class="backgroun-color-blue"></div>

                                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>

                                            <h3>Smart packaging offers new business opportunities based on digitization</h3>
                                          <img src="../NewContent/img-home/vcqru-left-slider-5.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                              <p><b>Hologram Stickers:</b> From security to style, unleash the holographic marvels – Hologram Stickers: Where protection meets eye-catching perfection!</p>
                                          </div> 
                                        </div>

                                        
                                  </div>
  
                                 
                                </div>

                                
                        </div>
                        <div class="col-md-6 p-0" >

                             <div id="demo" class="carousel slide" data-bs-ride="carousel">

                                  <!-- Indicators/dots -->
                                 <div class="carousel-indicators left-carousel">
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="5"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="6"></button>
                                      <button type="button" data-bs-target="#demo" data-bs-slide-to="7"></button>
                                      

                                  </div>
  
                                  <!-- The slideshow/carousel -->
                                  <div class="carousel-inner">
                                    
                                        <div class="carousel-item active">
                                            <div class="module__accents module__accents--gray" aria-hidden="true">
                                                 <h3>Powering the Future of Anti Counterfeiting</h3>
                                                <div class="module__accents-desktop">

                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">

                                                </div>


                                                <div class="module__accents-mobile">


                                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-left" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                                </div>

                                            </div>
                                            <%--<div class="backgroun-color-blue"></div>--%>
                                          <img src="../NewContent/img-home/Patent pending technology.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                          
                                            <div class="carousel-caption">
                                            
                                            <p><b>Innovation on Peak </b>- VCQRU is a Patents Pending Company, Changing the Game with Our Groundbreaking Technology.</p>
                                          </div>
                                        </div>


                                      <div class="carousel-item ">


                                           




                                          <img src="../NewContent/img-home/packplus-event-home.jpg" alt="Patent pending technology" class="d-block packplus-img" style="width:100%">
                                          
                                            <a href="cosmotech-event.aspx">
                                                <div class="carousel-caption">
                                               <%-- <h4>VCQRU Participating in Cosmo Home Tech Expo</h4>
                                                <p><b> Date:</b> <span class="date-list">19</span> <span class="date-list">20</span> <span class="date-list">21</span> <span class="date-month">JULY 2023</span></p>
                                                    <p><b>Location:</b> Hall No. 5, Stall No. B26</p>
                                                    <p><b>PRAGATI MAIDAN-NEW DELHI</b></p>
                                                    <ul class="countdown-box">
                                                        <li><span id="days"></span>days</li>
                                                        <li><span id="hours"></span>Hours</li>
                                                        <li><span id="minutes"></span>Minutes</li>
                                                        <li><span id="seconds"></span>Seconds</li>
                                                    </ul>--%>
                                            <%--<a href="Patients.aspx"> <p>Innovation on Peak - VCQRU is a Patents Pending Company, Changing the Game with Our Groundbreaking Technology.</p></a>
                                          --%>

                                            </div>
                                            </a>
                                        </div>

                                        <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>

                                          
                                           <h3>Powering the Future of Anti Counterfeiting</h3>

                                           <img src="../NewContent/img-home/Digital-marketing.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                              <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                           <p><b>Digital Marketing</b> - VCQRU is one of the leading digital marketing company in PAN India, we provide the best digital marketing services to clients and helps them to get their ROI.</p>
                                          </div>
                                        </div>

                                        <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>

                                           <div id="3"> <h3>Powering the Future of Anti Counterfeiting</h3></div>

                                           <img src="../NewContent/img-home/web-design-development.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                          <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                            <p><b>Web Design and Development</b> - VCQRU is a leading web design and development company in India. We have a team of professionals who are working on innovative, creative, and effective websites.</p>
                                          </div>
                                        </div>

                                        <div class="carousel-item">
                                           <%-- <div class="backgroun-color-blue"></div>--%>

                                            

                                          <img src="../NewContent/img-home/anti-counterfeit.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                            <p><b>Anti Counterfeit Solution</b> - VCQRU provides anti-counterfeiting solutions that enable users to verify the authenticity of products and help to eliminate counterfeiting.</p>
                                          </div> 
                                        </div>

                                        <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>

                                          


                                          <img src="../NewContent/img-home/build loyalty.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                              <p><b>Build Loyalty</b> - Our build loyalty schemes are designed to incentivize existing customers to continue with your business and also attract new customers.</p>
                                          </div> 
                                        </div>


                                      <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>

                                          


                                          <img src="../NewContent/img-home/E-warranty.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                              <p><b>E Warranty</b> - The E Warranty solution provided by VCQRU is an effective way to simplify the process of making warranty claims for your customers.</p>
                                          </div> 
                                        </div>




                                      <div class="carousel-item">
                                            <%--<div class="backgroun-color-blue"></div>--%>

                                          


                                          <img src="../NewContent/img-home/cash-transfer2.jpg" alt="Patent pending technology" class="d-block" style="width:100%">
                                            <%--<h3>Smart packaging offers new business opportunities based on digitization</h3>--%>
                                            <div class="carousel-caption">
                                              <p><b>Cash Transfer</b> - VCQRU is providing cash transfer schemes, which are offered to customers when they made any specific purchase and get a cash refund.</p>
                                          </div> 
                                        </div>

                                        
                                  </div>
  
                                 
                                </div>





                           
                        </div>
                    </div>
                </div>
            </section>


            <div id="hs_cos_wrapper_widget_1620800559403" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="vertical-spacer module  module--padding-large module--no-padding-bottom  module--bg-transparent"></div>
            </div>
            
            
            
            
            
            <div id="hs_cos_wrapper_widget_1617220840271" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="kpis module  module--padding-small  module--on-light  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top constrain--12  module--bg-light">
                            <div class="module__underlay">

                            </div>

                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                <div class="module__accents-desktop">


                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-right" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">

                                </div>


                            </div>


                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left module__section-header--has-cta">
                            <div class="module__section-header-inner constrain--9">
                                <h2>Welcome to VCQRU</h2>
                                <p><span>Don't let counterfeiting harm your business. At VCQRU we understand that each business has specific needs and challenges when it comes to anti-counterfeiting. That is why we are working closely with our clients to provide customized solutions which are that are both effective and affordable. Our goal is to help you with brand protection while ensuring the safety of your customers.</span></p>
                                <p><span>AT VCQRU our primary goal is to protect the integrity of a brand and its products by identifying and eliminating counterfeit products from the market. Counterfeit goods are illegally produced products and sold under the guise of being genuine. To protect the Counterfeit, we are using a range of techniques such as product serialization, hologram labels, Anti Counterfeit Tags, digital authentication systems, etc to track the authenticity of products throughout the supply chain.</span></p>
                            </div>

                            <div class="module__section-header-cta">
                              
                                <a class="cta-btn cta-btn--medium cta-btn--stroke  data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-4">
                                    <i class="fas fa-play"></i>Watch video
                                </a>
                            </div>

                        </div>

                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="kpis__viewport">
                                    <div class="kpis__grid">

                                        <div class="kpis__kpi">
                                            <h3 class="kpis__kpi-title sub--5">100+</h3>
                                            <p class="kpis__kpi-description kpis__kpi-description--large">Technology Professionals<br> Domain experts</p>
                                        </div>

                                        <div class="kpis__kpi">
                                            <h3 class="kpis__kpi-title sub--5">600+</h3>
                                            <p class="kpis__kpi-description kpis__kpi-description--large">
                                                Brands & Manufactrurer
                                                <br>Clients
                                            </p>
                                        </div>

                                        <div class="kpis__kpi">
                                            <h3 class="kpis__kpi-title sub--5">4.5/5</h3>
                                            <p class="kpis__kpi-description kpis__kpi-description--large">client satisfaction <br>score</p>
                                        </div>

                                        <div class="kpis__kpi">
                                            <h3 class="kpis__kpi-title sub--6">18+</h3>
                                            <p class="kpis__kpi-description kpis__kpi-description--large">Serve Client in Domain</p>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                <div id="widget_1617220840271-modal" class="modal modal--video module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__video">
                                    <video controls>
                                        <source src="https://8759937.fs1.hubspotusercontent-na1.net/hubfs/8759937/CitiusTech Highlights Mar 2022.mp4" type="video">
                                        Your browser does not support the video tag.
                                    </video>
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
            
            
            
            
            
            <div id="hs_cos_wrapper_widget_1616621036337" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="nested-layout module  module--padding-medium module--no-padding-top  module--on-light  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top constrain--12  module--bg-light">
                            <div class="module__underlay">

                            </div>

                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">


                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--five-col nested-layout__grid--one-card nested-layout__grid--desktop-one-card">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">

                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/brand.png">

                                                    </div>

                                                    <div class="column__title column__content--left">
                                                        <h3>Protecting Brand Reputation</h3>
                                                    </div>

                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Counterfeit products harm
                                                                the business reputation by
                                                                providong poor quality goods
                                                                which might harm the health
                                                                of the customer. Anti Counterfeit
                                                                services can help business to
                                                                prevent the scaling of fake
                                                                products.
                                                            </span>
                                                        </p>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">

                                                    <div class="column__image column__image--icon">

                                                        <img class="column__image-elem" src="../NewContent/img-icone/profit-up1.png">
                                                    </div>

                                                    <div class="column__title column__content--left">
                                                        <h3>Protection Of Revenue</h3>
                                                    </div>

                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Counterfeit products may
                                                                cause business to lose revenue
                                                                by undercutting their sales and
                                                                maket value. After protection of
                                                                fake goods businesses maintain
                                                                their revenue and increase
                                                                profitability.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">

                                                        <img class="column__image-elem" src="../NewContent/img-icone/online-privacy1.png">
                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Legal Protection</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Anti Counterfeit services help
                                                                businesses to protect their
                                                                intellectual property rights by
                                                                tracking prodoucts and take
                                                                legal action against counterfeiters.
                                                                In this way businesses avoid
                                                                costly legal battles and get brand
                                                                protection.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">

                                                        <img class="column__image-elem" src="../NewContent/img-icone/customer1.png">
                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Customer Trust</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                By ensuring the authentication of products Anti Counterfeit services help business to build trust within thier customers,
                                                                because customer will get
                                                                genuine products only.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                </div>



                                <div class="nested-layout__grid nested-layout__grid--mobile nested-layout__grid--five-col nested-layout__grid--one-card nested-layout__grid--mobile-carousel owl-carousel" data-autoplay="true" data-duration="5" data-carousel-id="widget_1616621036337-carousel-mobile">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/brand.png" alt="strategy (1)">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Protecting Brand Reputation</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Counterfeit products harm
                                                                the business reputation by
                                                                providong poor quality goods
                                                                which might harm the health
                                                                of the customer. Anti Counterfeit
                                                                services can help business to
                                                                prevent the scaling of fake
                                                                products.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/profit-up1.png" alt="innovation">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Protection Of Revenue</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Counterfeit products may
                                                                cause business to lose revenue
                                                                by undercutting their sales and
                                                                maket value. After protection of
                                                                fake goods businesses maintain
                                                                their revenue and increase
                                                                profitability.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/online-privacy1.png" alt="cardiogram-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Legal Protection</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                Anti Counterfeit services help
                                                                businesses to protect their
                                                                intellectual property rights by
                                                                tracking prodoucts and take
                                                                legal action against counterfeiters.
                                                                In this way businesses avoid
                                                                costly legal battles and get brand
                                                                protection.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <div class="column card one-card">
                                                <div class="column__inner column__inner-box">




                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/customer1.png" alt="thinking">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Customer Trust</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">

                                                        <p>
                                                            <span>
                                                                By ensuring the authentication of products Anti Counterfeit services help business to build trust within thier customers,
                                                                because customer will get
                                                                genuine products only.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>


                                <div class="nested-layout__carousel-controls nested-layout__carousel-controls--mobile has-bg-color--light">
                                    <div id="widget_1616621036337-carousel-mobile__dots" class="owl-carousel__dots"></div>
                                </div>



                            </div>
                        </div>


                    </div>
                </div>

            </div>
            <div id="hs_cos_wrapper_widget_1616621056498" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="nested-layout module  module--padding-medium  module--on-light  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top full-width  module--bg-transparent">
                            <div class="module__underlay">



                            </div>

                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left module__section-header--has-cta">
                            <div class="module__section-header-inner constrain--8">
                                <h2>What We Offer</h2>
                                <p class="pt-4">
                                    We desire that the current generation and the generations to come, do not have to worry about the fakes and counterfeits. We believe in " connecting with the heart and mind of consumers", and our technology and offerings are all centered on it.
                                </p>
                            </div>

                            <div class="module__section-header-cta">
                                
                                <a class="cta-btn cta-btn--medium cta-btn--stroke  data-bs-toggle=" data-bs-toggle="modal" data-bs-target="#myModal-2">
                                    Confused? Consult an expert!
                                </a>
                            </div>

                        </div>




                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--two-col nested-layout__grid--card--white nested-layout__grid--desktop-card">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="anti-counterfeit.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/counterfeit-1.png" alt="Mgmt Consulting">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Anti-counterfeit technology</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>Anti Counterfeit refers to preventing and detecting counterfeiting, which is the act of producing or distributing fake products with the intent to defraud. </span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="build-loyalty.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/build-loyalty-1.png" alt="Data mgmt01">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Build-Loyalty/ Coupon Scheme Solution</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>Build Loyalty is important for all types of businesses as it helps to retain customers, increase the customer lifetime value, create brand loyalty which helps to attract new users. </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="e-warranty.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/e-warrenty-1.png" alt="Enterprise application">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>E-warranty Solution</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>E Warranty or electronic warranty is a type of warranty that is stored and managed electronically rather than on paperwork. This means that customers can access through online mediums. </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="website-design-development.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/web-1.png" alt="female medical professionals in a meeting">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Web & App Development</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>It's a form of cash incentive offered to customers when they buy certain products and receive a cash refund after their purchase. A cash transfer scheme directly credits cash to their virtual wallet or bank account</p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>



                                </div>



                                <div class="nested-layout__grid nested-layout__grid--mobile nested-layout__grid--two-col nested-layout__grid--card--white nested-layout__grid--mobile-stacked">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="anti-counterfeit.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/counterfeit-1.png" alt="Mgmt Consulting">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Anti-counterfeit technology</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>Anti Counterfeit refers to preventing and detecting counterfeiting, which is the act of producing or distributing fake products with the intent to defraud. </span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="build-loyalty.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/build-loyalty-1.png" alt="Data mgmt01">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Build-Loyalty/ Coupon Scheme Solution</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>Build Loyalty is important for all types of businesses as it helps to retain customers, increase the customer lifetime value, create brand loyalty which helps to attract new users. </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="e-warranty.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/e-warrenty-1.png" alt="Enterprise application">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>E-warranty Solution</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>E Warranty or electronic warranty is a type of warranty that is stored and managed electronically rather than on paperwork. This means that customers can access through online mediums. </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--white" href="website-design-development.aspx">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--small">
                                                        <img class="column__image-elem" src="../NewContent/img-home/web-1.png" alt="female medical professionals in a meeting">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Data, Analytics and AI</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>We help healthcare organizations drive convergence, power business decisions and transform healthcare outcomes through data science.</p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>



                                </div>




                            </div>
                        </div>


                    </div>
                </div>

                <div id="widget_1616621056498-modal" class="modal modal--form module--on-light">
                    <div class="modal__background">
                    </div>
                    <div class="modal__wrapper">
                        <div class="modal__viewport">
                            <div class="modal__inner">


                                <div class="modal__form">
                                    <span id="hs_cos_wrapper_widget_1616621056498_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                        <h3 id="hs_cos_wrapper_form_138430622_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text">Consult Our Experts</h3>

                                        <div id="hs_form_target_form_138430622"></div>

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
            <div id="hs_cos_wrapper_widget_1616621067934" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="nested-layout module  module--padding-medium  module--on-dark  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top full-width  module--bg-gradient">
                            <div class="module__underlay">



                            </div>

                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                <div class="module__accents-desktop">


                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-right" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                </div>


                                <div class="module__accents-mobile">


                                    <img class="module__accents-mobile-accent module__accents-mobile-accent--top-right" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                </div>

                            </div>


                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                            <div class="module__section-header-inner constrain--7">
                                <h2>What Makes Us Different</h2>
                                <p><span>We are a product-based IT organization. Our headquarter is in Gurgaon and our marketing team works from Kolkata, Pune, Mumbai, Punjab, Hyderabad, Ahmedabad, Bangalore, UP -Kanpur, Jaipur/Rajasthan, Daman & Diu, Nagpur, Baddi.</span></p>
                            </div>

                        </div>




                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--three-col nested-layout__grid--card--dark nested-layout__grid--desktop-card">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="increase">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Cover PAN India Level</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>
                                                            Serving 600+ clients at PAN India Level for the last 10+ years such as Mahindra & Mahindra, JPC, JAL, Patanjali, Sky decor, Alstone and many more.
                                                        </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">


                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Multiple Modes of Verification</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>This refers to the use of different methods to verify the identity of users. VCQRU provides Multiple Modes of verification covering all the community standards.</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">


                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>20+ Market Domains</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>We are delivering solutions to 20+ market domains means, our dedicated staff members are able to cater to the demand of different industries or market segments</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">

                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">



                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Featured in Hindustan Times</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>Being recognized by a reputable media outlet is an important achievement, VCQRU takes pride featured in Hindustan Times as one of the leading IT companies in Anti-Counterfeit.</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Nominated in  MSME Awards</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>
                                                            <span>
                                                                Being recognized by a reputable media outlet is an important achievement, VCQRU takes pride featured in Hindustan Times as one of the leading IT companies in Anti-Counterfeit.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Multi-Lingual Support</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>We have a multi-lingual support system in 12 different languages, who are fluent in different languages and can provide assistance to customers in their preferred language.</p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>



                                </div>



                                <div class="nested-layout__grid nested-layout__grid--mobile nested-layout__grid--three-col nested-layout__grid--card--dark nested-layout__grid--mobile-stacked">

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="Analytics-1">



                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Cover PAN India Level</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>Industry leading product to accelerate data convergence and interoperability (including FHIR®) across the healthcare ecosystem.</p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="big-data (1)-1">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="H-Scale-1">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Multiple Modes of Verification</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>This refers to the use of different methods to verify the identity of users. VCQRU provides Multiple Modes of verification covering all the community standards.</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="SCORE+">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="SCORE+ - hover">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>20+ Market Domains</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>We are delivering solutions to 18+ market domains means, our dedicated staff members are able to cater to the demand of different industries or market segments</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>































                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="FAST+">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="FAST+ - hover">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Featured in Hindustan Times</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p><span>Being recognized by a reputable media outlet is an important achievement, VCQRU takes pride featured in Hindustan Times as one of the leading IT companies in Anti-Counterfeit.</span></p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="NEW - Perform+">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="NEW - Perform+ hover">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Nominated in  MSME Awards</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>
                                                            <span>
                                                                Contrary to popular belief, Lorem
                                                                Ipsum is not simply random text.
                                                                It has roots in a piece of classical
                                                                Latin literature from 45 BC,
                                                                making it over 2000 years old.
                                                            </span>
                                                        </p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>


                                    <div class="nested-layout__column nested-layout__column--card">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked card card card--dark">
                                                <div class="column__inner">


                                                    <div class="card__background-container" aria-hidden="true">
                                                        <div class="card__background"></div>
                                                        <img class="card__background-accent" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">
                                                    </div>



                                                    <div class="column__image column__image--icon">
                                                        <img class="column__image-elem" src="../NewContent/img-icone/pen-india.png" alt="VeloCT">

                                                        <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-icone/pen-india.png" alt="VeloCT - hover">

                                                    </div>



                                                    <div class="column__title column__content--left">
                                                        <h3>Multi-Lingual Support</h3>
                                                    </div>



                                                    <div class="column__content column__content--left">


                                                        <p>We have a multi-lingual support system in 12 different languages, who are fluent in different languages and can provide assistance to customers in their preferred language.</p>


                                                    </div>


                                                </div>
                                            </a>
                                        </div>
                                    </div>



                                </div>




                            </div>
                        </div>


                    </div>
                </div>















            </div>




            <div id="hs_cos_wrapper_widget_1617209421667" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">




















































                <div class="card-carousel module  module--padding-medium  module--on-light  module--bg-transparent" data-filters="">























                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top full-width  module--bg-transparent">
                            <div class="module__underlay">



                            </div>
















                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

















                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left module__section-header--has-cta">
                            <div class="module__section-header-inner constrain--10">
                                <h2>Knowledge hub</h2>
                                <p>
                                    We are updating blogs on a regular basis to keep you updated with the latest happening in the industry.
                                </p>
                            </div>
                               

                        </div>




                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="card-carousel__content-inner">

                                    <div class="card-carousel__carousel-controls has-bg-color--transparent">
                                        <div id="widget_1617209421667-carousel__nav" class="card-carousel__navigation">
                                            <div id="widget_1617209421667-carousel__dots" class="card-carousel__dots owl-carousel__dots"></div>
                                        </div>
                                    </div>

                                    <div class="card-carousel__carousel card-carousel__carousel--bg-image owl-carousel" data-carousel-id="widget_1617209421667-carousel" data-enlarge="true" data-has-nav="true" data-has-dots="true" data-autoplay="true" data-duration="5">


                                        <div class="card-carousel__item">









                                            <a class="carousel-card carousel-card--bg-image module--on-dark"   rel="noopener noreferrer" href="digital_marketing_blog.aspx">

                                                <div class="carousel-card__image">
                                                   <img class="carousel-card__image-element" src="../NewContent/img-home/knowledge-hub-1.png" >

                                                    <div class="carousel-card__image-overlay module__overlay module__overlay--color-gradient-black-1"></div>

                                                </div>

                                                <div class="carousel-card__content">
                                                    <!--<span class="carousel-card__type">Report</span>
                                                    <h3 class="carousel-card__title">CitiusTech Named a Leader in Everest Group’s Healthcare IT Services Specialists PEAK Matrix® Assessment 2021</h3>-->

                                                    <span class="carousel-card__date">2021</span>

                                                    <p class="carousel-card__description"></p>
                                                </div>


                                            </a>


                                        </div>

                                        <div class="card-carousel__item">









                                            <a class="carousel-card carousel-card--bg-image module--on-dark"   rel="noopener noreferrer" href="warrenty_blog.aspx">



                                                <div class="carousel-card__image">
                                                    <img class="carousel-card__image-element" src="../NewContent/img-home/knowledge-hub-2.png">

                                                    <div class="carousel-card__image-overlay module__overlay module__overlay--color-gradient-black-1"></div>

                                                </div>

                                                <div class="carousel-card__content">
                                                    <!-- <span class="carousel-card__type">Webinar</span>
                                                    <h3 class="carousel-card__title">4 Dimensions to Modernized Quality of Care: Diverse Perspectives</h3>

                                                    <p class="carousel-card__description"></p>-->
                                                </div>


                                            </a>


                                        </div>

                                        <div class="card-carousel__item">









                                            <a class="carousel-card carousel-card--bg-image module--on-dark"   rel="noopener noreferrer" href="Strategies_blog.aspx">



                                                <div class="carousel-card__image">
                                                    <img class="carousel-card__image-element" src="../NewContent/img-home/knowledge-hub-3.png">

                                                    <div class="carousel-card__image-overlay module__overlay module__overlay--color-gradient-black-1"></div>

                                                </div>

                                                <div class="carousel-card__content">
                                                    <!--<span class="carousel-card__type">Article</span>
                                                    <h3 class="carousel-card__title">A Strategic Approach to Complying with the Cures Act</h3>

                                                    <p class="carousel-card__description"></p>-->
                                                </div>


                                            </a>


                                        </div>

                                        <div class="card-carousel__item">









                                            <a class="carousel-card carousel-card--bg-image module--on-dark"   rel="noopener noreferrer" href="Customer_Retention.aspx">



                                                <div class="carousel-card__image">
                                                    <img class="carousel-card__image-element" src="../NewContent/img-home/knowledge-hub-4.png">

                                                    <div class="carousel-card__image-overlay module__overlay module__overlay--color-gradient-black-1"></div>

                                                </div>

                                                <div class="carousel-card__content">
                                                    <!--<span class="carousel-card__type">Report</span>
                                                    <h3 class="carousel-card__title">CitiusTech wins Frost &amp; Sullivan’s 2021 Best Practices Award</h3>

                                                      <span class="carousel-card__date">2021</span>

                                                    <p class="carousel-card__description"></p>-->
                                                </div>


                                            </a>


                                        </div>



                                    









                                        


                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>
                </div>

            </div>





            <div id="hs_cos_wrapper_widget_1616621083923" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="nested-layout module  module--padding-medium  module--on-dark  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top full-width  module--bg-gradient">
                            <div class="module__underlay">



                            </div>

                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                <div class="module__accents-desktop">




                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-right" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">
                                </div>


                                <div class="module__accents-mobile">


                                    <img class="module__accents-mobile-accent module__accents-mobile-accent--top-right" src="../NewContent/img-home/background-accent%402x.png" alt="Background accent">



                                </div>

                            </div>


                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                            <div class="module__section-header-inner constrain--8">
                                <h2>Our Awards And Recognitions</h2>
                                <p>Honoring Achievements: Our Recent Awards And Recognitions </p>
                            </div>

                        </div>




                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--four-col nested-layout__grid--carousel nested-layout__grid--desktop-carousel owl-carousel" data-carousel-id="widget_1616621083923Award-carousel-desktop" data-autoplay="true" data-duration="8" data-desktop-items="2">


                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">


                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Certificate1.jpg" alt="HTR Award Thumbnail">



                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                     This certification solidifies VCQRU as a trusted industry leader, inspiring confidence and satisfaction among its valued clientele.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>


                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Certificate2.jpg" alt="Everest Payer PEAK Matrix KH Thumbnail">



                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                    With the prestigious MSME certificate in hand, VCQRU Company reaffirms its commitment to growth, innovation.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>



                                      

                                  

                                </div>


                                 <div id="widget_1616621083923Award-carousel-desktop__nav" class="nested-layout__navigation nested-layout__navigation--desktop">
                       <%-- <div id="widget_1616621083923Award-carousel-desktop__dots" class="nested-layout__dots owl-carousel__dots owl-carousel__dots--pagination"></div>--%>
                    </div>

               

                                <div class="nested-layout__grid nested-layout__grid--mobile nested-layout__grid--four-col nested-layout__grid--carousel nested-layout__grid--mobile-carousel owl-carousel" data-autoplay="true" data-duration="8" data-carousel-id="widget_1616621083923-carousel-mobile">

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Certificate1.jpg" alt="HTR Award Thumbnail">

                                                    <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-home/Certificate1.jpg" alt="HTR Award Thumbnail">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                       This certification solidifies VCQRU as a trusted industry leader, inspiring confidence and satisfaction among its valued clientele.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Certificate2.jpg" alt="Everest Payer PEAK Matrix KH Thumbnail">

                                                    <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-home/Certificate2.jpg" alt="Everest Payer PEAK Matrix KH Thumbnail">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        With the prestigious MSME certificate in hand, VCQRU Company reaffirms its commitment to growth, innovation.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>

                                   

                                    

                                    <%--<div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" href="javascript:void(0)" rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Gold1.png" alt="NCQA Measure Certification HEDIS MY2022">

                                                    <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-home/Gold1.png" alt="NCQA Measure Certification HEDIS MY2022">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        Contrary to popular belief,
                                                        Lorem Ipsum is not simply
                                                        random text. It has roots in
                                                        a piece of classical Latin
                                                        literature from 45 BC.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>

                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" href="javascript:void(0)" target="_blank" rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Bronze-1.png" alt="CitiusTech wins Frost &amp; Sullivan’s 2021 Best Practices _ Awards">

                                                    <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-home/Bronze-1.png" alt="CitiusTech wins Frost &amp; Sullivan’s 2021 Best Practices _ Awards">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        Contrary to popular belief,
                                                        Lorem Ipsum is not simply
                                                        random text. It has roots in
                                                        a piece of classical Latin
                                                        literature from 45 BC.
                                                    </h3>
                                                </div>

                                                <div class="column__content column__content--left">

                                                </div>

                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" href="javascript:void(0)" rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Platinum1.png" alt="CitiusTech Recognized Amongst the ‘Best Companies to Work for’ -1">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        Contrary to popular belief,
                                                        Lorem Ipsum is not simply
                                                        random text. It has roots in
                                                        a piece of classical Latin
                                                        literature from 45 BC.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>

                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" href="javascript:void(0)" target="_blank" rel="noopener noreferrer">

                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Silver1.png" alt="NCQA MY 2021">

                                                    <img class="column__image-elem column__image-elem--hover" src="../NewContent/img-home/Silver1.png">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        Contrary to popular belief,
                                                        Lorem Ipsum is not simply
                                                        random text. It has roots in
                                                        a piece of classical Latin
                                                        literature from 45 BC.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>

                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked" href="javascript:void(0)" rel="noopener noreferrer">





                                                <div class="column__image column__image--small">
                                                    <img class="column__image-elem" src="../NewContent/img-home/Silver1.png" alt="Everest PEAK Matrix">

                                                </div>



                                                <div class="column__title column__content--left">
                                                    <h3>
                                                        Contrary to popular belief,
                                                        Lorem Ipsum is not simply
                                                        random text. It has roots in
                                                        a piece of classical Latin
                                                        literature from 45 BC.
                                                    </h3>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>--%>





                                </div>


                                <div class="nested-layout__carousel-controls nested-layout__carousel-controls--mobile has-bg-color--gradient">
                                    <div id="widget_1616621083923-carousel-mobile__dots" class="owl-carousel__dots"></div>
                                </div>



                            </div>
                        </div>


                    </div>
                </div>

            </div>

            <!--         Start Reviews From Our Client            -->

            
            <div class="module__section-main module__section-main--block-align-center module--padding-medium">
                <div class="module__content module__content--text-align-left constrain--10">
                    <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--four-col nested-layout__grid--carousel nested-layout__grid--desktop-carousel owl-carousel owl-loaded owl-drag" data-carousel-id="widget_1616621083923-carousel-desktop" data-autoplay="true" data-duration="8" data-desktop-items="4">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                            <div class="module__section-header-inner constrain--8">
                                <h2 class="text-center mb-5"> Reviews From Our Client</h2>

                            </div>

                        </div>

                        <div class="owl-stage-outer">
                            <div class="owl-stage" style="transform: translate3d(-3171px, 0px, 0px); transition: all 0.25s ease 0s; width: 8192px;">
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">

                                                <div class="customer-card">

                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>This company have unique and advanced technical services to grow the business. The company services helped us to connect directly to our customers, so that we could make our marketing and business strategies better.</p>
                                                    <div class="row client-name">
                                                      

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Abhishek Singh</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">




                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU has done a great job keeping in mind about our business idea and developing software as per our niche specifications. The team is technically strong and creative. Thanks, and keep up the same service and hard work!</p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajesh Mishra</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU is driven by passionate employees to create and deliver on new ideas which is reflected in their work. It is a team that strives for excellence and is open to experimenting and creating new trends in the business. </p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Vikash Rathi</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Great work!!! The team is very solid, efficient and knowledgeable. Our work relationship with your company has been productive and we have collectively been able to achieve great results. </p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Devendra Prashad</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">


                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Thank you VCQRU for your valuable support to our business. You have not only shown the commitment and dedication in our project, but also focused on those minute details that were missing from our end. Great Job!</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajeeb Shukhla</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">

                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>This company have unique and advanced technical services to grow the business. The company services helped us to connect directly to our customers, so that we could make our marketing and business strategies better.</p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Abhishek Singh</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">




                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU has done a great job keeping in mind about our business idea and developing software as per our niche specifications. The team is technically strong and creative. Thanks, and keep up the same service and hard work!</p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajesh Mishra</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"    rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU is driven by passionate employees to create and deliver on new ideas which is reflected in their work. It is a team that strives for excellence and is open to experimenting and creating new trends in the business. </p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Vikash Rathi</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"    rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Great work!!! The team is very solid, efficient and knowledgeable. Our work relationship with your company has been productive and we have collectively been able to achieve great results. </p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Devendra Prashad</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"    rel="noopener noreferrer">


                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Thank you VCQRU for your valuable support to our business. You have not only shown the commitment and dedication in our project, but also focused on those minute details that were missing from our end. Great Job!</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajeeb Shukhla</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"    rel="noopener noreferrer">

                                                <div class="customer-card">

                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>This company have unique and advanced technical services to grow the business. The company services helped us to connect directly to our customers, so that we could make our marketing and business strategies better.</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Abhishek Singh</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"  rel="noopener noreferrer">




                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU has done a great job keeping in mind about our business idea and developing software as per our niche specifications. The team is technically strong and creative. Thanks, and keep up the same service and hard work!</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajesh Mishra</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"    rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU is driven by passionate employees to create and deliver on new ideas which is reflected in their work. It is a team that strives for excellence and is open to experimenting and creating new trends in the business. </p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Vikash Rathi</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Great work!!! The team is very solid, efficient and knowledgeable. Our work relationship with your company has been productive and we have collectively been able to achieve great results. </p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Devendra Prashad</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">


                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Thank you VCQRU for your valuable support to our business. You have not only shown the commitment and dedication in our project, but also focused on those minute details that were missing from our end. Great Job!</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajeeb Shukhla</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">

                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>This company have unique and advanced technical services to grow the business. The company services helped us to connect directly to our customers, so that we could make our marketing and business strategies better.</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Abhishek Singh</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"   rel="noopener noreferrer">




                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU has done a great job keeping in mind about our business idea and developing software as per our niche specifications. The team is technically strong and creative. Thanks, and keep up the same service and hard work!</p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajesh Mishra</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU is driven by passionate employees to create and deliver on new ideas which is reflected in their work. It is a team that strives for excellence and is open to experimenting and creating new trends in the business. </p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Vikash Rathi</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Great work!!! The team is very solid, efficient and knowledgeable. Our work relationship with your company has been productive and we have collectively been able to achieve great results. </p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Devendra Prashad</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">


                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Thank you VCQRU for your valuable support to our business. You have not only shown the commitment and dedication in our project, but also focused on those minute details that were missing from our end. Great Job!</p>
                                                    <div class="row client-name">
                                                      

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajeeb Shukhla</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">

                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>This company have unique and advanced technical services to grow the business. The company services helped us to connect directly to our customers, so that we could make our marketing and business strategies better.</p>
                                                    <div class="row client-name">
                                                      

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Abhishek Singh</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">

                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"   rel="noopener noreferrer">




                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU has done a great job keeping in mind about our business idea and developing software as per our niche specifications. The team is technically strong and creative. Thanks, and keep up the same service and hard work!</p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajesh Mishra</h6>
                                                           
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>VCQRU is driven by passionate employees to create and deliver on new ideas which is reflected in their work. It is a team that strives for excellence and is open to experimenting and creating new trends in the business. </p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Vikash Rathi</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">





                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Great work!!! The team is very solid, efficient and knowledgeable. Our work relationship with your company has been productive and we have collectively been able to achieve great results. </p>
                                                    <div class="row client-name">
                                                        

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Devendra Prashad</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-item " style="width: 264.25px;">
                                    <div class="nested-layout__column nested-layout__column--carousel">
                                        <div class="nested-layout__column-inner">
                                            <a class="column column--is-linked"     rel="noopener noreferrer">


                                                <div class="customer-card">
                                                    <img src="../NewContent/img-icone/coat-1.png" class="coate-1 img-fluid">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <p>Thank you VCQRU for your valuable support to our business. You have not only shown the commitment and dedication in our project, but also focused on those minute details that were missing from our end. Great Job!</p>
                                                    <div class="row client-name">
                                                       

                                                        <div class="col-lg-12">
                                                            <h6 class="label-name">Rajeeb Shukhla</h6>
                                                            
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="column__content column__content--left">





                                                </div>



                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div id="widget_1616621083923-carousel-desktop__nav" class="nested-layout__navigation nested-layout__navigation--desktop disabled">
                        
                       <%-- <div id="widget_1616621083923-carousel-desktop__dots" class="nested-layout__dots owl-carousel__dots owl-carousel__dots--pagination">--%>
                           
                        </div>
                        
                    </div>

       
                </div>
            </div>





            <!--         End Reviews From Our Client            -->



            <div id="hs_cos_wrapper_widget_1616621099705" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="one-column module  module--padding-medium  module--on-light  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top full-width  module--bg-transparent">
                            <div class="module__underlay">



                            </div>

                        </div>
                    </div>

                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left module__section-header--has-cta">
                            <div class="module__section-header-inner constrain--10">
                                <h2>Grow with VCQRU family</h2>
                                
                                </div>

                            <div class="module__section-header-cta">
                                <a class="cta-btn cta-btn--medium cta-btn--stroke" href="CareerPage.aspx">
                                    View openings
                                </a>
                            </div>

                        </div>
                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left module__section-header--has-cta">

                                
                                <p><span>We are looking for passionate teammates who can be part of our family, where they can make your future bright. Start your career journey with VCQRU today.</span></p>
                           <p>
                        <b>Flexible Work Arrangements:</b> Embrace flexible work hours or remote work options, 
                        allowing employees to have a better work-life balance and accommodate their personal needs while maintaining productivity.

                    </p>
                    <p>
                        <b>Employee Development and Growth:</b> Establish a culture of continuous learning and professional development by providing 
                        training programs, workshops, and opportunities for employees to enhance their skills and advance in their careers.

                    </p>
                    <p>
                        <b>Collaboration and Communication: </b>  Encourage open and transparent communication channels, fostering collaboration among team members, departments, and management levels. Utilize digital collaboration tools and platforms to enhance communication efficiency.

                    </p>
                    <p><b>Workload and Work-Life Balance:</b> Set realistic work expectations and ensure employees have manageable workloads. Promote a healthy work-life balance by discouraging excessive overtime and encouraging time off and vacation usage.</p>
                    <p><b>Diversity and Inclusion:</b> Emphasize the importance of diversity and inclusion in the workplace, promoting an environment where employees from different backgrounds feel respected, valued, and included.</p>
                    <p><b>Recognition and Rewards:</b> Implement a system for recognizing and rewarding employees' achievements and contributions, whether through monetary incentives, performance-based bonuses, or public acknowledgments.

                    </p>
                    <p><b>Health and Well-being:</b> 
                         Prioritize employee well-being by providing access to wellness programs, mental health resources, ergonomic workstations, and promoting a healthy lifestyle.
                    </p>
                    <p><b>Clear Policies and Guidelines:</b> Establish clear guidelines and policies regarding expected behavior, performance expectations, code of conduct, data security, and confidentiality to ensure a harmonious and secure work environment. 

                    </p>
                    <p>
                        <b>Regular Feedback and Performance Evaluations:</b> Implement a structured performance evaluation process that includes regular feedback sessions, goal-setting, and constructive feedback to help employees grow and improve.
                    </p>
                    <p>
                        <b>Workforce Engagement and Social Activities:</b>  Foster employee engagement through team-building activities, social events, and opportunities for employees to connect with one another beyond work tasks.
                    </p>
                               

                            

                        </div>

                        <div class="module__section-main module__section-main--block-align-center">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <div class="one-column__grid">

                                    <div class="one-column__photo one-column__photo-- ">
                                        <div class="one-column__photo-inner">
                                            <img class="one-column__photo-image" src="../NewContent/img-home/vc-img.png" alt="Grow with us">
                                        </div>
                                    </div>



                                </div>
                            </div>
                        </div>


                    </div>
                </div>

            </div>
            <div id="hs_cos_wrapper_widget_1616796317007" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_module" style="" data-hs-cos-general-type="widget" data-hs-cos-type="module">

                <div class="contact-forms module  module--padding-medium  module--on-light  module--bg-transparent">

                    <div class="module__background">
                        <div class="module__background-inner module__background-inner--height-100 module__background-inner--alignment-top constrain--12  module--bg-light">
                            <div class="module__underlay">



                            </div>

                            <div class="module__accents module__accents--gray" aria-hidden="true">

                                <div class="module__accents-desktop">


                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-right" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">

                                    <img class="module__accents-desktop-accent module__accents-desktop-accent--top-right" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">

                                </div>


                                <div class="module__accents-mobile">


                                    <img class="module__accents-mobile-accent module__accents-mobile-accent--top-right" src="../NewContent/img-home/background-accent@2x.png" alt="Background accent">



                                </div>

                            </div>


                        </div>
                    </div>


                    <div class="module__inner constrain constrain--10">

                        <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                            <div class="module__section-header-inner constrain--4">
                                <h2>Contact VCQRU</h2><p>
                                    We appreciate your interest in VCQRU. Please select from the options below.
                                </p>
                            </div>

                        </div>




                        <div class="module__section-main module__section-main--block-align-left">
                            <div class="module__content module__content--text-align-left constrain--10">
                                <p class="contact-forms__selection-label">Choose any one*</p>
                                <div class="contact-forms__radios">

                                    <label for="widget_1616796317007-radios--1">
                                        <input name="widget_1616796317007-radios" id="widget_1616796317007-radios--1" type="radio" data-form="widget_1616796317007--1" checked="true">
                                        <span>Ask an expert</span>
                                    </label>

                                    <label for="widget_1616796317007-radios--2">
                                        <input name="widget_1616796317007-radios" id="widget_1616796317007-radios--2" type="radio" data-form="widget_1616796317007--2">
                                        <span>Request a demo</span>
                                    </label>

                                    <label for="widget_1616796317007-radios--3">
                                        <input name="widget_1616796317007-radios" id="widget_1616796317007-radios--3" type="radio" data-form="widget_1616796317007--3">
                                        <span>Request RFP</span>
                                    </label>

                                </div>
                                <div class="contact-forms__select">
                                    <select>

                                        <option value="widget_1616796317007--1">Ask an expert</option>

                                        <option value="widget_1616796317007--2">Request a demo</option>

                                        <option value="widget_1616796317007--3">Request RFP</option>

                                    </select>
                                </div>
                                <div class="contact-forms__forms">
                                    <div id="divform1">
                                        <div id="widget_1616796317007--1" class="contact-forms__form active">
                                            <span id="hs_cos_wrapper_widget_1616796317007_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                                <h3 id="hs_cos_wrapper_form_299421441_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>
                                                <div class="row">


                                                    <div class="col-lg-12 col-sm-12">
                                                        <div class="form-group">
                                                            <label>First name*</label>
                                                            <input type="text" name="Name" id="Namef_req" class="form-control" required="" data-error="Please enter your name" maxlength="30" />

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Last name*</label>
                                                            <input type="text" name="name" id="namel_req" class="form-control" required="" />
                                                            <div class="help-block with-errors"></div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Email*</label>
                                                            <input type="email" name="email" id="email_req" class="form-control" required="" />

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Additional info/Questions</label>
                                                            <input type="text" name="text" id="text_req" required="" class="form-control" />

                                                        </div>
                                                    </div>
                                                    <label id="lbl"></label>
                                                    <div class="col-lg-12 col-sm-12">
                                                        <div class="form-check mb-3">
                                                            <input type="checkbox" class="form-check-input" id="exampleCheck_req">
                                                            <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx"> Privacy Policy</a> on how your information may be used*</label>
                                                        </div>
                                                    </div>


                                                    <input type="hidden" name="" id="pageName" value="Contact Us" />
                                                    <div id="validatorMessage" class="form-result Errmsg"></div>


                                                    <div class="col-lg-12 col-md-12">
                                                        <button type="button" name="submitContact" class="default-btn new-button" id="submitbtnask"><span>Submit</span></button>
                                                        <div id="msgSubmit" class="h3 text-center hidden"></div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                                <div id="hs_form_target_form_299421441"></div>

                                            </span>
                                        </div>
                                    </div>
                                    <div id="divsuccessfrm1" style="display:none">
                                        <div class="text-center">
                                            <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                            <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thank you for your interest!</h2>
                                            <p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>


                                        </div>
                                    </div>

                                    <div id="divform2">
                                        <div id="widget_1616796317007--2" class="contact-forms__form">
                                            <span id="hs_cos_wrapper_widget_1616796317007_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                                <h3 id="hs_cos_wrapper_form_263048728-1682874893952_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>
                                                <div class="row">

                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>First name*</label>
                                                            <input type="text" name="Name" id="firstName" class="form-control" required="" data-error="Please enter your name" maxlength="30" />

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Last name*</label>
                                                            <input type="text" name="name" id="lastName" class="form-control" required="" />
                                                            <div class="help-block with-errors"></div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Company name*</label>
                                                            <input type="text" name="name" id="companyName" class="form-control" required="" />
                                                            <div class="help-block with-errors"></div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6 col-sm-6">
                                                        <div class="form-group">
                                                            <label>Work email*</label>

                                                            <input type="email" name="email" id="email" class="form-control" required="" />
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12 col-sm-12">
                                                        <div class="form-group">
                                                            <label>Message</label>
                                                            <input type="text" name="text" id="comment" required="" class="form-control" />

                                                        </div>
                                                    </div>
                                                    <label id="lbl2"></label>
                                                    <div class="col-lg-12 col-sm-12">
                                                        <div class="form-check mb-3">
                                                            <input type="checkbox" class="form-check-input" id="exampleCheck_reqemo">
                                                            <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx"> Privacy Policy</a> on how your information may be used*</label>
                                                        </div>
                                                    </div>


                                                    <input type="hidden" name="" id="pageName" value="Contact Us" />
                                                    <div id="validatorMessage" class="form-result Errmsg"></div>
                                                    <div class="col-lg-12 col-md-12">
                                                        <button type="button" name="submitContact" class="default-btn new-button" id="submitbtnReqdemo"><span>Request Demo</span></button>
                                                        <div id="msgSubmit" class="h3 text-center hidden"></div>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                                <div id="hs_form_target_form_263048728-1682874893952"></div>

                                            </span>
                                        </div>
                                    </div>
                                        <div id="divsuccessfrm2" style="display:none">
                                            <div class="text-center">
                                                <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                                <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thank you for your interest!</h2>
                                                <p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>


                                            </div>
                                        </div>

                                        <div id="divform3">
                                            <div id="widget_1616796317007--3" class="contact-forms__form">
                                                <span id="hs_cos_wrapper_widget_1616796317007_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                                    <h3 id="hs_cos_wrapper_form_439247236-1682874893954_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>
                                                    <div class="row">

                                                        <div class="col-lg-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>First name*</label>
                                                                <input type="text" name="Name" id="firstNameRpf" class="form-control" required="" data-error="Please enter your name" maxlength="30" />

                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label>Last name*</label>
                                                                <input type="text" name="name" id="lastNameRpf" class="form-control" required="" />
                                                                <div class="help-block with-errors"></div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-12 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Company name*</label>
                                                                <input type="text" name="name" id="companyNameRpf" class="form-control" required="" />
                                                                <div class="help-block with-errors"></div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label> email*</label>

                                                                <input type="email" name="email" id="emailRpf" class="form-control" required="" />
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-6 col-sm-6">
                                                            <div class="form-group">
                                                                <label> Phone Number*</label>

                                                                <input type="text" name="phone" id="phoneRpf" maxlength="10" class="form-control" required="" />
                                                            </div>
                                                        </div>


                                                        <div class="col-lg-12 col-sm-12">
                                                            <div class="form-group">
                                                                <label>Additional Info / Questions</label>
                                                                <input type="text" name="text" id="commentRpf" required="" class="form-control" />

                                                            </div>
                                                        </div>
                                                        <label id="lbl3"></label>
                                                        <div class="col-lg-12 col-sm-12">
                                                            <div class="form-check mb-3">
                                                                <input type="checkbox" class="form-check-input" id="exampleCheck_rpf">
                                                                <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx"> Privacy Policy</a> on how your information may be used*</label>
                                                            </div>
                                                        </div>


                                                        <input type="hidden" name="" id="pageName" value="Contact Us" />
                                                        <div id="validatorMessage" class="form-result Errmsg"></div>
                                                        <div class="col-lg-12 col-md-12">
                                                            <button type="button" name="submitContact" class="default-btn new-button" id="submitbtnRFP"><span>Submit</span></button>
                                                            <div id="msgSubmit" class="h3 text-center hidden"></div>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                    </div>
                                                    <div id="hs_form_target_form_439247236-1682874893954"></div>

                                                </span>
                                            </div>
                                        </div>
                                            <div id="divsuccessfrm3" style="display:none">
                                                <div class="text-center">
                                                    <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                                    <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thank you for your interest!</h2>
                                                    <p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>


                                                </div>
                                            </div>

                                        </div>
                            </div>
                        </div>


                    </div>
                </div>

            </div>
        </span>
    </div>
    <div class="page page--sheet">
        <div class="flex-top-sheet">
            <span id="hs_cos_wrapper_flex-top-sheet" class="hs_cos_wrapper hs_cos_wrapper_widget_container hs_cos_wrapper_type_widget_container" style="" data-hs-cos-general-type="widget_container" data-hs-cos-type="widget_container"></span>
        </div>
        <span id="hs_cos_wrapper_primary-content" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_rich_text" style="" data-hs-cos-general-type="widget" data-hs-cos-type="rich_text"></span>
        <div class="flex-bottom-sheet">
            <span id="hs_cos_wrapper_flex-bottom-sheet" class="hs_cos_wrapper hs_cos_wrapper_widget_container hs_cos_wrapper_type_widget_container" style="" data-hs-cos-general-type="widget_container" data-hs-cos-type="widget_container"></span>
        </div>
    </div>
    <div class="flex-bottom-full">
        <span id="hs_cos_wrapper_flex-bottom-full" class="hs_cos_wrapper hs_cos_wrapper_widget_container hs_cos_wrapper_type_widget_container" style="" data-hs-cos-general-type="widget_container" data-hs-cos-type="widget_container"></span>
    </div>

</main>


<div class="modal" id="myModal-4">
    <div class="modal-dialog modal-lg">
                  
       <%-- <button type="button" class="btn-close text-white" data-bs-dismiss="modal" style="float: right;filter: invert(1); cursor:pointer !important;" id="ClsVido"></button>--%>
        <div class="modal-content">
             <button type="button" class="btn-close" data-bs-dismiss="modal" id="ClsVido"></button>
            <!-- Modal Header -->
            <%--<div class="modal-header">
                <%--<h4 class="modal-title">Anticounterfeit</h4>
                
            </div>--%>

            <!-- Modal body -->
            <div class="modal-body">
                <%--<iframe width="100%" height="431"  src="../NewContent/video/Are-you-a-concerned-manufacturer-willing-to-inform-your-end-users.mp4" title="YouTube video player"   frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen id="videopopup"></iframe>--%>

                 <video width="100%" height="431" controls>
                  <source src="../NewContent/video/Are-you-a-concerned-manufacturer-willing-to-inform-your-end-users.mp4" type="video/mp4">

                </video>
            </div>

            <!-- Modal footer -->
            <%--<div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>--%>

        </div>
    </div>
</div>


<div class="container-fluid">
            <div class="modal fade " id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog nikolt-box">
                    <div class="modal-content nikoltnutrition-bg">
                        <div class="modal-header">
                            <img src="../img/nikoltlogo.png" class="modal-title nikoltlogo" id="staticBackdropLabel" alt="nikoltlogo" />
                            <!-- <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5> -->
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-center">
                            <!-- <h1>CONGRATULATIONS!</h1> -->
                            <h5 class="text-light">TO CHECK AUTHENTICITY AND AVAIL BENEFITS OF NIKOLT NUTRITION</h5>
                            <p id="wlink" class="blink_me animate__animated animate__flash">
                                For any QR/Code Related issues please connect on <br> <i class="fa fa-phone" aria-hidden="true"></i> <a href="tel:08047278314">08047278314</a> /
                                <i class="fab fa-whatsapp" aria-hidden="true"></i>
                                <a href="https://api.whatsapp.com/send?phone=+917669017712&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                            </p>
                            <a href="https://www.vcqru.com/Nicolt.aspx"><button type="button" class="btn btn-primary click-btn"> Click here!</button></a>
                            <!--<div class="footer-box"> <a class="btn btn-primary click-btn" data-bs-dismiss="modal" href="https://www.vcqru.com/Nicolt.aspx">Click here!</a></div>-->
                            <div class="footer-box"> <a class=" thanks-btn" data-bs-dismiss="modal">No, Thanks</a></div>

                        </div>
                        <div class="modal-footer ">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
$(window).on("load", function () {
            $("#staticBackdrop").modal('show');

            setTimeout(() => { $("#staticBackdrop").modal('hide'); }, 30000);
        });
</script>

    <!--   event javascript start     -->


        <script>
            var second = 1000,
                minute = second * 60,
                hour = minute * 60,
                day = hour * 24;

            var countDown = new Date('Jul 19, 2023 00:00:00').getTime(),
                x = setInterval(function () {

                    var now = new Date().getTime(),
                        distance = countDown - now;

                    document.getElementById('days').innerText = Math.floor(distance / (day)),
                        document.getElementById('hours').innerText = Math.floor((distance % (day)) / (hour)),
                        document.getElementById('minutes').innerText = Math.floor((distance % (hour)) / (minute)),
                        document.getElementById('seconds').innerText = Math.floor((distance % (minute)) / second);

                    //do something later when date is reached
                    //if (distance < 0) {
                    //  clearInterval(x);
                    //  'IT'S MY BIRTHDAY!;
                    //}

                }, second)
        </script>



     <script>
         var second1 = 1000,
             minute1 = second1 * 60,
             hour1 = minute1 * 60,
             day1 = hour1 * 24;

         var countDown1 = new Date('Aug 10, 2023 00:00:00').getTime();
         // alert(countDown1);
         x = setInterval(function () {

             var now1 = new Date().getTime(),
                 distance1 = countDown1 - now1;

             document.getElementById('days1').innerText = Math.floor(distance1 / (day1)),
                 document.getElementById('hours1').innerText = Math.floor((distance1 % (day1)) / (hour1)),
                 document.getElementById('minutes1').innerText = Math.floor((distance1 % (hour1)) / (minute1)),
                 document.getElementById('seconds1').innerText = Math.floor((distance1 % (minute1)) / second1);

             //do something later when date is reached
             //if (distance < 0) {
             //  clearInterval(x);
             //  'IT'S MY BIRTHDAY!;
             //}

         }, second)
     </script>

    <!--   event javascript End     -->


</asp:Content>


