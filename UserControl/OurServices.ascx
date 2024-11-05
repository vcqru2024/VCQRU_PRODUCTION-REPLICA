<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OurServices.ascx.cs" Inherits="UserControl_OurServices" %>
<style>
    /*.about-section-text1{
        font-family:'IBM Plex Sans Condensed', sans-serif;
        font-size:larger;
    }*/
   
</style>
<script>
    var sctop = '';
    function ShowService(strval) {
       
        $('#remove' + strval).hide();
        $('#pservice' + strval).hide();
       $('#ServiceModalLabel').html($('#pservice' + strval).html());
        $('#Servicep1msg').html($('#dCOUNTERFEIT' + strval).html());
        
        $('#ServiceModal').modal();
        $('#remove' + strval).show();
        $('#pservice' + strval).show();
    }
    function MobileView() {
       
        //alert($(window).width());


        //if (navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i))
        //{
        //   // alert($(window).width());
        //    var callct = (650/400) * $(window).width();
        //   // alert(callct);
        //    callct = callct + 120
        //    $('.imgCF1').height(callct + 'px');
        //}
        //else
        //{
        //    var mtop = $('.imgCF1').height() - 250;
        //    $('#remove1').css("margin-top", mtop + "px");
        //    //var callct = (610 / 485) * $('.imgCF1').height();
        //    //var calPer = parseFloat($('.imgCF1').width() / 610 * 100);
        //    //var calPerHgt = parseFloat(calPer / 100 * 485);
        //    //var callct = (485 - calPerHgt) + 485;
          
        //    //$('.imgCF1').height(callct+50 + 'px');
        //}

    }
    function showdiv(strval, intval) {

       
        //if (strval == 'show') {
        //     sctop = $(window).scrollTop();
        //    $('.thisclass' + intval).show();
        //    $('#thisclassbtnHide' + intval).show();
        //    $('#thisclassbtn' + intval).hide();
           
        //}
        //if (strval == "hide")
        //{
        //    //stp1 = sctop;
        //    $('.thisclass' + intval).hide();
        //    $('#thisclassbtn' + intval).show();
        //    $('#thisclassbtnHide' + intval).hide();
        //    $(window).scrollTop(sctop);
        //}
        
    }
    //function showdiv(strval, btnid, btnhideid) {
    //    if (strval == 'show') {

    //        $('.thisclass').show();
    //        $('#' + btnhideid).show();
    //        $('#' + btnid).hide();

    //    }
    //    else if (strval == "hide") {
    //        $('.thisclass').hide();
    //        $('#' + btnid).show();
    //        $('#' + btnhideid).hide();
    //    }
    //}
</script>
<div class="row"  id="services">
					<div class="col-md-12 heading-bottom-space text-center">
						<h2 class="font-weight-bold appear-animation" data-appear-animation="fadeInDown" data-appear-animation-delay="0"><br />OUR SERVICES</h2>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0" >
						<%--<a >--%>
							<div class="hovereffect" >
								<img class="img-responsive imgCF1"  src="img-1/Counterfiet.jpg" alt="" id="imgCF" >
								<div class="overlay" >
									<h2>Check Product Originality - COUNTERFEIT</h2>
                                  
<%--									<p id="pservice1">
										
									</p>
                                   <div id="remove1"><a  href="../Info/CounterFit.aspx#ser"><p>more...</p></a></div>
                                   --%>
                                 <%--Counterfiet means--%>
                                    <p>	 Replicating the original product by unauthorised means to take the price advantage of the original product
                                     <%--<div id="remove1" style="float:right;position:absolute;right:0;bottom:0;">--%>
                                        <a  href="../Info/CounterFit.aspx#ser1" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
                               </p>
                                   <%--<p class="about-section-text1" style="font-family:'IBM Plex Sans Condensed', sans-serif">Counterfiet means replicating the original product by unauthorised means to take the price advantage of the original product.
                                        According to the report of European Union Intellectual Property Office (EUIPO), piracy in consumer products has costed companies loss of €338 billion in 2017 and is expected to increase by 32% this year.
                                        It is not merely financial loss but due to duplicacy in medicines and food products, it may pose severe health issues which are threat to the life.
                                        Every person has the right to know whether the product they are buying is genuine or not. We use truly secure and encypted codes printed on the labels of the product which are impossible to replicate.
                                         With the help of secure mobile/web tools, the authenticity of the product can be checked.
                                        The problem of counterfieting is affecting almost every sector from consumer and luxury goods through pharma, automotive and defence.
                                         Globally, counterfeiting has become a serious threat. It hamper the reputation of  the brand, 
                                       pose  real danger to the health and safety of consumers, and reduce the profitablity of the company.
                                    </p>--%>
                                    <%-- <div id="dCOUNTERFEIT1">
