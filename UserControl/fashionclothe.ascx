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
	<!--header ended--->
	<div role="main" class="main">
			<section>
				<div class="container">
					<div class="row">
					<div class="col-md-12 text-center pt-5 pb-3">
						<h1><strong>Anti-Counterfeit Solution for Water Purifier and RO Brands</strong></h1>
					</div>
					</div>
				</div>
				<div class="container ">
					<img src="image/water-purifier.jpg" style=" padding-botton:5px;" class="img-fluid">
				</div>
			</section>
				<div class="container">
					<div class="row mt-5 pt-5">
						<div class="col-md-6">
						<img src="image/water-purifie-1.png" class="img-fluid ">
					</div>
								<div class="col-md-6">
									<div class="col-md-12 mt-4 appear-animation" data-appear-animation="fadeInLeftShorter" data-appear-animation-delay="800">
										<h3 class="font-weight-bold text-4 mb-4">Protect Your Brand</h3>
										<p>No more counterfeits!</p>
									
											<p><i class="fa fa-check text-success pr-2"></i>World’s most effective anti-counterfeit tags backed by patent-pending technology and AI</p>
											<hr>
											<p><i class="fa fa-check text-success pr-2"></i>Prevents and Demotivates imitators to sell fakes under your brand</p>
											<hr>
											<p><i class="fa fa-check text-success pr-2"></i>24x7 monitoring for anomaly signals</p>
											<hr>
										
									</div>
								</div>
							</div>
						</div>	
					</div>
				</div>
						<!---section of only img is start here--->
							
						
						<!---section Mathematically is start--->
				<section style="background-color:#eef1f5; ">
					<div class="container mt-5 pt-5">
						<div class="row">
							<div class="featured-boxes featured-boxes-style-2">
								<div class="row">
									<div class="col-md-6 col-lg-4 appear-animation" data-appear-animation="fadeInRightShorter" data-appear-animation-delay="700">
										<div class="featured-box featured-box-effect-4">
											<div class="box-content">
												<i class="icon-featured icon-screen-tablet icons text-color-primary bg-color-grey"></i>
												<h4 class="font-weight-bold">Geo-location based Product Pages </h4>
												<p class="px-3">Showcase different landing page based on user’s location</p>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 appear-animation" data-appear-animation="fadeInRightShorter" data-appear-animation-delay="900">
										<div class="featured-box featured-box-effect-4">
											<div class="box-content">
												<i class="icon-featured icon-layers icons text-color-light bg-color-primary"></i>
												<h4 class="font-weight-bold">Impulsive decision making influence</h4>
												<p class="px-3">Influence buyers during decision making time</p>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 appear-animation" data-appear-animation="fadeInRightShorter" data-appear-animation-delay="1100">
										<div class="featured-box featured-box-effect-4">
											<div class="box-content">
												<i class="icon-featured icon-magnifier icons text-color-primary bg-color-grey"></i>
												<h4 class="font-weight-bold">Right message, right moment!</h4>
												<p class="px-3">Let your best marketing ads be seen when it matters the most</p>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 appear-animation" data-appear-animation="fadeInLeftShorter" data-appear-animation-delay="1500">
										<div class="featured-box featured-box-effect-4">
											<div class="box-content">
												<i class="icon-featured icon-screen-desktop icons text-color-light bg-color-primary"></i>
												<h4 class="font-weight-bold">Product proposition</h4>
												<p class="px-3">Let your products tell their stories and benefits</p>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-lg-4 appear-animation" data-appear-animation="fadeInLeftShorter" data-appear-animation-delay="1300">
										<div class="featured-box featured-box-effect-4">
											<div class="box-content">
												<i class="icon-featured icon-doc icons text-color-primary bg-color-grey"></i>
												<h4 class="font-weight-bold">Brand socialization</h4>
												<p class="px-3">Increase social media influence and ratings for your products</p>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</section>
						<!-- section Mathematically is closed--->
						
				<!--last section start--->
	<section>
		<div class="container mt-5 ">
            <div class="row mb-5">
                <div class="col-md-12 mt-5 text-center">
                    <h4 class="mb-2 mt-0  text-dark"><strong>Warranty Management</strong></h4>
                
                    <!--img src="image/line.png"  class="pt-4 mt-0 pb-5"/-->
                </div>
            </div>
            <div class="row mb-lg-4">
                <div class="col-lg-5 appear-animation" data-appear-animation="fadeInLeftShorter" data-appear-animation-delay="300">
                    <img src="image/water-purifie.png" class="img-fluid" style="width: 80% !important;">
                </div>
                <div class="col-lg-7 appear-animation" data-appear-animation="fadeInLeftShorter" data-appear-animation-delay="300">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_20.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">One-click warranty registration with mobile</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_21.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Increase revenue - One-click Warranty Renewal with online payments</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_22.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Eliminate the chances of wrong charges from the distributor by providing a platform for warranty renewal to the customers directly</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_23.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Make a personal and trackable connection with your customer</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_24.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Enable feedback and one-click support - increases TRUST</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_25.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Reach out to buyers with new upgrades and offers</p>
                        </div>
                    </div>
                    <hr class="mt-2">
                    <div class="feature-box feature-box-style-2">
                        <div class="feature-box-icon">
                            <img class="feature-image-style-1" src="image/icon_list_26.png">
                        </div>
                        <div class="feature-box-info">
                            <p class="">Send reminders to customers to change the consumable parts such as carbon filters</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
				</section>
				<!---last section is closed--->
							
							
			</div>
		</div>
	</div>
		
<section style="background: #eff5fb;">
		<div class="container">
			<div class="row pt-5 pb-3">
				<div class="col-md-12 text-center pt-3">
					<div class="buy-tickets">
						<a data-toggle="modal" data-target="#checkcode" class="custom-check-code-btn-style btn btn-primary custom-headder-btn-css-style custom-border-radius custom-btn-style-1 text-3 font-weight-bold text-color-light text-uppercase outline-none ml-4">Request A Demo</a>
					</div>
				</div>
			</div>
			<div class="row pt-5 pb-5 padding_lft">
				<div class="pr-4 pl-2" >
					<p style="font-size:12px;"><i class="fa fa-check text-success pr-2" ></i>Digital Anti-Counterfeit Solution</p>
				</div>
				
				<div class="pr-4"  >
					<p style="font-size:12px;"> <i class="fa fa-check text-success pr-2"></i>Track and Trace Solutions</p>
				</div>
				
				<div class="pr-4" >
					<p style="font-size:12px;"><i class="fa fa-check text-success pr-2"></i>Data Collection and BI</p>
				</div>
				
				<div class="pr-4"  >
					<p style="font-size:12px;"><i class="fa fa-check text-success pr-2"></i>Digital Consumer Engagement</p>
				</div>
			
				<div class="pr-4" >
					<p style="font-size:12px;"><i class="fa fa-check text-success pr-2"></i>Loyalty Program</p>
				</div>
			
				<div class="" >
					<p style="font-size:12px;"><i class="fa fa-check text-success pr-2"></i>eCommerce Program</p>
				</div>
			</div>
		</div>
	</section>
	
 
 <!---footer ended--->
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
                                    <img alt="Bhanguz " style="width:100%" class="img-responsive" src="https://www.bhanguz.com/img/logos/logo.png">
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
