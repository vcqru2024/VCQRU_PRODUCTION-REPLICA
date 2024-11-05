<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Contact.ascx.cs" Inherits="UserControl_Contact" %>
  <style>
        ul.contact_social {
  padding: 0;
  margin: 0;
  list-style: none;
}
ul.contact_social li {
  float: left;
  margin-right: 5px;
}
ul.contact_social li a i {
  width: 25px;
  height: 25px;
  display: block;
  background: url(/Content/images/img_sprite.png)no-repeat;
}
ul.contact_social li a i.fb {
  background-position:-178px -173px;
}
ul.contact_social li a i.tw {
  background-position:-205px -174px;
}
ul.contact_social li a i.google{
  background-position:-235px -173px;
}
ul.contact_social li a i.utube{
  background-position:-266px -174px;
}
ul.contact_social li a i.linkedin{
  background-position:-296px -174px;
}
    </style>
    <script type="text/javascript">
        function sendcquery() {debugger;
            toastr.clear();
            if ($('#cname').val() == '') {
                toastr.error("Please enter Name"); msg = "no"; return false
            }
            else {
                if ($('#cemail').val() == '') {
                    toastr.error("Please enter email"); msg = "no"; return false
                }
                else {
                    var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                    var valid = emailReg.test($('#cemail').val());
                    if (!valid) {
                        toastr.error("Please enter the correct email."); return false;
                    }
                    else {
                        if ($('#cmobile').val() == '') {
                            toastr.error("Please enter your mobile no."); msg = "no"; return false
                        }

                        var v = $('#cmobile').val().length;
                        if (v < 10 || v > 12) {
                            toastr.error("Please enter correct Mobile Number."); return false;
                        }
                        // var MobileReg = new RegExp("^[0-9_.+-]+$");
                        var MobileReg = /[0-9]|\./;
                        var valid = MobileReg.test($('#cmobile').val());
                        if (!valid) {
                            toastr.error("Please enter the correct mobile no.");
                            return false;
                        }
                        if ($('#ccomment').val() == '') {
                            toastr.error("Please enter your message."); msg = "no"; return false
                        }
                        else {
                            //var MobileReg = new RegExp("^[0-9_.+-]+$");
                            //var valid = MobileReg.test($('#cmobile').val());
                            //if (!valid) {
                            //    toastr.error("Please enter the correct mobile no."); return false;
                            //}

                            //else {
                            $('#progress').show();
                                $.ajax({
                                    type: "POST",
                                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=sendquery&name=' + $('#cname').val() + '&email=' + $('#cemail').val() + '&comment=' + $('#ccomment').val() + '&cmobile=' + $('#cmobile').val(),
                                    success: function (data) {
                                        $('#progress').hide();
                                        $('#cname').val('');
                                        $('#cemail').val('');
                                        $('#ccomment').val('');
                                        $('#cmobile').val('');
                                        toastr.info(data);
                                    },
                                });
                            
                        }
                    }
                }
            }
            $('#progress').hide();
        }
        function alphanumeric(inputtxt) {
            var TCode = document.getElementById('cname').value;
            if (/[^a-zA-Z ]/.test(TCode)) {
                document.getElementById("cname").value = TCode.replace(/\d+/g, '');
                toastr.error('Input is not alphanumeric \n Enter Characters only between A to Z or a to z');
                return false;
            }
            return true;
        }

    </script>
	
		<header>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a href="http://dev.vcqru.com"><img alt="VCQRU" width="220" data-sticky-width="160" src="./image/logo-1.png" class="logo_size">
										</a>
  <div class="buy-tickets mobile">
										<%--<a data-toggle="modal" data-target="#checkcode" class="custom-check-code-btn-style btn btn-primary custom-headder-btn-css-style custom-border-radius custom-btn-style-1 text-3 font-weight-bold text-color-light text-uppercase outline-none ml-4">Check Code</a>--%>
                                        <a href="CodeCheck.aspx" class="custom-check-code-btn-style btn btn-primary custom-headder-btn-css-style custom-border-radius custom-btn-style-1 text-3 font-weight-bold text-color-light text-uppercase outline-none ml-4">Check Code</a>
									</div>
									
									 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <i class="fas fa-bars"></i>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav ml-auto">
      <li class="nav-item active">
        <a class="nav-link" href="http://dev.vcqru.com">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#about">About Us</a>
      </li>
	  
	   <li class="nav-item">
        <a class="nav-link" href="#services">Services</a>
      </li>
	  
													<li class="dropdown dropdown-mega " >
													<a class="dropdown-item dropdown-toggle" href="#">
														Domains
													</a>
													<ul class="dropdown-menu">
														<div class="dropdown-mega-content">
															<div class="row">
																<div class="col-lg-6 dropdown-mega-sub-nav-border">
																	<ul class="dropdown-mega-sub-nav line_height">
																		<li>
																			<a class="dropdown-item" href="pharmaceutical-industry.html">
																				<img src="image/1.png" class="menu-image-style" width="25"> Pharmaceutical Industry
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="electronics-appliances.html">
																				<img src="image/2.png" class="menu-image-style" width="25"> Electrical and Electronics Appliances
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="fashion-clothes-usecase.html">
																				<img src="image/3.png" class="menu-image-style" width="25"> Fashion Clothing
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="fashion-shoes.html">
																				<img src="image/4.png" class="menu-image-style" width="25"> Fashion Shoes
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="cosmetics.html">
																				<img src="image/5.png" class="menu-image-style" width="25"> Cosmetics
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="wine.html">
																				<img src="image/6.png" class="menu-image-style" width="25"> Wine and Spirits
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="cannabis.html">
																				<img src="image/7.png" class="menu-image-style" width="25"> Cannabis
																			</a>
																		</li>
																	</ul>
																</div>
																<div class="col-lg-6">
																	<ul class="dropdown-mega-sub-nav"  >
																		<li>
																			<a class="dropdown-item" href="Custom-Solution-For-Indian-Pharma.html">
																				<img src="image/8.png" class="menu-image-style" width="25"> Custom Solution For Indian Pharma
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="water-purifiers.html">
																				<img src="image/9.png" class="menu-image-style" width="25"> Water Purifiers
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="toys.html">
																				<img src="image/10.png" class="menu-image-style" width="25"> Toys
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="electronics-accessories.html">
																				<img src="image/11.png" class="menu-image-style" width="25"> Electronics Accessories
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="jewellery.html">
																				<img src="image/12.png" class="menu-image-style" width="25"> Jewelry
																			</a>
																		</li>
																		<li>
																			<a class="dropdown-item" href="autoparts.html">
																				<img src="image/13.png" class="menu-image-style" width="25"> Auto Parts
																			</a>
																		</li>
																	</ul>
																</div>
															</div>
														</div>
													</ul>
												</li>
	    <li class="nav-item">
        <a class="nav-link" href="#">Blockchain</a>
      </li>
      
	  <li class="nav-item">
        <a class="nav-link " href="#about">Vidoe</a>
      </li>
      <li class="nav-item">
        <a class="nav-link " href="contact.aspx">Contact Us</a>
      </li>
	  <li class="nav-item">
        <a class="nav-link " href="#login_section">Login/Signup</a>
      </li>
	 
    </ul>
   
  </div>
  <div class="buy-tickets tab">
										<%--<a data-toggle="modal" data-target="#checkcode" class="custom-check-code-btn-style btn btn-primary custom-headder-btn-css-style custom-border-radius custom-btn-style-1 text-3 font-weight-bold text-color-light text-uppercase outline-none ml-4">Check Code</a>--%>
                                        <a href="CodeCheck.aspx" class="custom-check-code-btn-style btn btn-primary custom-headder-btn-css-style custom-border-radius custom-btn-style-1 text-3 font-weight-bold text-color-light text-uppercase outline-none ml-4">Check Code</a>
									</div>
  