<%--<P class="about-section-text1"></P>
<P class="about-section-text1"></P>
<P class="about-section-text1"></P>
 <P class="about-section-text1"> </P>
                                       </div>--%>
                                     
								</div>
                                  
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0" id="REFERRALservice">
						<%--<a href="../default.aspx#REFERRALservice">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/Referral-service.jpg" alt="">
								<div class="overlay">
									<h2>User Benifits - REFERRAL SERVICE</h2>
									<%--<p>
										REFERRAL SERVICE
									</p>--%>
                                    <p class="about-section-text1">Referral schemes are in limelight recently and for good reasons as one in a four person buys through
                                         recomendation and the referred customers have 43% higher retention rate
                                        <a  href="../Info/CounterFit.aspx#ser2" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
                                    </p>
                                    <%-- <div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser2"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
<%--<p class="about-section-text1">--%><%--Word of mouth is the prime factor behind 25%-45% of all buying decisions as people trust and value the recomendation. A positive, low cost and effective tool for immediate sales boost. It can spark the sales exponentialy when partnered with efective marketing program.</p>
<p class="about-section-text1">How it can help:</p>
<p class="about-section-text1">It saves your marketing budget.
    It helps in automated lead generation through your existing clientele.
    It offers higher conversion rate.
    It shows customer's loyalty as to what extent your customers liked your product.
    It is one of the largest contributor in building brand awareness.
    It is a simple way to thank your customer who liked your product.
</p>--%>
<%--<p class="about-section-text1"></p>
<p class="about-section-text1"></p>
<p class="about-section-text1"></p>
<p class="about-section-text1"></p>
<p class="about-section-text1"> </p>--%>
								</div>
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
						<%--<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/build-loyalty.jpg" alt="">
								<div class="overlay">
									<h2>Loss Of Customers - BUILD LOYALTY</h2>
									<p>
										  Building customer loyalty is more art than a strategy. In today's world where your competitors are just an inch away from your business,
                                         you can achieve visible growth through building loyalty
                                          <a  href="../Info/CounterFit.aspx#ser3" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
									</p>
                                    <%--<div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser3"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
                                       <%-- <p class="about-section-text1">
                                          
                                            Study shows that loyalty is 30-45% more effective and economical approach to acquire new customers. Nowadays businesses are highly dependent on satisfied customers.<br />
                                            Customer retention is the biggest challenge in the market today and to achieve this, there should be the right value mix in your product.
                                        </p>--%>
                                        <%-- <p class="about-section-text1">
                                          
                                        </p>
                                         <p class="about-section-text1">
                                            
                                        </p>--%>
                                       <%-- <p class="about-section-text1">
                                            How can you achieve this:<br />

                                            Don't neglect customers<br />

                                            Exceed customer expectations<br />

                                            Personalisation helps to biuld strong relationship with the customer

                                        </p>--%>
								</div>
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
						<%--<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/run-survey.jpg" alt="">
								<div class="overlay">
									<h2>Uncertain Market Condition - RUN SURVEY</h2>
									<p>
										The market trends are continuously changing and in order to cope up with this change, market surveys on regular basis can be of great help
                                        <a  href="../Info/CounterFit.aspx#ser4" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
									</p>
                                     <%--<div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser4"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
                                       <%--<p class="about-section-text1">
                                            Whether it’s a new product launch or expansion of your product range in the market, understanding of consumer feedback is extremely important.
                                           Market surveys are an important part of market research that measures the feelings and preferences of customers in a given market.Varying greatly in size, design, 
                                           and purpose, market surveys are one of the main pieces of data that companies use in determining what products and services to offer and how to market them.
                                           How it can help you:
                                           Identification of potential buyers- Understanding who your customers are, will enable you to target the right market effectively.
                                           Feedback from existing customers- With growing competition, business needs nowadays to know the feedback about your product in order to develop new business strategies.
                                           Business expansion plans- Surveys helps to identify the areas of possible business expansion.
                                           Product range- It helps to discover new and unexplored markets that pave the way for business growth.
                                       </p>--%>
                                        <%--<p class="about-section-text1"></p>
                                        <p class="about-section-text1"></p>
                                        <p class="about-section-text1"></p>
                                        <p class="about-section-text1"></p>
                                        <p class="about-section-text1"></p>
                                        <p class="about-section-text1"></p>--%>
								</div>
							</div>
					<%--	</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
					<%--	<a >--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/gift-coupon.jpg" alt="">
								<div class="overlay">

									<h2>Inefficient Customer Reward Schemes - GIFT COUPON </h2>
									
                                    <%--<p id="pservice5">
										
									</p>
                                      <div id="remove5"><a  href= "javascript:ShowService(5);"><p>more...</p></a></div>
                                 
                                      
                                      <p id="pservice0">
										 
                                        RAFFLE SCHEME
                                        
                                 
									</p>
                                       <div id="remove0"><a  href= "javascript:ShowService(0);"><p>more...</p></a></div>--%>
                                 
                                    <div id="dCOUNTERFEIT5" >
                                    <p class="about-section-text1">
                                            Irrespective of the market segment, gift coupon is a clever tool to boost the sales
                                        <a  href="../Info/CounterFit.aspx#ser5" style="text-decoration:none;"> &nbsp;&nbsp; more...</a> </p>
                                       <%-- <div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser5"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
