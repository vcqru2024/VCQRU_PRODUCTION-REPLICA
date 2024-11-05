<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="cosmotech-event.aspx.cs" Inherits="cosmotech_event" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
        .item {
            animation: none !important;
        }

        .subscription-form__column-inner h2{
text-transform: initial !important ;
}

        .icone-flex img {
            padding: 9px;
            border: 1px solid #ccc;
            width: 48px;
            height: 50px;
        }

        .text-align-0 {
            text-align: justify;
        }


        button.accordian-1 {
            background: #d6cccc;
            padding: 6px 14px;
            border: navajowhite;
            color: #fff;
            text-decoration: none;
        }

        button.accordian-2 {
            background: #67ae36;
            padding: 6px 14px;
            border: navajowhite;
            color: #fff;
            text-decoration: none;
        }

        a.event-btn {
            background: #7a2e94;
            color: #fff;
            text-decoration: none;
            padding: 10px 15px;
        }

            a.event-btn:hover {
                color: #ffffff;
                background: #004c8e;
            }

        .place-item-1 {
            place-items: center;
            padding-bottom: 20px;
        }

        .icone-flex img:hover {
            filter: invert(54%) sepia(89%) saturate(355%) hue-rotate(52deg) brightness(93%) contrast(84%);
        }

        .width-tab {
            /* width: 60%; */
            width: 73%;
            margin: auto;
            /* width: fit-content; */
            margin-top: -75px !important;
        }

        .common-tab {
            border-radius: 0px !important;
            text-decoration: none !important;
            /* border: 1px solid black !important; */
            border-right: 1px solid #e3dede !important;
            border-right: 1px solid gray !important;
            padding: 19px 121px;
            padding: 10px 97px;
        }

        .nav-tabs .nav-link {
            background-color: #fff;
            color: black;
        }

        .icone-01 {
            font-size: 24px;
            position: absolute;
            left: -40px;
            z-index: 0;
        }

        .common-tab:hover {
            background: #7a2e94;
            color: #fff !important;
        }


        .tab-content {
            border: 1px solid #e3dede;
        }

        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #ffffff;
            background-color: #7a2e94;
            border-color: var(--bs-nav-tabs-link-active-border-color);
            text-decoration: none;
        }

        .bg-evnt-2 {
            position: relative;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 80vh;
            background-image: url(../NewContent/img-home/bg-event-2.png);
        }


        .bg-event-fix {
            position: relative;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            display: table;
            height: 520px;
            background-image: url(../NewContent/img-home/banner-slider.png);
        }

        a.accordian-1 {
            background: #d6cccc;
            padding: 10px 23px;
            color: #fff;
            text-decoration: none;
        }

        a.accordian-2 {
            background: #7a2e94;
            padding: 10px 23px;
            color: #fff !important;
            text-decoration: none;
        }

        .bg-banner-1 {
            background: #0d0a0a;
            height: 540px;
        }

        .bg-banner-2 {
            background: #fc087d;
            height: 540px;
        }


        input.form-control.input-height {
            padding: 10px;
        }

        .form-background-1 {
            padding: 50px;
        }

        h5 {
            font-weight: 400 !important;
        }

        .height-form {
            padding: 10px !important;
        }

        button.btn-event-1 {
            padding: 7px 52px;
            border: none;
            outline: none;
            background: #274d8e;
            color: #fff;
            ;
        }

        .text-bg-2 {
            padding: 50px;
        }


        #countdown-container {
            display: flex;
            align-items: center;
        }

            #countdown-container div {
                margin: 0 10px;
                font-size: 2rem;
                color: #fff;
                background-color: transparent;
                padding: 10px 20px;
                border-radius: 0px;
                border: 2px solid #fff;
            }



            #countdown-container div {
                margin: 0 10px;
                font-size: 2rem;
                color: #fff;
                background-color: transparent;
                padding: 2px 7px;
                border-radius: 0px;
                border: 2px solid #fff;
            }

        @media (max-width: 767px) {

            #countdown-container div {
                padding: 2px 7px;
            }

            .bg-banner-2 {
                background: #fc087d;
                height: 100%;
            }

            .bg-banner-1 {
                background: #0d0a0a;
                height: 100%;
            }

            .text-bg-2 {
                padding: 20px 15px;
            }

            .form-background-1 {
                padding: 20px 15px;
            }

            button.accordian-1 {
                background: #d6cccc;
                padding: 6px 14px;
                border: navajowhite;
                color: #fff;
                text-decoration: none;
                margin-bottom: 10px;
            }


            a.event-btn {
                background: #7a2e94;
                color: #fff;
                text-decoration: none;
                padding: 10px 5px;
            }
        }



        /*88888*/




        @media (max-width:280px) {
            .common-tab {
                padding: 10px 44px;
            }

            #countdown-container div {
                padding: 2px 6px;
            }

            .width-tab {
                width: unset;
                text-align: center;
            }

            .text-bg-2 {
                padding: 18px;
            }

            #countdown-container div {
                margin: 0 10px;
                font-size: 1rem;
                color: #fff;
                background-color: transparent;
                padding: 2px 7px;
                border-radius: 0px;
                border: 2px solid #fff;
            }
        }



        @media (max-width: 768px) {
        }

        h1, h2, h3, h4, h5, h6 {
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        button.accordian-1 {
            margin-bottom: 10px;
        }

        .width-tab {
            width: unset;
        }

        a {
            transition: all 0.2s ease-in-out;
            color: #009688;
        }

            a:hover, a:focus {
                text-decoration: none;
                color: #00302c;
            }

        .sectionHeading {
            margin-bottom: 20px;
            color: #009688;
        }

        ::-moz-selection {
            background: #fcfcfc;
            background: rgba(224, 224, 224, 0.2);
            text-shadow: none;
        }

        .fa-ul {
            list-style-type: none;
            margin-left: 2.5em;
            padding-left: 0;
            margin: 20px 0px;
        }

        .accordian-maine {
            margin-top: 76px;
            text-align: center;
        }

        ::selection {
            background: #fcfcfc;
            background: rgba(224, 224, 224, 0.2);
            text-shadow: none;
        }

        img::-moz-selection {
            background: transparent;
        }

        img::selection {
            background: transparent;
        }

        img::-moz-selection {
            background: transparent;
        }

        .shadow-nohover {
            box-shadow: 0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12);
            transition: box-shadow 0.28s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @-webkit-keyframes animatop {
            0% {
                opacity: 0;
                bottom: -500px;
            }

            100% {
                opacity: 1;
                bottom: 0px;
            }
        }

        @keyframes animatop {
            0% {
                opacity: 0;
                bottom: -500px;
            }

            100% {
                opacity: 1;
                bottom: 0px;
            }
        }

        @-webkit-keyframes rotatemagic {
            0% {
                opacity: 0;
                transform: rotate(0deg);
                top: -24px;
                left: -253px;
            }

            100% {
                transform: rotate(-30deg);
                top: -24px;
                left: -78px;
            }
        }

        @keyframes rotatemagic {
            0% {
                opacity: 0;
                transform: rotate(0deg);
                top: -24px;
                left: -253px;
            }

            100% {
                transform: rotate(-30deg);
                top: -24px;
                left: -78px;
            }
        }

        h3 {
            margin: 20px 0;
        }

        /*.experience {
            border-left: 3px solid #224f98;
            padding: 0 30px;
            margin-left: 185px;
        }*/

        /*@media (max-width: 767px) {
            .experience {
                margin-left: 0;
                padding-right: 0;
            }
        }*/

        .experience .item {
            position: relative;
            margin-bottom: 40px;
        }

            /*.experience .item::before {
                content: "";
                position: absolute;
                left: -43px;
                top: 0;
                z-index: 0;
                width: 22px;
                height: 22px;*/
                /* border-radius: 50%; */
                /*background: #f3f5f9;
                border: 3px solid #009688;
            }

            .experience .item::after {
                content: "";
                position: absolute;
                left: -37px;
                top: 6px;
                width: 10px;
                height: 10px;*/
                /* border-radius: 50%; */
                /* background: #009688; */
                /*z-index: 0;
            }*/

        .experience .company-name {
            color: #009688;
        }

        .experience .location {
            position: absolute;
            right: 0;
            top: 2px;
        }

            .experience .location .fa {
                margin-right: 8px;
            }

        .experience .job-info {
            position: absolute;
            left: -185px;
            top: 0;
        }

            .experience .job-info .title {
                color: #009688;
            }

        @media (max-width: 767px) {
            .experience .job-info {
                position: static;
                margin-bottom: 1rem;
            }
        }

        /*8888888888888888888888888888888*/
    </style>

    <script type="text/javascript">

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



    <main class="body-container-wrapper" style="width: 100%;">


        <section class="bg-event-fix">

            <div class="container">
                <div class="row">

                    <div class="col-lg-6 p-0">
                        <div class="bg-banner-1">
                            <div class="text-bg-2 text-align-0">
                                <h1 class="text-white ">VCQRU
                                    <br />
                                    PARTICIPATING </br>
IN <span style="color: #fd0880;">Cosmohome Tech </span>
                                    <br />
                                    Expo 2023</h1>
                                <h5 class="text-white mt-4">HURRY UP!</h5>
                                <p>
                                    Welcome to VCQRU, where we bridge the gap between IT technologies and label printing and packaging. As an organization, we provide a unique platform that caters to brands across diverse domains such as healthcare, automobile, paint and building materials, plywood, FMCG, and more. 
                                </p>




                               



                            </div>



                        </div>


                    </div>

                    <div class="col-lg-6 p-0">
                        <div class="bg-banner-2">
                            <div class="form-background-1">
                                <div id="Head">
                                    <h5 class="mt-sm-5  text-white uppercase">Submit your details  to GET YOUR FREE PASSES of the Cosmohome Tech Expo 2023</h5>
                                </div>
                                <form method="post">
                                    <div id="eform">
                                        <input type="text" class="form-control height-form mb-3" maxlength="30" id="ename" placeholder="FULL NAME" required>
                                        <input type="text" class="form-control height-form mb-3" maxlength="50" id="eemil" placeholder="EMAIL ADDRESS" required>
                                        <input type="text" class="form-control height-form mb-3" maxlength="10" id="enumber" placeholder="PHONE NUMBER" required>
                                        <input type="text" class="form-control height-form mb-3" maxlength="150" id="ecomp" placeholder="COMPANY NAME" required>
                                        <input type="text" class="form-control height-form mb-3" maxlength="5" id="evisitor" placeholder="NO. OF VISITORS" required>
                                        <input type="hidden" id="hdnevent" name="custId" value="Cosmo Tech Expo">
                                        <label id="elbl" style="color: white"></label>
                                        <button type="submit" id="ebutton" class="btn-event-1 ">Submit</button>
                                    </div>
                                    <div id="esuccess" style="display: none">
                                        <div class="text-center">
                                            <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #000000;"></i>
                                            <h2 class="mt-3" style="color: #000000; font-size: 18px;">Thank you for your interest!</h2>
                                            <p class="mt-2" style="font-size: 18px; color: white;">We appreciate your interest in the exhibition! Our representative will be in touch with you shortly to coordinate the issuance of event passes for you.</p>


                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </section>

        <section>
            <div class="container">
                <div class="row mt-5 place-item-1">
                    <div class="col-lg-5 col-sm-5">
                        <div class="img-sidebar">
                            <img class="column__image-elem" src="../NewContent/img-home/sidebar-cosmo.png" alt="NCQA Measure Certification HEDIS MY2022">
                        </div>
                    </div>
                    <div class="col-lg-7 col-sm-7">

                        <div class="right-sidebar">
                            <h3>HOW VCQRU HELP YOUR BUSINESS TO GROW</h3>

                            <div class="icone-flex">






                                <ul class="nav nav-tabs " role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active active-counter" data-bs-toggle="tab" href="#home1">
                                            <img class="column__image-elem" src="../NewContent/img-icone/shield-1.png" alt="shield-1"></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu11">
                                            <img class="column__image-elem" src="../NewContent/img-icone/box-1.png" alt="box-1.png"></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu21">
                                            <img class="column__image-elem" src="../NewContent/img-icone/label-1.png" alt="label-1.png"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu31">
                                            <img class="column__image-elem" src="../NewContent/img-icone/track-1.png" alt="track-1"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu41">
                                            <img class="column__image-elem" src="../NewContent/img-icone/warranty-1.png" alt="warranty-1"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu51">
                                            <img class="column__image-elem" src="../NewContent/img-icone/digital-marketing-1.png" alt="digital-marketing"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu61">
                                            <img class="column__image-elem" src="../NewContent/img-icone/money-exchange-1.png" alt="money-exchange-1"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu71">
                                            <img class="column__image-elem" src="../NewContent/img-icone/network-1.png" alt="network-1"></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" data-bs-toggle="tab" href="#menu81">
                                            <img class="column__image-elem" src="../NewContent/img-icone/ticket-1.png" alt="ticket-1"></a>
                                    </li>



                                </ul>





                            </div>
                            <div class="tab-content border-0">
                                <div id="home1" class="container tab-pane active">
                                    <h5 class="mt-5">ANTI-COUNTERFIET</h5>
                                    <p>Counterfeit products are a global problem that affects brands, consumers, and economies alike. According to a report by the Organization for Economic Co-operation and Development (OECD), the value of counterfeit products traded worldwide is estimated to be around USD 509 billion annually.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="anti-counterfeit.aspx?id=anti" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>


                                <div id="menu11" class="container tab-pane ">
                                    <h5 class="mt-5">Anti-Counterfeit Solutions For Packing</h5>
                                    <p>Anti-counterfeit solutions for packaging are measures that are put in place to prevent the production and distribution of counterfeit products that are often packaged to look like genuine products.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="packaging.aspx?id=pack" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu21" class="container tab-pane ">
                                    <h5 class="mt-5">Smart Labels</h5>
                                    <p>Smart labels are affixed with the products and packaging to provide detailed information about the items. They can also be used to track and monitor the item through the supply chain, making it easy to manage inventory, reduce waste and prevent counterfeiting.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="smart-labels.aspx?id=smart" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu31" class="container tab-pane ">
                                    <h5 class="mt-5">Secure Track and Trace</h5>
                                    <p>In today's fast-paced world, it is crucial for brands to have visibility into their product's journey from manufacturing to end-users. This is where track and trace technology comes into play. Track and trace is a process that enables companies to monitor and trace their products throughout the supply chain. This technology can help businesses to identify potential bottlenecks, improve efficiencies, and ultimately ensure that products reach their intended destinations.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="track-trace.aspx?id=track" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu41" class="container tab-pane ">
                                    <h5 class="mt-5">E- Warranty</h5>
                                    <p>A e warranty services is one solution that has made the warranty claim process easy for customers, manufacturers, and retailers. It is a good opportunity for customers to directly connect with the manufacturers.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="e-warranty.aspx?id=ew" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu51" class="container tab-pane ">
                                    <h5 class="mt-5">Digital Marketing</h5>
                                    <p>According to the Global Digital Marketing Market Report, the global digital marketing market is aided by the increasing number of internet users and the growing adoption of intelligent devices. The market is projected to grow at a CAGR of around 9.1% between 2022-27. Digital marketing also referred to as internet marketing and online marketing, is a popular activity by brands and businesses to build their online presence. Digital marketing means promoting your brand or business via digital platforms. The digital channels include social media, search engines, email, content marketing, and many more.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="digital-marketing.aspx?id=digital" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu61" class="container tab-pane ">
                                    <h5 class="mt-5">Cash Transfer</h5>
                                    <p>It's a form of cash incentive, generally offered to customers when they buy certain products and receive a cash refund after their purchase.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="cash-transfer.aspx?id=cash" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu71" class="container tab-pane ">
                                    <h5 class="mt-5">Customer Referral Services Program</h5>
                                    <p>The referral marketing program is one of the most cost-effective marketing ways where businesses use current customers to spread the message about their brand.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="referral-services.aspx?id=reffral" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>

                                <div id="menu81" class="container tab-pane ">
                                    <h5 class="mt-5">Raffle</h5>
                                    <p>A raffle scheme involves different possible prizes that can be won through a draw from the group at random. A good raffle scheme can be like a cherry on the cake as a reward for a customer. Raffles have been a powerful marketing tool even before the launch of digital marketing.</p>

                                    <div class="maine-event-btn mt-sm-5"><a href="raffle.aspx?id=raffle" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>
                                </div>
                                <%--<div class="maine-event-btn mt-sm-5"><a href="#" data-bs-toggle="modal" data-bs-target="#myModal-3" class="event-btn mt-5">CLICK HERE TO BOOK YOUR DEMO</a></div>--%>
                            </div>
                        </div>


                    </div>



                </div>
            </div>
        </section>


            
        <section class="bg-evnt-2 mt-5">
            <div class="container">
                <div class="row">
                    <div class="maine-tab-heading">

                        <h3 class="text-center mt-5" style="color: #7a2e94;">EXHIBITION SCHEDULE</h3>
                        <h6 class="text-center" style="color: #d211a2;">Our Schedule Table</h6>

                        <div class="img-tab-inner mt-5">
                            <img class="column__image-elem" src="../NewContent/img-home/tab-bg-cosmo.png" alt="network-1">
                        </div>

                        <div class="nav-tabs width-tab my-5">

                            <ul class="nav nav-tabs space-tab">
                                <li class="nav-item">
                                    <a class="nav-link common-tab active text-center" data-bs-toggle="tab" href="#home">Wednesday<br />
                                        19-Jul-2023</a>


                                </li>
                                <li class="nav-item">
                                    <a class="nav-link common-tab" data-bs-toggle="tab" href="#menu1">THURSDAY<br />
                                        20-Jul-2023</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link common-tab" data-bs-toggle="tab" href="#menu2">FRIDAY
                                        <br />
                                        21-Jul-2023</a>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane container active" id="home">
                                    <div class="container">

                                        <div class="experience mt-5">
                                            <div class="item">

                                               <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                <h5 class="company-name text-dark">Where can I get some?</h5>

                                                <div class="job-info">

                                                    <div>10:00 AM</div>
                                                </div>--%>
                                               
                                            </div>

                                            <div class="item">
                                               <%-- <i class="fa fa-angle-down icone-01" style="font-size: 24px"></i>
                                                <h5 class="company-name text-dark">Where does it come from?</h5>

                                                <div class="job-info">

                                                    <div>11:30 AM</div>
                                                </div>--%>
                                                <div>
                                                    <ul class="fa-ul">
                                                         <li><%--<i class="fa-li fa fa-hand-o-right"></i>--%>Join us to be part of a global movement against counterfeit products and Smart packaging. Together, let's work towards a world where consumers can trust the authenticity of the products they purchase, and legitimate businesses can thrive without the fear of illicit competition.</li>
                                                       
                                                        <div class="accordian-maine">
                                                            <%--<button class="accordian-1">11:30 AM - 01:00 PM</button>
                                                            <button class="accordian-2">11:30 AM - 01:00 PM</button>--%>
                                                        </div>
                                                    </ul>


                                                </div>
                                            </div>

                                            <div class="item">
                                               <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                <h5 class="company-name text-dark">Where can I get some?</h5>

                                                <div class="job-info">

                                                    <div>02:30 AM</div>
                                                </div>--%>
                                                <%-- <div>
        <ul class="fa-ul">
          <li><i class="fa-li fa fa-hand-o-right"></i>Achieved 35% & 50% increase in sales from previous year in first two years</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Identified & followed up on potential inquiries after analysing the market. Handled orders from quote to cash stage</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Played an important role in moving from sales-only office to setting up the warehouse & training sales assistant</li>
        </ul>
      </div>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane container fade" id="menu1">
                                    <div class="tab-pane container active" id="home">
                                        <div class="container">

                                            <div class="experience mt-5">
                                                <div class="item">

                                                   <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where can I get some?</h5>

                                                    <div class="job-info">

                                                        <div>10:00 AM</div>
                                                    </div>--%>
                                                    <%-- <div>
        <ul class="fa-ul">
          <li><i class="fa-li fa fa-hand-o-right"></i>Achieved 35% & 50% increase in sales from previous year in first two years</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Identified & followed up on potential inquiries after analysing the market. Handled orders from quote to cash stage</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Played an important role in moving from sales-only office to setting up the warehouse & training sales assistant</li>
        </ul>
      </div>--%>
                                                </div>





                                                <div class="item">
                                                   <%-- <i class="fa fa-angle-down icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where does it come from?</h5>

                                                    <div class="job-info">

                                                        <div>11:30 AM</div>
                                                    </div>--%>
                                                    <div>
                                                        <ul class="fa-ul">
                                                            <li><%--<i class="fa-li fa fa-hand-o-right"></i>--%>Throughout the event, there will be dedicated exhibition spaces where our anti-counterfeiting technology experts, solution developers, and Packaging solution stakeholders will showcase their products and services. Attendees will have the opportunity to interact with exhibitors, witness live demonstrations, and explore potential partnerships to enhance their anti-counterfeiting efforts.</li>
                                                            <div class="accordian-maine">
                                                               <%-- <button class="accordian-1">11:30 AM - 01:00 PM</button>
                                                                <button class="accordian-2">11:30 AM - 01:00 PM</button>--%>
                                                            </div>
                                                        </ul>


                                                    </div>
                                                </div>

                                                <div class="item">
                                                   <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where can I get some?</h5>

                                                    <div class="job-info">

                                                        <div>02:30 AM</div>
                                                    </div>--%>
                                                    <%-- <div>
        <ul class="fa-ul">
          <li><i class="fa-li fa fa-hand-o-right"></i>Achieved 35% & 50% increase in sales from previous year in first two years</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Identified & followed up on potential inquiries after analysing the market. Handled orders from quote to cash stage</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Played an important role in moving from sales-only office to setting up the warehouse & training sales assistant</li>
        </ul>
      </div>--%>
                                                </div>












                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="tab-pane container fade" id="menu2">

                                    <div class="tab-pane container active" id="home">
                                        <div class="container">

                                            <div class="experience mt-5">
                                                <div class="item">

                                                   <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where can I get some?</h5>

                                                    <div class="job-info">

                                                        <div>10:00 AM</div>
                                                    </div>--%>
                                                    <%-- <div>
        <ul class="fa-ul">
          <li><i class="fa-li fa fa-hand-o-right"></i>Achieved 35% & 50% increase in sales from previous year in first two years</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Identified & followed up on potential inquiries after analysing the market. Handled orders from quote to cash stage</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Played an important role in moving from sales-only office to setting up the warehouse & training sales assistant</li>
        </ul>
      </div>--%>
                                                </div>

                                                <div class="item">
                                                   <%-- <i class="fa fa-angle-down icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where does it come from?</h5>

                                                    <div class="job-info">

                                                        <div>11:30 AM</div>
                                                    </div>--%>
                                                    <div>
                                                        <ul class="fa-ul">
                                                            <li><%--<i class="fa-li fa fa-hand-o-right"></i>--%>The final day of the event focuses on fostering collaboration among stakeholders, including industry players, government agencies, law enforcement authorities, and consumer organizations. Engage in panel discussions, workshops, and networking sessions to explore opportunities for joint initiatives, information sharing, and coordinated efforts to combat counterfeiting effectively.</li>
                                                           
                                                            <div class="accordian-maine">
                                                              <%--  <button class="accordian-1">11:30 AM - 01:00 PM</button>
                                                                <button class="accordian-2">11:30 AM - 01:00 PM</button>--%>
                                                            </div>
                                                        </ul>


                                                    </div>
                                                </div>

                                                <div class="item">
                                                   <%-- <i class="fa fa-angle-up icone-01" style="font-size: 24px"></i>
                                                    <h5 class="company-name text-dark">Where can I get some?</h5>

                                                    <div class="job-info">

                                                        <div>02:30 AM</div>
                                                    </div>--%>
                                                    <%-- <div>
        <ul class="fa-ul">
          <li><i class="fa-li fa fa-hand-o-right"></i>Achieved 35% & 50% increase in sales from previous year in first two years</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Identified & followed up on potential inquiries after analysing the market. Handled orders from quote to cash stage</li>
          <li><i class="fa-li fa fa-hand-o-right"></i>Played an important role in moving from sales-only office to setting up the warehouse & training sales assistant</li>
        </ul>
      </div>--%>
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
        </section>






        <div class="module__section-main module__section-main--block-align-center module--padding-medium">
            <div class="module__content module__content--text-align-left constrain--10">
                <div class="nested-layout__grid nested-layout__grid--desktop nested-layout__grid--four-col nested-layout__grid--carousel nested-layout__grid--desktop-carousel owl-carousel owl-loaded owl-drag" data-carousel-id="widget_1616621083923-carousel-desktop" data-autoplay="true" data-duration="8" data-desktop-items="4">

                    <div class="module__section-header module__section-header--block-align-left module__section-header--text-align-left">
                        <div class="module__section-header-inner constrain--8">
                            <h2 class="text-center mb-5">Reviews From Our Client</h2>

                        </div>

                    </div>

                    <div class="owl-stage-outer">
                        <div class="owl-stage" style="transform: translate3d(-4492px, 0px, 0px); transition: all 0.25s ease 0s; width: 13477px;">
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item active" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item active" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item active" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  active" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">


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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">

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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">




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
                            <div class="owl-item  cloned" style="width: 264.25px;">
                                <div class="nested-layout__column nested-layout__column--carousel">
                                    <div class="nested-layout__column-inner">
                                        <a class="column column--is-linked" rel="noopener noreferrer">





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
                        </div>
                    </div>
                </div>


                <div id="widget_1616621083923-carousel-desktop__nav" class="nested-layout__navigation nested-layout__navigation--desktop disabled">
                    <button type="button" role="presentation" class="owl-prev" fdprocessedid="mdqth"><i class="fas fa-chevron-left"></i></button>



                    <button type="button" role="presentation" class="owl-next" fdprocessedid="xvxw2q"><i class="fas fa-chevron-right"></i></button>
                </div>

            </div>



            <%--  <div class="modal modal" id="myModal-3">
            <div class="modal-dialog modal-dialog modal-lg">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Request Consultation</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body ">
                        <div class="two-column__form">
                            <div class="two-column__form-content">



                            </div>
                            <div class="two-column__form-inner">
                                <span id="hs_cos_wrapper_widget_1617729660512_" class="hs_cos_wrapper hs_cos_wrapper_widget hs_cos_wrapper_type_form" style="" data-hs-cos-general-type="widget" data-hs-cos-type="form">
                                    <h3 id="hs_cos_wrapper_form_977481405_title" class="hs_cos_wrapper form-title" data-hs-cos-general-type="widget_field" data-hs-cos-type="text"></h3>

                                    <div id="hs_form_target_form_977481405">


                                        <form class="services_form">
                                            <div id="div_mld3">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">Frist Name</label>
                                                            <input type="text" id="fname_mdl3" class="form-control mb-3" aria-describedby="emailHelp" required>

                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">Last Name</label>
                                                            <input type="text" id="lname_mdl3" class="form-control mb-3" aria-describedby="emailHelp" required>

                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">Company Name</label>
                                                            <input type="text" id="comp_mdl3" class="form-control mb-3" aria-describedby="emailHelp" required>

                                                        </div>
                                                    </div>



                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">Email*</label>
                                                            <input type="email" id="email_mdl3" class="form-control mb-3" aria-describedby="emailHelp" required>

                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">Phone*</label>
                                                            <input type="text" id="phone_mdl3" class="form-control mb-3" aria-describedby="phoneHelp" required>

                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="form-group">
                                                            <label for="exampleInputname">How can we help?*</label>
                                                            <input type="text" id="addi_mdl3" class="form-control mb-3" aria-describedby="textHelp" required>

                                                        </div>
                                                    </div>
                                                    <label id="lbl_mdl3"></label>
                                                    <div class="col-lg-12">
                                                        <div class="form-check my-3">
                                                            <input type="checkbox" class="form-check-input" id="check_mdl3" required>
                                                            <label class="form-check-label" for="exampleCheck1">By submitting your personal information to VCQRU, you are agreeing to VCQRU’s <a href="Privacy_Policy.aspx">Privacy Policy</a> on how your information may be used*</label>
                                                        </div>
                                                        <button type="submit" id="btn_mdl3" class="btn btn-primary">Submit</button>
                                                    </div>

                                                </div>
                                            </div>
                                            <div id="divsuccess_mdl3" style="display:none">
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
                   <%-- @*<div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                </div>*@--%>
        </div>
        </div>






        </div>



        </div>

        <script>

           
        </script>

    </main>

</asp:Content>