</nav>


</header>
<div role="main" class="main">
				<section class="page-header page-header-modern page-header-background page-header-background-md overlay overlay-color-dark overlay-show overlay-op-7" style="background-image: url(img/page-header/page-header-about-us.jpg);">
					<div class="container">
						<div class="row mt-5">
							<div class="col-md-12 align-self-center p-static order-2 text-center">
								<h1 class="text-9 font-weight-bold">Services</h1>
							</div>
							<div class="col-md-12 align-self-center order-1">
								<ul class="breadcrumb breadcrumb-light d-block text-center">
									<li><a href="#">Home</a></li>
									<li class="active">Services</li>
								</ul>
							</div>
						</div>
					</div>
				</section>

				<div class="container">

					<div class="row pt-sm">
						<div class="col-md-3">
							<aside class="sidebar" id="sidebar" data-plugin-sticky data-plugin-options='{"minWidth": 991, "containerSelector": ".container", "padding": {"top": 110}}'>

								<ul class="nav nav-list mb-xl show-bg-active" style="display: block;">
									<li><a data-hash data-hash-offset="110" href="#counterfeit">Counterfeit</a></li>
									<li><a data-hash data-hash-offset="110" href="#referral_service">Referral Service</a></li>
									<li><a data-hash data-hash-offset="110" href="#build_loyalty">Build Loyalty</a></li>
									<li><a data-hash data-hash-offset="110" href="#run_survey">Run Survey</a></li>
									<li><a data-hash data-hash-offset="110" href="#gift_coupon">Gift Coupon</a></li>
									<li><a data-hash data-hash-offset="110" href="#raffle">Raffle</a></li>
									<li><a data-hash data-hash-offset="110" href="#big_data_analysis">Big Data Analysis</a></li>
									<li><a data-hash data-hash-offset="110" href="#customised_solution">Customised Solution</a></li>
									<li><a data-hash data-hash-offset="110" href="#cash_transfer">Cash Transfer</a></li>
									<li><a data-hash data-hash-offset="110" href="#e_warranty">E-Warranty</a></li>
									<li><a data-hash data-hash-offset="110" href="#secure_track">Secure Track & Trace</a></li>
								</ul>

							</aside>
						</div>
						<div class="col-md-9">

							<section id="counterfeit" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Check Product Originality-COUNTERFEIT</h2>
								<p>Counterfiet means replicating the original product by unauthorised means to take the price advantage of the original product.</p>
								<p>According to the report of European Union Intellectual Property Office (EUIPO), piracy in consumer products has costed companies loss of €338 billion in 2017 and is expected to increase by 32% this year.</p>
								<p>It is not merely financial loss but due to duplicacy in medicines and food products, it may pose severe health issues which are threat to the life.</p>
								<p>Every person has the right to know whether the product they are buying is genuine or not. We use truly secure and encypted codes printed on the labels of the product which are impossible to replicate.</p>
								<p>With the help of secure mobile/web tools, the authenticity of the product can be checked.</p>
								<p>The problem of counterfieting is affecting almost every sector from consumer and luxury goods through pharma, automotive and defence.</p>
								<p>Globally, counterfeiting has become a serious threat. It hamper the reputation of the brand, pose real danger to the health and safety of consumers, and reduce the profitablity of the company.</p>
								<p>Counterfiet means replicating the original product by unauthorised means to take the price advantage of the original product.</p>
							</section>

							<hr class="solid tall">
							
							<section id="referral_service" class="mb-xlg">

								<h2 class="mb-none text-color-dark">User Benifits-REFERRAL SERVICE</h2>
								<p>Referral schemes are in limelight recently and for good reasons as one in a four person buys through recomendation and the referred customers have 43% higher retention rate.</p>
								<p>Word of mouth is the prime factor behind 25%-45% of all buying decisions as people trust and value the recomendation. A positive, low cost and effective tool for immediate sales boost. It can spark the sales exponentialy when partnered with efective marketing program.</p>
								<p>How it can help:</p>
								<p>It saves your marketing budget.</p>
								<p>It helps in automated lead generation through your existing clientele.</p>
								<p>It offers higher conversion rate.</p>
								<p>It shows customer's loyalty as to what extent your customers liked your product.</p>
								<p>It is one of the largest contributor in building brand awareness.</p>
								<p>It is a simple way to thank your customer who liked your product.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="build_loyalty" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Loss Of Customers-BUILD LOYALTY</h2>
								<p>Building customer loyalty is more art than a strategy. In today's world where your competitors are just an inch away from your business, you can achieve visible growth through building loyalty.</p>
								<p>Study shows that loyalty is 30-45% more effective and economical approach to acquire new customers. Nowadays businesses are highly dependent on satisfied customers.</p>
								<p>Customer retention is the biggest challenge in the market today and to achieve this, there should be the right value mix in your product.</p>
								<p>How can you achieve this:</p>
								<p>Don't neglect customers</p>
								<p>Exceed customer expectations</p>
								<p>Personalisation helps to biuld strong relationship with the customer</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="run_survey" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Uncertain Market Condition-RUN SURVEY</h2>
								<p>The market trends are continuously changing and in order to cope up with this change, market surveys on regular basis can be of great help. Whether it’s a new product launch or expansion of your product range in the market, understanding of consumer feedback is extremely important</p>
								<p>Market surveys are an important part of market research that measures the feelings and preferences of customers in a given market. Varying greatly in size, design, and purpose, market surveys are one of the main pieces of data that companies use in determining what products and services to offer and how to market them.</p>
								<p>How it can help you:</p>
								<p>Identification of potential buyers- Understanding who your customers are, will enable you to target the right market effectively.</p>
								<p>Feedback from existing customers- With growing competition, it is the need of business nowadays to know the feedback about your product in order to develop new business strategies.</p>
								<p>Business expansion plans- Surveys helps to identify the areas of possible business expansion.</p>
								<p>Product range- It helps to discover new and unexplored markets that pave the way for business growth.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="gift_coupon" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Inefficient Customer Reward Schemes-GIFT COUPON</h2>
								<p>Irrespective of the market segment, gift coupon is a clever tool to boost the sales. Gift coupons are always appealing and a great way to expand your brand reach. It is not just that you get a customer visit but also capture his/her buying pattern that can be used to design new marketing campaigns.</p>
								<p>Benefits to the company</p>
								<p>Boost sales- It is just in option to the customer as to why buy your product.</p>
								<p>Personalization- Every gift coupon speaks itself and it is a great way to say that you care.</p>
								<p>Build loyalty- To redeem a gift coupon, customer will revisit your store/web portal.</p>
								<p>Slippage- Cash is never reimbursed to the customers who do not redeem their gift coupons to the full value or expiry date.</p>
								<p>Benefits to the customer</p>
								<p>Flexibility of selection- Rather than spending time to select gift for your loved ones, gift coupons offers flexibility of product selection.</p>
								<p>Continence- As it can be redeemed at any participating store, gift coupons offers great continence.</p>
								<p>Control on spending- Its on the customer whether to use the gift coupon to its full or partial value.</p>
							</section>
                            
							<hr class="solid tall">
							
							<section id="raffle" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Inefficient Random Sampling For Prizing - Raffle</h2>
								<p>A raffle scheme involves different possible prizes that can be won through a draw from the group at random. A good raffle scheme can be like a cherry on the cake as reward for a customer. Raffles have been a powerful marketing tool even before the launch of digital marketing.</p>
								<p>Our team help you choose your target set of customers and design an effective raffle scheme which will not only boost your sales but at the same time build an effective customer base which can be used later for newsletters or email drops.</p>
								<p>It can be a physical card or a scratch code on the product packaging, your customers can participate in your raffle scheme through sms,web or mobile application.</p>
								<p>Benifits - </p>
								<p>Mass Exposure- An effective raffle scheme provides visiblity of your brand among millions of customers.
                                   Increased Awareness- It dramatically increases your brand awareness both locally or elsewhere.
                                   Speedy Promotion- Raffle scheme catches eyeballs in a much faster way.
                                   Database- Raffle scheme helps you create an effective customer databse which can be used later for business planning.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="big_data_analysis" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Unknown Trend /Pattern Change-BIG DATA ANALYSIS</h2>
								<p>We are living in the age of technology. Nowadays with the usage of internet you could easily learn how to make a motorbike or even how to fly an airplane.</p>
								<p>Without data analysis a company is blind and deaf. With the increase in the use of internet and technology, companies are trying to use this information for maximising their revenues.</p>
								<p>Data analysis gives you an insight to customer buying pattern. It helps to explore new business opportunities and it is one important thing that can keep your business in the top space.</p>
								<p>Data can be used to discover business activities and develop efective marketing strategies.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="customised_solution" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Inefficient discount system-CUSTOMISED SOLUTION</h2>
								<p>With our team of Printing and IT experts, you do not only need to rely on the pre-determined services but we continously work to help you with customized solutions to meet your unique and specific product authentification and counterfiet protection needs.</p>
								<p>Let us help you with the most appropriate tech enabled solution to meet your requirements.</p>
								<p>Benifits</p>
								<p>Remain focused on your core business- Our team works to improve your core focus area and help to improve your profitablity matrix.</p>
								<p>Leverage advanced technology and skilled personnel- We use truly secure algo codes to shield your brand.</p>
								<p>Iinnovative security technologies- Our solutions can easily be integrated with your existing product labels which make it csot effective.</p>
								<p>Security and much more- We not only provide you security against duplicacy but also provides number of data analysis services which may help you to strategize your business model.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="cash_transfer" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Inefficient Discount System-CASH TRANSFER</h2>
								<p>Its a form of cash incentive offered to customers when they buy certain products and receive cash refund after their purchase.</p>
								<p>Unlike cashback where cutomers are rewarded with points which they can used to buy from a particular vendor or web portal, cash transfer scheme directly credits cash to their virtual wallet or bank account.</p>
								<p>Benifits</p>
								<p>Acquisition of new customers- Its a lucrative scheme which helps you to acquire new customers.
                                   Increase in sales- Products with benifits are fast selling and may boost your sales drastically.
                                   Customer loyalty- Cash transfer can help build customer loyalty as it is a direct saving for the customer.
                                   Informative evaluation- It helps to improve your business statistics.</p>
							</section>
							
							<hr class="solid tall">
							
							<section id="e_warranty" class="mb-xlg">

								<h2 class="mb-none text-color-dark">E-Warranty : Manage warranty and customer support</h2>
								
							</section>
							
							<hr class="solid tall">
							
							<section id="secure_track" class="mb-xlg">

								<h2 class="mb-none text-color-dark">Secure Track & Trace: Distribution Management System</h2>
								
							</section>


						</div>

					</div>

				</div>
			</div>