<%--Gift coupons are always appealing and a great way to expand your brand reach.
It is not just that you get a customer visit but also capture his/her buying pattern that can be used to design new marketing campaigns.
                                        <br />
                                        Benefits to the company - 
                                            Boost sales- It is just in option to the customer as to why buy your product.
                                            Personalization- Every gift coupon speaks itself and great way to say that you care.
                                            Build loyalty- To redeem a gift coupon, customer will revisit your store/web portal.
                                            Slippage- Cash is never reimbursed to the customers who do not redeem their gift coupons to the full value or expiry date.<br />
                                            Benefits to the customer - 
                                            Flexibility of selection- Rather than spending time to select gift for your loved ones, gift coupons offers flexibility of product selection.
                                            Continence- As it can be redeemed at any participating store, gift coupons offers great continence.
                                            Control on spending- Its on the customer whether to use the gift coupon to its full or partial value.--%>
                                      

                                       <%-- <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>

                                        <p class="about-section-text1"></p>--%>
                                        </div>
                                   
							</div>
                                </div>
						<%--</a>--%>
					</div>
    <div class="col-lg-4 col-sm-6 col-xs-12 p-0">
						<%--<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/img-5.jpg"    alt="">  
                                <%--src="img-1/Raffle.jpg"--%>
								<div class="overlay">
									<h2>Inefficient Random Sampling For Prizing - Raffle</h2>
									
                                    <p class="about-section-text1">
                                        A raffle scheme involves different possible prizes that can be won through a draw from the group at random. 
                                        A good raffle scheme can be like a cherry on the cake as reward for a customer
                                           <a  href="../Info/CounterFit.aspx#ser6" style="text-decoration:none;"> &nbsp;&nbsp; more...</a> </p>
                                   <%-- <div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser6"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
                                        <%--Our team help you choose your target set of customers and design an effective raffle scheme which will not only boost your sales but at the same time build an effective customer base which can be used later for newsletters or email drops.
                                        It can be a physical card or a scratch code on the product packaging, your customers can participate in your raffle scheme through sms,web or mobile application.
