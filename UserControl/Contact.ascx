<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Contact.ascx.cs" Inherits="UserControl_Contact" %>
 
<script src="vendor/jquery/jquery.min.js"></script>
 <script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>
<script src="../Content/js/toastr.min.js"></script>    
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $("#aspnetForm").on("submit", function () {
            return false;
        });

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

                                        location.href = "Thanks.aspx";
                                    },
                                    error: function (data) {
                                        //$('#progress').hide();
                                        //$('#cname').val('');
                                        //$('#cemail').val('');
                                        //$('#ccomment').val('');
                                        //$('#cmobile').val('');
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
<div role="main" class="main">
			
			<section class="theme-bg-default-light login-section p-0" style="background:url(assets//images/background/contact-us.jpg); background-size:cover; background-position: center center">
                  
				
				<div class="container container-max position_index">
                     
					<div class="row justify-content-center align-items-center">
						<div class="col-lg-8">
                            <div class="contact-formBox">
							<div class="overflow-hidden mb-1">
								<h2 class="font-weight-normal text-7 mt-2 mb-0 appear-animation animated maskUp appear-animation-visible text-primary" data-appear-animation="maskUp" data-appear-animation-delay="200" style="animation-delay: 200ms;">Contact Us</h2>
							</div>
							<div class="overflow-hidden mb-4 pb-3">
								<p class="mb-0 appear-animation animated maskUp appear-animation-visible" data-appear-animation="maskUp" data-appear-animation-delay="400" style="animation-delay: 400ms;">Feel free to ask for details, don't save any questions!</p>
							</div>

							<form id="contactForm" class="contact-form appear-animation animated fadeIn appear-animation-visible" action="php/contact-form.php" method="POST" data-appear-animation="fadeIn" data-appear-animation-delay="600" style="animation-delay: 600ms;">
								<div class="contact-form-success alert alert-success d-none mt-4" id="contactSuccess">
									<strong>Success!</strong> Your message has been sent to us.
								</div>

								<div class="contact-form-error alert alert-danger d-none mt-4" id="contactError">
									<strong>Error!</strong> There was an error sending your message.
									<span class="mail-error-message text-1 d-block" id="mailErrorMessage"></span>
								</div>
								
								<div class="form-row">
									<div class="form-group col-lg-6">
										<label class="required font-weight-bold text-dark">Full Name</label>
										<input type="text" id="cname" placeholder="name" onkeyup="alphanumeric(this);" data-msg-required="Please enter your name." maxlength="50" class="form-control">
									</div>
									<div class="form-group col-lg-6">
										<label class="required font-weight-bold text-dark">Email Address</label>
										<input type="email" id="cemail" placeholder="email" onfocus="this.value = '';" name="email" data-msg-required="Please enter your email." maxlength="50" class="form-control">
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col">
										<label class="font-weight-bold text-dark">Mobile no</label>
										<input type="text" id="cmobile" placeholder="mobile No" onfocus="this.value = '';" data-msg-required="Please enter mobile no." maxlength="13" class="form-control">
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col">
										<label class="required font-weight-bold text-dark">Message</label>
										<textarea maxlength="5000" placeholder="message *" onfocus="this.value = '';" onblur="if (this.value == '')" data-msg-required="Please enter your message." rows="4" class="form-control" name="message" id="ccomment"></textarea>
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col">
										<button onclick="sendcquery();" class="btn btn-primary btn-modern" data-loading-text="Loading...">Submit</button>
									</div>
								</div>
							</form>
							
									<div class="overflow-hidden mb-4 pb-3">
								<p class="mb-0 appear-animation animated maskUp appear-animation-visible" data-appear-animation="maskUp" data-appear-animation-delay="400" style="animation-delay: 400ms; font-size:14px;">*Once you submit the details our representative will contact you shortly.</p>
							</div>
							
							
                                </div>
								
							
							
								
								
								
						</div>
						<div class="col-lg-4">

							<div class="appear-animation animated fadeIn appear-animation-visible" data-appear-animation="fadeIn" data-appear-animation-delay="800" style="animation-delay: 800ms;">
								<h4 class="mt-2 mb-1">Our Office</h4>
                                <div class="contact-detail">
								<ul class="mt-2">
									<li><i class="mdi mdi-map-marker top-6"></i>
                                        <p><strong>Address:</strong> DLF Corporate Greens,<br /> Tower 4, 15th Floor, Unit no. 1502-1503,<br /> Southern Peripheral Road, Sector 74 A,<br /> Gurugram, Haryana 122004.</p>

									</li>
									<li>
                                        <i class="mdi mdi-phone top-6" style="transform: rotate(108deg);"></i> 
                                        <p><strong>Phone:</strong><a href="tel:+91 124 5181074">+91 124 5181074</a></p>

									</li>
									<li>
                                        <i class="mdi mdi-email top-6"></i> 
                                        <p><strong>Email:</strong> <a href="mailto:sales@vcqru.com">sales@vcqru.com</a></p>

									</li>
								</ul>
                                </div>
							</div>
							
							

						</div>

					</div>

				</div>
                <div class="ovelay"></div>
                </section>
			</div>
    	<section class="section-center section-no-border section-light" style="display:none">
     <div class="container">
						<div class="row justify-content-center" id="register">
                            <div class="col-md-6 mt-3 text-left text-white" >
                                <br />
                                <br />
                                <h3>Contact Us</h3>
								<hr />
                                <div class="form-row">
										<div class="form-group col-lg-6">
                                           
                                                ADDRESS :
                                             <hr />
                                            <p>219A 2nd Floor Unitech Arcadia <br /> South City II, Sector 49, Gurugram, Haryana 122018</p>
                                            
										</div>
										<div class="form-group col-lg-6">
											 EMAIL :
                                             <hr />
                                            <p><a href="malito:sales@vcqru.com">sales@vcqru.com</a></p>
										</div>
									</div>
                                  <%--<div class="form-row">
										<div class="form-group col-lg-6">
                                             
										</div>
										<div class="form-group col-lg-6">
											 
										</div>
									</div>--%>
                               
                                 <div class="form-row">
										<div class="form-group col-lg-6">
                                            
                                                PHONE :                                            
                                             <hr />
                                            <p>Phone : 0124-4001928</p>
                                            <p>Mobile : +91-9667834971</p>
										</div>
										<div class="form-group col-lg-6">
											SOCIAL MEDIA
                                             <hr />
                                             <ul class="contact_social">
                                        <li><a href="https://www.facebook.com/vcqru" target="_blank"><i class="fb"></i></a></li>
                                        <li><a href="https://twitter.com/vcqru?lang=en" target="_blank"><i class="tw"></i></a></li>
                                       <%-- <li><a href="javascript:;"><i class="google" target="_blank"></i></a></li>
                                        <li><a href="https://www.youtube.com/embed/TRCr6sThrqI" target="_blank"><i class="utube"></i></a></li>--%>
                                        <li><a href="https://www.linkedin.com/company/9230775/admin/updates/" target="_blank"><i class="linkedin"></i></a></li>
                                                    </ul>  
										</div>
									</div>
                                  <%--<div class="form-row">
										<div class="form-group col-lg-6">
                                            
										</div>
                                      
										<div class="form-group col-lg-6">
											  
                                         
										</div>
									</div>--%>
                                </div>
                            

                            <div class="col-md-6 mt-3 text-left">
                                
                                  <br />
                                <br />
                                <h3 class="mb-0 mt-2">CONTACT FORM</h3>
                                <hr />
                              <%--  <input type="text" class="text" id="cname" placeholder="Name" onkeyup='alphanumeric(this);' />
                    <input type="text" class="text" id="cemail" placeholder="Email" onfocus="this.value = '';"  />
                    <input type="text" class="text" id="cmobile" placeholder="Mobile No"  onfocus="this.value = '';"  />
               
                    <textarea placeholder="Comment" id="ccomment" ></textarea>
                    <input type="submit" value="Submit" onclick="return sendcquery();"  />--%>

                                <div class="form-row">
                                    <div class="form-group col text-white">
                                        Name*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="cname" placeholder="name" onkeyup='alphanumeric(this);' 
                                            data-msg-required="Please enter your name." maxlength="50" class="form-control"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Email*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" id="cemail" placeholder="email" onfocus="this.value = '';" 
                                             name="email" data-msg-required="Please enter your email." maxlength="50" class="form-control"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Mobile No.*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="cmobile" placeholder="mobile No"  onfocus="this.value = '';" 
                                             placeholder="mobile no" data-msg-required="Please enter mobile no." maxlength="13" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Comment*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <textarea maxlength="5000" placeholder="message *" onfocus="this.value = '';" onblur="if (this.value == '')"
                                             data-msg-required="Please enter your message." 
                                            rows="4" class="form-control" name="message" id="ccomment" ></textarea>
                                       
                                    </div>
                                </div>                              
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="submit" value="Submit" onclick="return sendcquery();"  class="btn btn-primary btn-lg" data-loading-text="Loading..." />
                                    </div>
                                </div>

                            </div>
                          
                            </div>
        </div>

</section>


   
   