<!--footer start--->
			<footer id="footer">
				<div class="container">
					<div class="footer-ribbon">
						<span>Get in Touch</span>
					</div>
					<div class="row py-5 my-4">
						<div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
							<h5 class="text-3 mb-3">Online Support</h5>
							<ul class="list list-icons list-icons-lg">
								
								<li class="mb-1"><i class="fab fa-whatsapp text-color-primary"></i><p class="m-0"> <a href="tel:+91-9243029420" class="text-decoration-none font-weight-light footer-two-text"> +91-9243029420</a></p></li>
								<li class="mb-1"><i class="far fa-envelope text-color-primary"></i><p class="m-0"><a href="mailto:info@vcqru.com" class="text-decoration-none font-weight-light footer-two-text">info@vcqru.com</a></p></li>
							</ul>
							<div class="alert alert-danger d-none" id="newsletterError"></div>

						</div>
						<div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
							<h5 class="text-3 mb-3">Links</h5>
							<ul class="list list-icons list-icons-lg footer-lonk-li">
								<li class="mb-0"><i class="far fa-dot-circle text-color-primary"></i> <a href="#" class="text-decoration-none font-weight-light footer-two-text">Terms of service</a><li>
								<li class="mb-0"><i class="far fa-dot-circle text-color-primary"></i> <a href="#" class="text-decoration-none font-weight-light footer-two-text">Privacy policy</a><li>
								<!--li class="mb-0"><i class="far fa-dot-circle text-color-primary"></i> <a href="#" class="text-decoration-none font-weight-light footer-two-text">Contact Icon is reverse</a><li-->
								<!--li class="mb-0"><i class="far fa-dot-circle text-color-primary"></i> <a href="#" class="text-decoration-none font-weight-light footer-two-text">Career</a><li-->
								<li class="mb-0"><i class="far fa-dot-circle text-color-primary"></i> <a href="https://docs.google.com/gview?url=document/Patent.pdf" class="text-decoration-none font-weight-light footer-two-text">Patent</a><li>
							</ul>
						</div>
						<div class="col-md-6 col-lg-3 mb-4 mb-md-0">
							<h5 class="text-3 mb-3">Address</h5>
							<ul class="list list-icons list-icons-lg">
								<li class="mb-1"><i class="far fa-dot-circle text-color-primary"></i><p class="m-0 footer-address-text">219A 2nd Floor Unitech Arcadia
									South City II, Sector 49, Gurugram, Haryana 122018
									Owned by Accomplish Trades Pvt. Ltd</p></li>
							</ul>
							<div class="row">
								<div class="col-md-12">
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7018.091509591924!2d77.04690722333005!3d28.417876216049315!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d229b56d6b74f%3A0x5cad26a539a04ab5!2sSouth+City+II%2C+Sector+49%2C+Gurugram%2C+Haryana+122018!5e0!3m2!1sen!2sin!4v1556789803032!5m2!1sen!2sin" width="100%" height="Auto" frameborder="0" style="border:0" allowfullscreen></iframe>
								</div>
							</div>
						</div>
						<div class="col-md-6 col-lg-2">
							<h5 class="text-3 mb-3">FOLLOW US</h5>
							<ul class="header-social-icons social-icons">
								<li class="social-icons-facebook"><a href="https://www.facebook.com/vcqru/" target="_blank" title="Facebook"><i class="fab fa-facebook-f"></i></a></li>
								<li class="social-icons-twitter"><a href="https://twitter.com/WeVcqru" target="_blank" title="Twitter"><i class="fab fa-twitter"></i></a></li>
								<li class="social-icons-instagram"><a href="https://www.instagram.com/vcqru_wesecureyou/" target="_blank" title="Instagram"><i class="fab fa-instagram"></i></a></li>
								<li class="social-icons-youtube"><a href=" https://www.youtube.com/channel/UCwwA3hOaxs3o-CXCFpD8ZWg?" target="_blank" title="Youtube"><i class="fab fa-youtube"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="footer-copyright">
					<div class="container py-2">
						<div class="row py-4">
							<div class="col-lg-1 d-flex align-items-center justify-content-center justify-content-lg-start mb-2 mb-lg-0">
								<a href="index.html" class="logo">
                                </a>
							</div>
							<div class="col-lg-7 d-flex align-items-center justify-content-center justify-content-lg-start mb-4 mb-lg-0">
								<p>? Copyright 2019. All Rights Reserved.</p>
							</div>
							<div class="col-lg-4 d-flex align-items-center justify-content-center justify-content-lg-end">
								<nav id="sub-menu">
									<ul>
										<li><i class="fas fa-angle-right"></i><a href="document/FAQ_Manuf_Consumer.docx" class="ml-1 text-decoration-none"> FAQ's</a></li>
										<li><i class="fas fa-angle-right"></i><a href="sitemap.html" class="ml-1 text-decoration-none"> Sitemap</a></li>
										<li><i class="fas fa-angle-right"></i><a href="contact-us.html" class="ml-1 text-decoration-none"> Contact Us</a></li>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</footer>
		</div>