Benifits - 
    Mass Exposure- An effective raffle scheme provides visiblity of your brand among millions of customers.
    Increased Awareness- It dramatically increases your brand awareness both locally or elsewhere.
    Speedy Promotion- Raffle scheme catches eyeballs in a much faster way.
    Database- Raffle scheme helps you create an effective customer databse which can be used later for business planning.--%>


<%--<p class="about-section-text1"></p>

<p class="about-section-text1"></p>

<p class="about-section-text1"></p>

<p class="about-section-text1"></p>--%>

                                    
								</div>
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
					<%--	<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/data-analysis.jpg" alt="">
								<div class="overlay">
									<h2>Unknown Trend /Pattern Change - BIG DATA ANALYSIS</h2>
									<%--<p>
										
									</p>--%>
                                    <p class="about-section-text1"> We are living in the age of technology.
                                         Nowadays with the usage of internet you could easily learn how to make a motorbike or even how to fly an airplane
                                         <a  href="../Info/CounterFit.aspx#ser7" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
                                    </p>
                                    <%--<div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser7"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
<%--<p class="about-section-text1">Without data analysis a company is blind and deaf. With the increase in the use of internet and technology, companies are trying to use this information for maximising their revenues.</p>
<p class="about-section-text1">Data analysis gives you an insight to customer buying pattern. It helps to explore new business opportunities and it is one important thing that can keep your business in the top space.</p>

<p class="about-section-text1">Data can be used to discover business activities and develop efective marketing strategies.</p>--%>
								</div>
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
						<%--<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/customised-solution.jpg" alt="">
								<div class="overlay">
									<h2>Inefficient discount system - CUSTOMISED SOLUTION</h2>
									
                                    <p class="about-section-text1"> With our team of Printing and IT experts, you do not only need to rely on the pre-determined services but
                                         we continously work to help you with customized solutions to meet your unique and specific product authentification and counterfiet protection needs
                                         <a  href="../Info/CounterFit.aspx#ser8" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
                                    </p>
                                        <%--<div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser8"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
<%--Let us help you with the most appropriate tech enabled solution to meet your requirements.<br />Benifits -
    Remain focused on your core business- Our team works to improve your core focus area and help to improve your profitablity matrix.
    Leverage advanced technology and skilled personnel- We use truly secure algo codes to shield your brand.
    Iinnovative security technologies- Our solutions can easily be integrated with your existing product labels which make it csot effective.
Security and much more- We not only provide you security against duplicacy but also provides number of data analysis services which may help you to strategize your business model.--%>

<%--<p class="about-section-text1"></p>--%>

<%--<p class="about-section-text1"></p>

<p class="about-section-text1">

<p class="about-section-text1"> </p>--%>
								</div>
							</div>
						<%--</a>--%>
					</div>
					<div class="col-lg-4 col-sm-6 col-xs-12 p-0">
						<%--<a href="#">--%>
							<div class="hovereffect">
								<img class="img-responsive imgCF1" src="img-1/cash-transfer.jpg" alt="">
								<div class="overlay">
									<h2>Inefficient Discount System - CASH TRANSFER</h2>
									
                                    <p class="about-section-text1">Its a form of cash incentive offered to customers when they buy certain products and 
                                        receive cash refund after their purchase
                                           <a  href="../Info/CounterFit.aspx#ser9" style="text-decoration:none;"> &nbsp;&nbsp; more...</a>
                                    </p>
                                    
                                   <%-- <div style="float:right;position:absolute;right:0;bottom:0;"><a  href="../Info/CounterFit.aspx#ser9"><p>more...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></a></div>--%>
<%--<p class="about-section-text1"> Benifits
    <br />Acquisition of new customers - Its a lucrative scheme which helps you to acquire new customers.
<br />Increase in sales-  Products with benifits are fast selling and may boost your sales drastically.
    <br />Customer loyalty- Cash transfer can help build customer loyalty as it is a direct saving for the customer.
    <br />Informative evaluation- It helps to improve your business statistics.
</p>--%>
<%--
<p class="about-section-text1"></p>

<p class="about-section-text1"></p>
<p class="about-section-text1"></p>
<p class="about-section-text1"></p>
	--%>							</div>
							</div>
						<%--</a>--%>
					</div>

				</div>

<%--<section class="service-bg parallax section section-text-light section-parallax section-center mt-0 mb-0" data-plugin-parallax data-plugin-options="{'speed': 0.20}" data-image-src="img-1/banfit-bg.jpg">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-md-12 heading-bottom-space">
								<h2 class="font-weight-bold appear-animation" data-appear-animation="fadeInDown" data-appear-animation-delay="0">OUR SERVICES</h2>
							</div>
                            <div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInLeft" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
											<i class="icon-services fa fa-check-square" aria-hidden="true">
                                                
											</i>
										</div>
										<h4 class="mb-0">Check Product Originality </h4>
                                        <h5>COUNTERFEIT</h5>
									</div>
									<blockquote>
                                            <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn1"  title="view more details" style="color:#fff" href="javascript:showdiv('show',1);">View More</a>
<div class="thisclass1" style="display:none;">
    <p>	Counterfiet means replicating the original product by unauthorised means to take the price advantage of the original product.</p>
<P>According to the report of European Union Intellectual Property Office (EUIPO), piracy in consumer products has costed companies loss of €338 billion in 2017 and is expected to increase by 32% this year.</p>

<P>It is not merely financial loss but due to duplicacy in medicines and food products, it may pose severe health issues which are threat to the life.</p>

<P>Every person has the right to know whether the product they are buying is genuine or not. We use truly secure and encypted codes printed on the labels of the product which are impossible to replicate. With the help of secure mobile/web tools, the authenticity of the product can be checked.</p>

 <P> The problem of counterfieting is affecting almost every sector from consumer and luxury goods through pharma, automotive and defence. Globally, counterfeiting has become a serious threat. It hamper the reputation of  the brand, pose  real danger to the health and safety of consumers, and reduce the profitablity of the company.</p>
                                            </div>
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide1" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',1);">Hide</a>
									</blockquote>
								</div>
							</div>
							<div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInDown" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
                                            <i class="icon-services fa fa-sitemap" aria-hidden="true">
                                                
                                            </i>
										</div>
										<h4 class="mb-0">User Benifits</h4>
                                         <h5>REFERRAL SERVICE</h5>
									</div>
									<blockquote>
									
                                            <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn2"  title="view more details" style="color:#fff" href="javascript:showdiv('show',2);">View More</a>
                                        
<div class="thisclass2" style="display:none;">
    	<p>Referral schemes are in limelight recently and for good reasons as one in a four person buys through recomendation and the referred customers have 43% higher retention rate.</p>
<p>Word of mouth is the prime factor behind 25%-45% of all buying decisions as people trust and value the recomendation. A positive, low cost and effective tool for immediate sales boost. It can spark the sales exponentialy when partnered with efective marketing program.</p>



<p>How it can help:</p>

<p>It saves your marketing budget.</p>

<p>It helps in automated lead generation through your existing clientele.</p>

<p>It offers higher conversion rate.</p>

<p>It shows customer's loyalty as to what extent your customers liked your product.</p>

<p>It is one of the largest contributor in building brand awareness.</p>

<p> It is a simple way to thank your customer who liked your product.</p>
     </div>
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide2" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',2);">Hide</a>
									</blockquote>
								</div>
							</div>
							<div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInLeft" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
											<i class="icon-services fa fa-user" aria-hidden="true"> 
                                                
											</i>
										</div>
										<h4 class="mb-0">Loss Of Customers</h4>
                                        <h5>BUILD LOYALTY</h5>
									</div>
                                    
									<blockquote class="show">
									
                                        
                                           <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn3"  title="view more details" style="color:#fff" href="javascript:showdiv('show',3);">View More</a>
                                        
<div class="thisclass3" style="display:none;">
    <p>
                                            Building customer loyalty is more art than a strategy. In today's world where your competitors are just an inch away from your business, you can achieve visible growth through building loyalty.
                                        </p>
                                         <p>
                                          Study shows that loyalty is 30-45% more effective and economical approach to acquire new customers. Nowadays businesses are highly dependent on satisfied customers.
                                        </p>
                                         <p>
                                            Customer retention is the biggest challenge in the market today and to achieve this, there should be the right value mix in your product.
                                        </p>
                                        <p>
                                            How can you achieve this:<br />

                                            Don't neglect customers<br />

                                            Exceed customer expectations<br />

                                            Personalisation helps to biuld strong relationship with the customer

                                        </p>
       </div>
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide3" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',3);">Hide</a>
									</blockquote>
								</div>
							</div>
							<div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInDown" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
                                            <i class="icon-services fa fa-comments" aria-hidden="true">
                                                
                                            </i>
										</div>
										<h4 class="mb-0">Uncertain Market Condition</h4>
                                         <h5>RUN SURVEY</h5>
									</div>
									<blockquote>
										
                                             <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn4"  title="view more details" style="color:#fff" href="javascript:showdiv('show',4);">View More</a>
                                        
<div class="thisclass4" style="display:none;">
    <p>The market trends are continuously changing and in order to cope up with this change, market surveys on regular basis can be of great help. Whether it’s a new product launch or expansion of your product range in the market, understanding of consumer feedback is extremely important</p>
                                        <p>Market surveys are an important part of market research that measures the feelings and preferences of customers in a given market. Varying greatly in size, design, and purpose, market surveys are one of the main pieces of data that companies use in determining what products and services to offer and how to market them.</p>
                                        <p>How it can help you:</p>
                                        <p>Identification of potential buyers- Understanding who your customers are, will enable you to target the right market effectively.</p>
                                        <p>Feedback from existing customers- With growing competition, it is the need of business nowadays to know the feedback about your product in order to develop new business strategies.</p>
                                        <p>Business expansion plans- Surveys helps to identify the areas of possible business expansion.</p>
                                        <p>Product range- It helps to discover new and unexplored markets that pave the way for business growth.</p>
                        </div>               
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide4" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',4);">Hide</a>
									</blockquote>
								</div>
							</div>
							<div class="col-md-4"> 
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInRight" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
											
                                            <i class="icon-services fa fa-gift" aria-hidden="true">
                                                 

											</i>
										</div>
										<h4 class="mb-0">Inefficient Customer Reward Schemes</h4>
                                         <h5>GIFT COUPON</h5>
									</div>
                                    <blockquote>
                                      
                                          <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn5"  title="view more details" style="color:#fff" href="javascript:showdiv('show',5);">View More</a>
                                        
<div class="thisclass5" style="display:none;">
      <p>
                                            Irrespective of the market segment, gift coupon is a clever tool to boost the sales.
Gift coupons are always appealing and a great way to expand your brand reach.
It is not just that you get a customer visit but also capture his/her buying pattern that can be used to design new marketing campaigns.
                                        </p>
                                        <p>Benefits to the company</p>

                                        <p>Boost sales- It is just in option to the customer as to why buy your product.</p>

                                        <p>Personalization- Every gift coupon speaks itself and it is a great way to say that you care.</p>

                                        <p>Build loyalty- To redeem a gift coupon, customer will revisit your store/web portal.</p>

                                        <p>Slippage- Cash is never reimbursed to the customers who do not redeem their gift coupons to the full value or expiry date.</p>

                                        <p>Benefits to the customer</p>

                                        <p>Flexibility of selection- Rather than spending time to select gift for your loved ones, gift coupons offers flexibility of product selection.</p>

                                        <p>Continence- As it can be redeemed at any participating store, gift coupons offers great continence.</p>

                                        <p>Control on spending- Its on the customer whether to use the gift coupon to its full or partial value.</p>
     </div>               
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide5" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',5);">Hide</a>

                                    </blockquote>
								</div>
							</div>
							<div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInLeft" data-appear-animation-delay="0">
									<div class="testimonial-author">
                                        <div class="services-icon mb-2">
                                          
                                            <i class="icon-services fa fa-cutlery" aria-hidden="true"> 
                                          

                                            </i>
                                        </div>
										<h4 class="mb-0">Unknown Trend /Pattern Change</h4>
                                        <h5>BIG DATA ANALYSIS</h5>
									</div>
									<blockquote>
                                       
                                        <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn6"  title="view more details" style="color:#fff" href="javascript:showdiv('show',6);">View More</a>
                                        
<div class="thisclass6" style="display:none;">
    <p> We are living in the age of technology. Nowadays with the usage of internet you could easily learn how to make a motorbike or even how to fly an airplane.</p>
<p>Without data analysis a company is blind and deaf. With the increase in the use of internet and technology, companies are trying to use this information for maximising their revenues.</p>
<p>Data analysis gives you an insight to customer buying pattern. It helps to explore new business opportunities and it is one important thing that can keep your business in the top space.</p>

<p>Data can be used to discover business activities and develop efective marketing strategies.</p>
      </div>               
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide6" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',6);">Hide</a>
									</blockquote>
								</div>
							</div>
							
							<div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInRight" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
											<i class="icon-services fa fa-gift" aria-hidden="true"></i>
										</div>
										<h4 class="mb-0">Inefficient random sampling for prizing</h4>
                                        <h5>RAFFLE SCHEME</h5>
									</div>
									<blockquote>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit vehicula est, in consequat.</p>
									</blockquote>
								</div>
							</div>
                            <div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInUp" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
											
                                                <i class="icon-services fa fa-users" aria-hidden="true"> 
                                            
										</div>
										<h4 class="mb-0">Inefficient discount system</h4>
                                        <h5>CUSTOMISED SOLUTION</h5>
									</div>
									<blockquote>
								
                                        <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold"  id="thisclassbtn8"  title="view more details" style="color:#fff" href="javascript:showdiv('show',8);">View More</a>
                                        
<div class="thisclass8" style="display:none;">
    		<p> With our team of Printing and IT experts, you do not only need to rely on the pre-determined services but we continously work to help you with customized solutions to meet your unique and specific product authentification and counterfiet protection needs.</p>
<p>Let us help you with the most appropriate tech enabled solution to meet your requirements.</p>


<p>Benifits</p>

<p>Remain focused on your core business- Our team works to improve your core focus area and help to improve your profitablity matrix.</p>

<p>Leverage advanced technology and skilled personnel- We use truly secure algo codes to shield your brand.</p>

<p>Iinnovative security technologies- Our solutions can easily be integrated with your existing product labels which make it csot effective.</p>

<p> Security and much more- We not only provide you security against duplicacy but also provides number of data analysis services which may help you to strategize your business model.</p>
     </div>               
                                         <a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold" id="thisclassbtnHide8" title="hide details" style="color:#fff;display:none" href="javascript:showdiv('hide',8);">Hide</a>
									</blockquote>
								</div>
							</div>
                            <div class="col-md-4">
								<div class="testimonial testimonial-style-2 appear-animation" data-appear-animation="fadeInUp" data-appear-animation-delay="0">
									<div class="testimonial-author">
										<div class="services-icon mb-2">
										
                                                <i class="icon-services" aria-hidden="true"> 
                                                <img src="../Content/images/Rupee-512.png" alt="Alternate Tex" style="margin-top: -11px;" /></i>
										</div>
										<h4 class="mb-0">Inefficient Discount System</h4>
                                        <h5>CASH TRANSFER</h5>
									</div>
									<blockquote>
										<p>Its a form of cash incentive offered to customers when they buy certain products and receive cash refund after their purchase. Unlike cashback where cutomers are rewarded with points which they can used to buy from a particular vendor or web portal, cash transfer scheme directly credits cash to their virtual wallet or bank account.

Benifits

Acquisition of new customers-  Its a lucrative scheme which helps you to acquire new customers.

Increase in sales-  Products with benifits are fast selling and may boost your sales drastically.
Customer loyalty- Cash transfer can help build customer loyalty as it is a direct saving for the customer.
Informative evaluation- It helps to improve your business statistics.
</p>
									</blockquote>
								</div>
							</div>
							<div class="col-md-12 text-center mt-0">
								<a class="btn btn-outline view-more-btn text-uppercase mt-4 mb-4 mb-md-0 font-weight-bold">View More</a>
							</div>
						</div>
					</div>
				</section>--%>