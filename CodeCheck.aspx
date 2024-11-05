<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CodeCheck.aspx.cs" Inherits="CodeCheck" %>

<%@ Register Src="~/UserControl/CheckYourCodes.ascx" TagPrefix="uc1" TagName="CheckYourCodes" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>VCQRU | We Secure You</title>
    <meta name="keywords" content="HTML5 Template" />
    <meta name="description" content="Porto - Responsive HTML5 Template" />
    <link rel="canonical" href="https://www.vcqru.com/CodeCheck.aspx"/>
    <meta name="author" content="okler.net" />
    <!-- Favicon -->
    <link rel="shortcut icon" href="image/fave-icon.png" type="image/x-icon" />
    <link rel="apple-touch-icon" href="image/fave-icon.png" />
    <!-- Mobile Metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, shrink-to-fit=no" />
    <!-- Web Fonts  -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light%7CPlayfair+Display:400" rel="stylesheet" type="text/css" />
    <!-- Vendor CSS -->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="vendor/fontawesome-free/css/all.min.css" />
    <link rel="stylesheet" href="vendor/animate/animate.min.css" />
    <link rel="stylesheet" href="vendor/simple-line-icons/css/simple-line-icons.min.css" />
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="vendor/owl.carousel/assets/owl.theme.default.min.css" />
    <link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.min.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css" />
    <link rel="stylesheet" href="css/theme-elements.css" />
    <link rel="stylesheet" href="css/theme-blog.css" />
    <link rel="stylesheet" href="css/theme-shop.css" />
    <!-- Current Page CSS -->
    <link rel="stylesheet" href="vendor/rs-plugin/css/settings.css" />
    <link rel="stylesheet" href="vendor/rs-plugin/css/layers.css" />
    <link rel="stylesheet" href="vendor/rs-plugin/css/navigation.css" />
    <link rel="stylesheet" href="vendor/circle-flip-slideshow/css/component.css" />
    <!-- Demo CSS -->
    <!-- Skin CSS -->
    <!--link rel="stylesheet" href="css/skins/skin-corporate-19.css"-->
    <link rel="stylesheet" href="css/skins/default.css" />
    <!-- Theme Custom CSS -->
    <link rel="stylesheet" href="css/custom.css" />
    <!-- Head Libs -->
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />
    <%--<script src="Content/js/jquery.min.js"></script>--%>
    <%--<script src="vendor/jquery/jquery.js"></script>--%>
    <%--<script src="vendor/jquery/jquery.min.js"></script>--%>
    <!-- Add fancyBox main JS and CSS files -->
    <%-- <script src="Content/js/jquery.magnific-popup.js" type="text/javascript"></script>
    <link  href="Content/css/popup.css" rel="stylesheet" type="text/css" />--%>
    <%-- <script src="../Content/js/toastr.min.js"></script>    
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

       
       
    <link href="../Content/css/jquery-confirm.css" rel="stylesheet" />
    <script src="../Content/js/jquery-confirm.js" type="text/javascript"></script>--%>
    <!--<script type="text/javascript"-->
    <%--<script src="../Content/js/jquery-ui.min.js"></script>--%>
</head>
<body>
    <form runat="server">
        <asp:HiddenField ID="hdndate1" runat="server" />
        <asp:HiddenField ID="lat" runat="server" />
        <asp:HiddenField ID="hdnmob" runat="server" />
        <asp:HiddenField ID="long" runat="server" />

    </form>

    <uc1:CheckYourCodes runat="server" ID="CheckYourCodes" />

    <%-- <div  id="checkcode" >
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body custom-modal-body">
				<div class="row text-center">
					<div class="col-md-12">
						<h2 class="check-code-text-headding">Check Your Codes</h2>
						<h4 class="check-code-text-headding2">Verify Your Product Instantly</h4>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						
						
							<div class="form-row">
								<div class="form-group col-md-12">
									<input type="text" placeholder="Code 1" value="" data-msg-required="Please enter your name." maxlength="100" class="form-control form-control-modal" name="name" id="name" required />
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-12">
									<input type="email" placeholder="Code 2" value="" data-msg-required="Please enter your email address." data-msg-email="Please enter a valid email address." maxlength="100" class="form-control form-control-modal" name="email" id="email"required />
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-12">
									<input type="number" placeholder="Mobile Number" value="" data-msg-required="Please enter the mobile number." maxlength="12" class="form-control form-control-modal" name="number" id="number" required />
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-12">
									<input type="text" placeholder="Referral Code" value="" data-msg-required="Please enter the company." maxlength="100" class="form-control form-control-modal" name="company" id="company" required />
								</div>
							</div>
							<div class="row mb-4">
								<div class="col-md-12">
									<input type="submit" value="Submit" class="btn btn-primary btn-modern" data-loading-text="Loading..." />
								</div>
							</div>
						
					</div>
					<div class="col-md-6 custom-padding-modal-stape">
						<div class="row modal-border-right-style">
							<div class="col-md-12 text-center">
								<img src="./image/logo-1.png" class="" style="width: 70%;height: auto;" />
							</div>
							<div class="col-md-12">
								<p class="check-code-text-right-side">Step 1: Scratch to reveal the code</p>
								<p class="check-code-text-right-side">Step 2 Input the code & mobile no. and click the “Verify” button</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			
	</div>
</div>
        </div>--%>

    <%--Modal TO SHOW AFTER CHECK YOUR CODES--%>
    <div class="modal fade" id="smallModal" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
        <div class="modal-dialog modal-sm">
            <div class="modal-content" style="width: 200%;">
                <div class="modal-header">
                    <h4 class="modal-title" id="smallModalLabel">Code Check Result (VCQRU)</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p class="about-section-text1">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque neque eget diam posuere porta. Quisque ut nulla at nunc vehicula lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus.</p>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<script type="text/javascript">
    $.noConflict();
    debugger;
    $('#purchasedate').on('change', function () {
        $('#purhase_label').hide();
    });

    var getPosition = function (options) {
        return new Promise(function (resolve, reject) {
            navigator.geolocation.getCurrentPosition(resolve, reject, options);
        });
    }

    var queryString;
    $(document).ready(function () {
        debugger;
        $("#codeone").mask("99999-99999999");
        queryString = location.search.substring(1);
        //if (navigator.geolocation) {
        //    navigator.geolocation.getCurrentPosition(showPosition);

        //} else {
        //    // x.innerHTML = "Geolocation is not supported by this browser.";
        //}
        $('#warratyHeading').hide();
        firstfunction();

    });

    async function firstfunction() {
        debugger;
        if (navigator.geolocation) {
            await getPosition()
                .then((position) => {
                    $('#lat').val(position.coords.latitude);
                    $('#long').val(position.coords.longitude);
                })
                .catch((err) => {
                    console.error(err.message);
                });
        } else {
            // x.innerHTML = "Geolocation is not supported by this browser.";
        }

        if (queryString.length > 0) {
            var keyEncrypt = queryString.split('=');
            var rquestpage_Dcrypt = keyEncrypt[1];
            if (keyEncrypt[0] == "codeone") {
                $("#codeone").val(rquestpage_Dcrypt);
                debugger;
                if ($('#checkcode0').css('display') == "block") {
                    if ($(".input1").val().length == 14) {
                        $('#checkcode').show();
                        $('#checkcode0').hide();
                        $('.step2').addClass('active');

                        $('#checkcode').removeClass('checkcode5');
                        $('#checkcode').addClass('checkcode');
                        $('#checkcodein').removeClass('col-md-5');
                        $('#checkcodein').addClass('col-md-12');

                        $('#checkcode1').removeClass('checkcode5');
                        $('#checkcode1').addClass('checkcode');
                        $('#checkcode1in').removeClass('col-md-5');
                        $('#checkcode1in').addClass('col-md-12');

                        var lat = $('#lat').val();
                        var long = $('#long').val();

                        $.ajax({
                            type: "POST",
                            async: true,
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                            success: function (data) {

                                debugger;
                                if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                    $('#chkGun').hide();
                                    $('#warrentyauto').show();
                                    $('#warratyHeading').show();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jphcounter').hide();
                                    $('#msg').html(data.split('&')[3].toString());
                                    $('#jpc').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[0] === "2" && data.split('&')[1] === "Auto Max India") {
                                    $('#chkGun').hide();
                                    $('#jphcounter').hide();
                                    $('#warrentyauto').show();
                                    $('#warratyHeading').show();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[0] === "0" && data.split('&')[1] === "JPH Publications Pvt. Ltd") {
                                    $('#chkGun').hide();
                                    $('#jphcounter').show();
                                    $('#warratyHeading').show();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    //$('#msg').html(data.split('&')[3].toString());

                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[0] === "0" && data.split('&')[1] === "JOHNSON PAINTS CO.") {
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#skydecore').hide();
                                    $('#jphcounter').hide();
                                    $('#jpc').show();
                                    $('#warratyHeading').show();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    compInformation = data.split('&')[1];
                                    //$('#msg').html(data.split('&')[3].toString());

                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[0] === "0" && data.split('&')[1] === "OSR IMPEX") {
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide();
                                    $('#skydecore').hide();
                                    $('#jphcounter').show();
                                    $('#warratyHeading').show();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jph').hide();
                                    //$('#msg').html(data.split('&')[3].toString());

                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[1] === "SKYDECOR LAMINATES PRIVATE LIMITED") {
                                    //$('#chkGun').hide();
                                    //$('#Coatsbathfitting').hide();
                                    //compInformation = data.split('&')[1];
                                    //$('#checkcode').addClass('box-skydecore');
                                    //$('#skydecore').show();
                                    //$('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#jpc').hide();
                                    //$('#checkcode').show();
                                    //$('#checkcode2').hide();
                                    //$('#divCompany').hide();
                                    //$('#jphcounter').hide();
                                    //$('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    //$("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                    $('#sky_images').show();
                                    $('#coats_images').hide();
                                    $('#pro_info').show();
                                    $('#youtube').hide();
                                    $('#skylink').show();
                                    $('#coatslink').hide();
                                    $('#chkGun').hide();
                                    $('#coatsheading').hide();
                                    $('#skyheading').show();
                                    $('#Coatsbathfitting').show();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    $('#check_Array').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[1] === "COATS BATH FITTINGS") {
                                    debugger;
                                    $('#pro_info').show();
                                    $('#nutravel').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#youtube').show();
                                    $('#skylink').hide();
                                    $('#coatslink').show();
                                    $('#coatsheading').show();
                                    $('#skyheading').hide();
                                    $('#chkGun').hide();
                                    $('#sky_images').hide();
                                    $('#coats_images').show();
                                    $('#Coatsbathfitting').show();
                                    $('#check_Array').show();
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[1] === "EVERCROP AGRO SCIENCE") {

                                    $('#pro_info').show();
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').show();
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#divdemo').hide();
                                    $('#everproducts').show();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                                }
                                else if (data.split('&')[1] === "Nutravel Health Care") {

                                    $('#pro_info').show();
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').show();
                                    $('#evercrop').hide();
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#divdemo').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').show();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                                }
                                else if (data.split('&')[1] === "AMULYA AYURVEDA") {

                                    $('#pro_info').show();
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').show();
                                    $('#evercrop').hide();
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#divdemo').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').show();
                                    $('#balckmangoproduct').hide();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                                }


                                else if (data.split('&')[1] === "Black Mango Herbs") {

                                    $('#pro_info').show();
                                    $('#chkGun').hide();
                                    $('#Coatsbathfitting').hide();
                                    $('#nutravel').show();
                                    $('#evercrop').hide();
                                    compInformation = data.split('&')[1];
                                    $('#checkcode').addClass('box-coats');
                                    $('#skydecore').hide();
                                    $('#warrentyauto').hide();
                                    //$('#warratyHeading').show();
                                    //$('#checkcode').show();
                                    $('#warratyHeading').hide();
                                    $('#checkcode').hide();
                                    $('#coats').show();
                                    $('#divdemo').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#jphcounter').hide();
                                    $('#nutraheading').text($('#nutraheading').text() + compInformation);
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#coats_logo").attr("src", data.split('&')[2].toString().replace('~', ''));


                                }
                                else if (data === "Warranty") {
                                    $('#chkGun').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#jphcounter').hide();
                                    $('#warrenty').show();
                                    $('#jpc').hide();

                                }
                                else if (data.split('&')[3] === "MS") {
                                    $('#warrenty').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#chkGun').show();
                                    $('#jpc').hide();
                                }
                                else if (data.split('&')[0] === "2") {
                                    $('#chkGun').hide();
                                    $('#jphcounter').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#warrenty').show();
                                    $('#warratyHeading').show();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();
                                    $('#jpc').hide();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[3] === "MM" && data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                                    //(data === "MM")
                                    $('#chkGun').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#jphcounter').hide();
                                    $('#warrenty').hide();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').show();
                                    $('#jpc').hide();
                                    $('#checkcode1').removeClass('checkcode5');
                                    $('#checkcode1').addClass('checkcode');
                                    $('#checkcode1in').removeClass('col-md-5');
                                    $('#checkcode1in').addClass('col-md-12');

                                    $('#warratyHeading div').css('margin-top', "0px")
                                    compInformation = data.split('&')[1];
                                    $('#warratyHeading').show();
                                    $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                                }
                                else if (data.split('&')[1] === "Competent Electricals India") {
                                    $('#warrenty').hide();
                                    $('#warratyHeading').hide();
                                    $('#jphcounter').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#jpc').hide();
                                    $('#clogo').removeClass('displayNone');
                                    $('#dvyout').removeClass('displayNone');
                                    $('#dvyout1').removeClass('displayNone');
                                    $('#divdem').removeClass('displayNone');
                                    $('#divdem1').removeClass('displayNone');
                                    $('#scrc').removeClass('displayNone');
                                    $('#checkcode').removeClass('checkcode');
                                    $('#checkcode').addClass('checkcode5');
                                    $('#checkcodein').removeClass('col-md-12');
                                    $('#checkcodein').addClass('col-md-5');

                                    $('#checkcode1').removeClass('checkcode');
                                    $('#checkcode1').addClass('checkcode5');
                                    $('#checkcode1in').removeClass('col-md-12');
                                    $('#checkcode1in').addClass('col-md-5');

                                    $('#dvfiltermob').hide();
                                    $('#dvcode1filt').hide();

                                    $('#clogo').show();
                                    $('#dvyout').show();
                                    $('#dvyout1').show();
                                    $('#scrc').show();
                                    $('#divdem').show();
                                    $('#divdem1').show();
                                    $('#chkGun').show();
                                    $('#checkcode').show();
                                    $('#checkcode2').hide();
                                    $('#divCompany').hide();


                                }

                                //else if (data.split('&')[0] === "0" && data.split('&')[1] === "FB Nutrition") {
                                  
                                  

                                //    window.location.href = "codeverify.aspx?ID=FBNutrition&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                                //}
                                //else if (data.split('&')[0] === "0" && data.split('&')[1] === "ROYAL MANUFACTURER") {
                                  

                                //    window.location.href = "codeverify.aspx?ID=ROYALMANUFACTURER&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];
                                //}

                                //else if (data.split('&')[0] === "0" && data.split('&')[1] === "SHRI BALAJI PUBLICATIONS") {



                                //    window.location.href = "balaji.aspx?Pub_Code=shribalaji&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1];

                                //}
                                //else if (data.split('&')[1] === "A TO Z PHARMACEUTICALS") {


                                //    window.location.href = "fharmaceticals.aspx?ID=fharmaceticals&codeone=" + rquestpage_Dcrypt.split('-')[0] + "&codetwo=" + rquestpage_Dcrypt.split('-')[1] + "&Comp=" + data.split('&')[1];

                                //}


                                else if (data.search('This product') != -1) {
                                    $('#p1msg').html(data);
                                    $('#p1msg:contains("can not be guaranteed")').css('color', 'red');
                                    $('#checkcode1').show();
                                    $('#checkcode2').hide();
                                    $('#jpc').hide();
                                }
                                else {
                                    $('#warrenty').hide();
                                    $('#jphcounter').hide();
                                    $('#nutravel').hide();
                                    $('#evercrop').hide();
                                    $('#everproducts').hide();
                                    $('#nutravelproduct').hide();
                                    $('#amulyaproduct').hide();
                                    $('#balckmangoproduct').hide()
                                    $('#chkGun').show();
                                    $('#jpc').hide();
                                    //$('#warrenty').hide();
                                    //$('#warratyHeading').hide();
                                    //$('#chkGun').show();
                                    //$('#checkcode').show();
                                    //$('#checkcode2').hide();
                                    //$('#divCompany').hide();
                                }
                            }
                        });
                    }
                    else {
                        alert('Please enter the 13 digits code');
                    }
                }
                else {
                    return false;
                }
            }
        }
    }


    function showPosition(position) {
        $('#lat').val(position.coords.latitude);
        $('#long').val(position.coords.longitude);
        //alert("long: " + $('#lat').val() + "lat: " + $('#long').val());
    }


    $('.step1').click(function () {
        if ($('#checkcode').css('display') == "block") {
            $('#checkcode').hide();
            $('#checkcode0').show();
            $('.step1').addClass('active');
            $('.step2').removeClass('active');
        }
        else {
            return false;
        }
    });

    $('.step2').click(function () {
        if ($('#checkcode0').css('display') == "block") {
            if ($(".input1").val().length == 14) {

                $('#checkcode').show();
                $('#checkcode0').hide();
                $('.step2').addClass('active');
            }
            else {
                alert('Please enter the 13 digits code');
            }
        }
        else {
            return false;
        }

    });
    $('.step3').click(function () {
    });

    var flag = false;
    $(".mobile_number").keyup(function () {
        debugger
        if (this.value.length == this.maxLength) {
            $('#checkcode').hide();
            $('#checkcode2').show();
            if (!flag) {
                toastr.clear();

                if ($('#codeone').val() == '') {
                    toastr.error("Please enter Code1"); msg = "no";
                    return false;
                }

                var array = $('#codeone').val().split("-");
                var code1 = array[0];
                var code2 = array[1]

                if ($('#mobile1').val() == '') {
                    toastr.error("Please enter your mobile No."); msg = "no";
                    return false;
                }
                if ($('#mobile1').val().match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for mobile No."); msg = "no";
                    return false;
                }
                if ($('#mobile1').val() != '') {
                    var reg = new RegExp('[0-9]$');
                    if (!reg.test($('#mobile1').val())) {
                        toastr.error("Please enter numeric value for mobile No."); msg = "no";
                        return false;
                    }
                }
                if ($('#mobile1').val().length != 10) {
                    toastr.error("Please enter correct mobile No."); msg = "no";
                    return false;
                }
                //  else {
                if ($('#mobile1').val() == '') {
                    toastr.error("Please enter your mobile No."); msg = "no";
                    return false;
                }
                else {
                    var v = $('#mobile1').val().length;
                    if (v != 10) {
                        toastr.error("Please enter correct Mobile Number."); msg = "no"; return false;
                    }
                    else {
                        // if ($("#RefCd").val().length > 0) {
                        // var dotcontainer = $("#RefCd").val().substring(0, $('#RefCd').val().indexOf('-') + 1);
                        // if (dotcontainer.length == 0) {
                        // toastr.error("Please enter valid Referral code."); msg = "no"; return false;
                        // }
                        // }
                        // $('#pbrowse1').css("display", "none");
                        $.ajax({
                            type: "POST",
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile1').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                            success: function (data) {
                                debugger;
                                $('#progress').hide();
                                debugger
                                //if (flag_QRCodeCheckByScan == "RC") {
                                //}
                                //else {
                                //    $('#codeone').val('');
                                //   // $('#codetwo').val('');
                                //}
                                $('#mobile1').val('');
                                $('#RefCd').val('');

                                        // $('#p1msg').html(data);

                                        // if ($("#p1msg").text().includes('WARRANTY')) {
                                        // $('#pbrowse1').css("display", "block");
                                            //  $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                                //}
                                // else {
                                // $('#pbrowse1').css("display", "none");
                                //$('#spandt').text('');
                                // }
                                //$('#smallModal').modal();
                                //if (flag_QRCodeCheckByScan == "RC") {
                                //    $("#RefCd").removeAttr("disabled");
                                //}
                                //else {
                                //    $("#RefCd").attr("disabled", "disabled");
                                //}

                                $('#checkcode1').show();
                                //$('#warrenty').hide();
                                //$('#warratyHeading').show();
                                //$('#divCompany').hide();
                                // $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                //$("#imgWarrantyLogo").attr("src", msg);

                            }
                        });

                            <%--$.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile1').val(),
                                success: function (data) {
                                    //debugger;
                                    //     hideAjaxLoader();
                                    $('#progress').hide();
                                    debugger
                                    //if (flag_QRCodeCheckByScan == "RC") {
                                    //}
                                    //else {
                                    //    $('#codeone').val('');
                                    //   // $('#codetwo').val('');
                                    //}
                                    $('#mobile1').val('');
                                    $('#RefCd').val('');

                                        // $('#p1msg').html(data);

                                        // if ($("#p1msg").text().includes('WARRANTY')) {
                                        // $('#pbrowse1').css("display", "block");
                                    //  $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                                    //}
                                    // else {
                                    // $('#pbrowse1').css("display", "none");
                                    //$('#spandt').text('');
                                    // }
                                    //$('#smallModal').modal();
                                    //if (flag_QRCodeCheckByScan == "RC") {
                                    //    $("#RefCd").removeAttr("disabled");
                                    //}
                                    //else {
                                    //    $("#RefCd").attr("disabled", "disabled");
                                    //}

                                    $('#checkcode1').show();
                                    $('#warrenty').hide();
                                    $('#warratyHeading').show();
                                    $('#divCompany').hide();
                                   // $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                    $("#imgWarrantyLogo").attr("src", msg);




                                    //$('#p1msg').html(data);
                                    //$('#p1msg:contains("can not be guaranteed")').css('color', 'red');
                                    //$('#checkcode1').show();
                                    //$('#checkcode2').hide();
                                    flag = false;
                                },
                            });--%>

                    }
                }
            }
        }
        //}
    });

    $(".mobile_num").keyup(function () {

        var phoneNumber = $('.mobile_num').val();
        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid mobile number');
                    validate = false;
                    $('.mobile_num').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else
                    validate = false;
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid mobile number');
                $('.mobile_num').val('');
                validate = false;
            }
            else
                validate = false;
        }

        if (validate) {

            $('#p3msg').addClass('displayNone');
            if (this.value.length == this.maxLength) {
                $('#checkcode').hide();
                $('#checkcode2').show();
                if (!flag) {
                    toastr.clear();

                    if ($('#codeone').val() == '') {
                        toastr.error("Please enter Code1"); msg = "no";
                        return false;
                    }

                    var array = $('#codeone').val().split("-");
                    var code1 = array[0];
                    var code2 = array[1]

                    if ($('#mobile').val() == '') {
                        toastr.error("Please enter your mobile No."); msg = "no";
                        return false;
                    }
                    if ($('#mobile').val() != '') {
                        var reg = new RegExp('[0-9]$');
                        if (!reg.test($('#mobile').val())) {
                            toastr.error("Please enter numeric value for mobile No."); msg = "no";
                            return false;
                        }
                    }
                    if ($('#mobile').val().length != 10) {
                        toastr.error("Please enter correct mobile No."); msg = "no";
                        return false;
                    }
                    //  else {
                    if ($('#mobile').val() == '') {
                        toastr.error("Please enter your mobile No."); msg = "no";
                        return false;
                    }
                    else {
                        var v = $('#mobile').val().length;
                        if (v != 10) {
                            toastr.error("Please enter correct Mobile Number."); msg = "no"; return false;
                        }
                        else {
                            $('#hdnmob').val('' + $('#mobile').val());
                            // if ($("#RefCd").val().length > 0) {
                            // var dotcontainer = $("#RefCd").val().substring(0, $('#RefCd').val().indexOf('-') + 1);
                            // if (dotcontainer.length == 0) {
                            // toastr.error("Please enter valid Referral code."); msg = "no"; return false;
                            // }
                            // }
                            // $('#pbrowse1').css("display", "none");
                            if ($('#RefCd').val().length > 0) {
                                $.ajax({
                                    type: "post",
                                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=CheckReferralExists&refcode=' + $('#RefCd').val() + '&Mno=' + $('#mobile').val(),
                                    success: function (data) {
                                        if (data.length > 0) {

                                            flag = true;
                                            $.ajax({
                                                type: "POST",
                                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                                success: function (data) {
                                                    //debugger;
                                                    $('#progress').hide();
                                                    $('#mobile').val('');
                                                    $('#RefCd').val('');

                                                    //if (flag_QRCodeCheckByScan == "RC") {
                                                    //}
                                                    //else {
                                                    //    $('#codeone').val('');
                                                    //    $('#codetwo').val('');
                                                    //}


                                                    //toastr.info(data);
                                                    // $.alert(data);
                                                    //$('#p1msg').html(data);
                                                    //flupload_warr

                                                <%--if ($("#p1msg").text().includes('WARRANTY')) {
                                                   // $('#pbrowse1').css("display", "block");
                                                    $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                                                }
                                                else {
                                                   // $('#pbrowse1').css("display", "none");
                                                    $('#spandt').text('');
                                                }--%>
                                                    //$('#smallModal').modal();
                                                    //if (flag_QRCodeCheckByScan == "RC") {
                                                    //    $("#RefCd").removeAttr("disabled");
                                                    //}
                                                    //else {
                                                    //    $("#RefCd").attr("disabled", "disabled");
                                                    //}
                                                    flag = false;

                                                },
                                            });

                                        }
                                        else {
                                            toastr.clear();
                                            toastr.error("Please enter valid Referral code.");
                                            return false;
                                        }
                                    },
                                });
                            }
                            else {
                                flag = true;
                                $.ajax({
                                    type: "POST",
                                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                    success: function (data) {
                                        //debugger;
                                        //     hideAjaxLoader();
                                        $('#progress').hide();

                                        //if (flag_QRCodeCheckByScan == "RC") {
                                        //}
                                        //else {
                                        //    $('#codeone').val('');
                                        //   // $('#codetwo').val('');
                                        //}
                                        if (data == "Download App - Sawariya") {
                                            window.location.href = './CaliberWood';
                                        }
                                        $('#mobile').val('');
                                        $('#RefCd').val('');

                                        // $('#p1msg').html(data);

                                        // if ($("#p1msg").text().includes('WARRANTY')) {
                                        // $('#pbrowse1').css("display", "block");
                                        //  $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                                        //}
                                        // else {
                                        // $('#pbrowse1').css("display", "none");
                                        //$('#spandt').text('');
                                        // }
                                        //$('#smallModal').modal();
                                        //if (flag_QRCodeCheckByScan == "RC") {
                                        //    $("#RefCd").removeAttr("disabled");
                                        //}
                                        //else {
                                        //    $("#RefCd").attr("disabled", "disabled");
                                        //}
                                        $('#p1msg').html(data);
                                        $('#p1msg:contains("can not be guaranteed")').css('color', 'red');
                                        $('#checkcode1').show();
                                        $('#checkcode').hide();
                                        $('#checkcode2').hide();
                                        flag = false;
                                    },
                                });
                            }
                        }
                    }
                }
            }
        }
        else
            $('#p3msg').removeClass('displayNone');
    });

    $('#btnsubcode').on('click', function () {
        debugger;
        $('#btnsubcode').hide();
        //if (!flag) {
        $('#progress').show();
        toastr.clear();

        if ($('#codeone3').val() == '') {
            toastr.error("Please enter Code1"); msg = "no";
            $('#btnsubcode').show();
            return false;
        }
        if ($('#codeone3').val().length != 13) {
            toastr.error("Please enter 13 Digits Code1"); msg = "no";
            $('#btnsubcode').show();
            return false;
        }
        var array = $('#codeone3').val().split("-");
        var code1 = array[0];
        var code2 = array[1]

        if ($('#hdnmob').val() == '') {
            toastr.error("Please enter your mobile No."); msg = "no";
            return false;
        }
        else {

            if ($('#RefCd').val().length > 0) {
                $.ajax({
                    type: "post",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=CheckReferralExists&refcode=' + $('#RefCd').val() + '&Mno=' + $('#hdnmob').val(),
                    success: function (data) {
                        if (data.length > 0) {

                            flag = true;
                            $.ajax({
                                type: "POST",
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#hdnmob').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                                success: function (data) {
                                    debugger;
                                    $('#codeone3').val('');
                                    $('#progress').hide();
                                    $('#scrc').hide();
                                    //$('#mobile').val('');
                                    //$('#RefCd').val('');

                                    //if (flag_QRCodeCheckByScan == "RC") {
                                    //}
                                    //else {
                                    //    $('#codeone').val('');
                                    //    $('#codetwo').val('');
                                    //}


                                    //toastr.info(data);
                                    // $.alert(data);
                                    $('#p2msg').html(data);
                                        //flupload_warr

                                                <%--if ($("#p1msg").text().includes('WARRANTY')) {
                                                   // $('#pbrowse1').css("display", "block");
                                                    $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                                                }
                                                else {
                                                   // $('#pbrowse1').css("display", "none");
                                                    $('#spandt').text('');
                                                }--%>
                                    //$('#smallModal').modal();
                                    //if (flag_QRCodeCheckByScan == "RC") {
                                    //    $("#RefCd").removeAttr("disabled");
                                    //}
                                    //else {
                                    //    $("#RefCd").attr("disabled", "disabled");
                                    //}
                                    //flag = false;

                                },
                            });

                        }
                        else {
                            toastr.clear();
                            toastr.error("Please enter valid Referral code.");
                            return false;
                        }
                    },
                });
            }
            else {
                flag = true;
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#hdnmob').val() + '&RefCd=' + $('#RefCd').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                    success: function (data) {
                        //debugger;
                        //     hideAjaxLoader();
                        $('#codeone3').val('');
                        $('#progress').hide();
                        $('#scrc').hide();

                            //if (flag_QRCodeCheckByScan == "RC") {
                            //}
                            //else {
                            //    $('#codeone').val('');
                            //   // $('#codetwo').val('');
                            //}
                            //$('#mobile').val('');
                            //$('#RefCd').val('');

                            // $('#p1msg').html(data);

                            // if ($("#p1msg").text().includes('WARRANTY')) {
                            // $('#pbrowse1').css("display", "block");
                            //  $('#spandt').text($('#<%=hdndate1.ClientID%>').val());
                        //}
                        // else {
                        // $('#pbrowse1').css("display", "none");
                        //$('#spandt').text('');
                        // }
                        //$('#smallModal').modal();
                        //if (flag_QRCodeCheckByScan == "RC") {
                        //    $("#RefCd").removeAttr("disabled");
                        //}
                        //else {
                        //    $("#RefCd").attr("disabled", "disabled");
                        //}
                        $('#p2msg').html(data);
                        $('#p2msg:contains("can not be guaranteed")').css('color', 'red');
                        //$('#checkcode1').show();
                        //$('#checkcode2').hide();
                        //flag = false;
                    },
                });
            }

        }
        //}

    });

    $('#btnWarranty').on('click', function () {
        debugger;
        var flag = true;
        if (!document.querySelector('#warr_mobile').checkValidity()) {
            //$('#mobilelabelwarr').addClass('red');
            alert("Please enter mobile number");
            $('#warr_mobile').focus();
            flag = false;
            return false;
        }
        var emailaddressVal = $("#emailAddress").val();
        var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

        if (!document.querySelector('#emailAddress').checkValidity()) {
            alert("Please enter email address");
            $('#emailAddress').focus();
            flag = false;
            return false;
        }
        else {
            if (!emailReg.test(emailaddressVal)) {
                alert("Please enter email address");
                $('#emailAddress').focus();
                return false;
                flag = false;
            }
        }

        if (!document.querySelector('#billNumber').checkValidity()) {
            alert("Please enter bill number");
            $('#billNumber').focus();
            flag = false;
            return false;
        } else if (!document.querySelector('#purchasedate').checkValidity()) {
            // $('#date_label').show();
            // $('#purdate_label').addClass('red');
            alert("Please select purchase date");
            $('#purchasedate').focus();
            flag = false;
            return false;
        } else if (!document.querySelector('#img_bill').checkValidity()) {
            alert("Please upload a bill image.");
            // $('#bilImage_label').addClass('red');
            $('#img_bill').focus();

            flag = false;
            return false;
        }
        if (flag) {
            $('#btnWarranty').prop('disabled', true);
            var fd = new FormData();
            var files = $('#img_bill')[0].files[0];
            fd.append('file', files);
            var datamsg = "";
            debugger;
            var codes = $('#codeone').val();
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                data: fd,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&&codeone=' + codes.split('-')[0] + '&codetwo=' + codes.split('-')[1] + '&mobile=' + $('#warr_mobile').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                success: function (data) {
                    debugger
                    datamsg = data;
                    if (!data.toUpperCase().includes('ALREADY')) {
                        $.ajax({
                            type: "POST",
                            contentType: false,
                            processData: false,
                            data: fd,
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=browsesave&email=' + $('#emailAddress').val() + '&mobile=' + $('#warr_mobile').val() + '&billno=' + $('#billNumber').val() + '&purchasedate=' + $('#purchasedate').val() + '&code=' + $('#codeone').val(),
                            success: function (data) {
                                if (data != "")
                                    data = data + "<br/><br/>" + datamsg;
                                else
                                    data = datamsg;
                                //data = data + "<br/><br/>" + datamsg;
                                $('#p1msg').html(data);
                                $('#p1msg:contains("not")').css('color', 'red');
                                $('#checkcode').hide();
                                $('#checkcode1').show();
                                $('#warrenty').hide();
                            }
                        });
                    }
                    else {
                        //data = data + "<br/><br/>" + datamsg;
                       // $('#p1msg').html($('#msg').html());
 			$('#p1msg').html(data);
                        $('#p1msg:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#checkcode1').show();
                        $('#warrenty').hide();
                    }
                }
            });

        }
    });
    $('#btnautoWarranty').on('click', function () {
        debugger;
        var phoneNumber = $('#autowarr_mobile').val();
        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid mobile number');
                    validate = false;
                    $('#autowarr_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else
                    validate = false;
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid mobile number');
                $('#autowarr_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }

        if (validate) {

            if (!document.querySelector('#autowarr_mobile').checkValidity()) {
                //$('#emaillabelwarr').addClass('hide');

                $('#mobilelabelwarr').addClass('red');
                flag = false;
            }

            if (validate) {

                $('#btnautoWarranty').prop('disabled', true);
                var fd = new FormData();
                //var files = $('#img_bill')[0].files[0];
                // fd.append('file', files);
                var datamsg = "";
                debugger;
                var codes = $('#codeone').val();

                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    data: fd,
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&&codeone=' + codes.split('-')[0] + '&codetwo=' + codes.split('-')[1] + '&mobile=' + $('#autowarr_mobile').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                    success: function (data) {
                        debugger

                        datamsg = data;
                        if (!data.toUpperCase().includes('ALREADY')) {
                            $.ajax({
                                type: "POST",
                                contentType: false,
                                processData: false,
                                data: fd,
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=autobrowsesave&mobile=' + $('#autowarr_mobile').val() + '&code=' + $('#codeone').val(),
                                success: function (data) {

                                    // data = data + "<br/><br/>" + datamsg;
                                    $('#p1msg').html(datamsg);
                                    $('#p1msg:contains("not")').css('color', 'red');
                                    $('#checkcode').hide();
                                    $('#checkcode1').show();
                                    $('#autowarrenty').hide();
                                }
                            });
                        }
                        else {
                            $('#p1msg').html($('#msg').html());
                            $('#p1msg:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#checkcode1').show();
                            $('#autowarrenty').hide();
                        }
                    }
                });


            }
        }
        else
            $('#p3msg').removeClass('displayNone');
    });
    $('#btnjph').on('click', function () {
        debugger;
        var flag = true;
        var phoneNumber = $('#jph_mobile').val();
        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
        }
        if (!document.querySelector('#jph_mobile').checkValidity()) {
            //$('#emaillabelwarr').addClass('hide');

            $('#mobilelabelwarr').addClass('red');
            flag = false;
        }

        if (flag) {
            $('#btnjph').prop('disabled', true);
            var fd = new FormData();
            //var files = $('#img_bill')[0].files[0];
            // fd.append('file', files);
            var datamsg = "";
            debugger;
            var codes = $('#codeone').val();
            var phoneNumber = $('#jph_mobile').val();
            var validate = false;
            var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

            if (filter.test(phoneNumber)) {
                if (phoneNumber.length == 10) {
                    var c = phoneNumber.slice(0, 1);
                    if (c <= 5) {
                        $('#p3msg').html('Not a valid number');
                        validate = false;
                        $('#jph_mobile').val('');
                    }
                    else
                        validate = true;
                } else {
                    if (phoneNumber.length > 10) {
                        $('#p3msg').html('Please put 10  digit mobile number');
                        //$('#p3msg').removeClass('displayNone');
                        validate = false;
                    }
                    else {
                        validate = false;
                        $('#btnjph').attr('disabled', false);
                    }
                }
            }
            else {

                if (phoneNumber.length == 9) {
                    $('#p3msg').html('Not a valid number');
                    $('#jph_mobile').val('');
                    validate = false;
                }
                else
                    validate = false;
            }
            if (validate) {
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    data: fd,
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&&codeone=' + codes.split('-')[0] + '&codetwo=' + codes.split('-')[1] + '&mobile=' + $('#jph_mobile').val() + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                    success: function (data) {
                        debugger

                        datamsg = data;

                        $('#p1msg').html(datamsg);
                        $('#p1msg:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#checkcode1').show();
                        $('#jphcounter').hide();

                    }
                });
            }
            else {
                $('#btnjph').attr('disabled', false);
                $('#p3msg').removeClass('displayNone');
            }

        }
    });
    $('#btnCompany').on('click', function () {
        $('#btnCompany').attr('disabled', true);

        var phoneNumber = $('#MM_mobile').val();
        var empID = $('#MM_mobile').val();
        var distributorID = $('#distributorID').val();
        var UserType = $("#MM_role option:selected ").val();


if (UserType == -1) {
            toastr.error('Please select role!');

        }
        if (empID == "") {
            toastr.error('Please enter Technician ID/Techmaster ID/Employee ID!');

        }
        if (distributorID == "") {
            toastr.error('Please enter dealer code!');

        }




        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');

        }
        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid number');
                    validate = false;
                    $('#MM_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btnCompany').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#MM_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }

        if (validate) {

            $('#p3msg').html('');

            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + '&UserType=' + UserType + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation.toString(),
                success: function (data) {
                    if (data == "success") {
                        $('#warrenty').hide();
                        $('#divCompany').hide();
                        $('#warratyHeading div').css('margin-top', "0px")
                        $('#divOtpVerified').show();
                    }
                    else {
                        if (data.includes("Failure")) {
                            $('#p1msg').html(data.split('~')[1]);
                            //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                            $('#p1msg:contains("wrong")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#checkcode1').show();
                            $('#warrenty').hide();
                            $('#divOtpVerified').hide();
                            $('#divCompany').hide();
                        } else {
                            $('#p1msg').html(data);
                            //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                            $('#p1msg:contains("wrong")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#checkcode1').show();
                            $('#warrenty').hide();
                            $('#divOtpVerified').hide();
                            $('#divCompany').hide();
                        }
                    }

                    $('#btnCompany').attr("disabled", false);
                }
            });
        }
        else {

            $('#btnCompany').attr('disabled', false);
            $('#p3msg').removeClass('displayNone');
        }

    });
    $('#btnVerify').on('click', function () {

        $('#btnVerify').attr('disabled', true);

var mmOTP = $('#mmOTP').val();
        if (mmOTP == "") {
            
            toastr.error('Please enter valid OTP !');
            $('#btnVerify').attr('disabled', false);
            return false;
        }

        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,

            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#MM_mobile').val() + '&verifycode=' + $('#mmOTP').val() + "&vCode=" + $('#codeone').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val()+ '&comp=' + compInformation.toString(),
            success: function (data) {
                debugger;
                if (data.split('~')[0] !== "failure") {
                    $('#p1msg').html(data.split('~')[1]);
                    $('#p1msg:contains("not")').css('color', 'red');
                    $('#checkcode').hide();
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#divOtpVerified').hide();
                }
                else {
                    //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                    //$('#p1msg:contains("not")').css('color', 'red');
                    //$('#checkcode').hide();
                    //$('#checkcode1').show();
                    //$('#warrenty').hide();
                    $('#divOtpVerified').show();
                    toastr.error('OTP is not valid. Please provide the valid OTP');
                    $('#btnVerify').attr('disabled', false);
                    //$('#divCompany').hide();
                }
            }
        });
    });
    $('#btnskyVerify').on('click', function () {
        $('#btnskyVerify').attr('disabled', true);
        var fieldmobile = '';
        var divname = '';
        var fieldname = '';
        var atLeastOneIsChecked = '';
        if (compInformation == 'SKYDECOR LAMINATES PRIVATE LIMITED') {
            fieldmobile = 'sky_mobile';
            divname = 'skydecore';
            fieldname = 'sky_name';
            atLeastOneIsChecked = '';
        }
        else if (compInformation == 'JOHNSON PAINTS CO.') {
            fieldmobile = 'jpcpainter_mobile';
            divname = 'jpc';
            fieldname = 'jpcpainter_name';
            atLeastOneIsChecked = '';
        }
        else {
            fieldmobile = 'coats_mobile';
            fieldname = 'coats_name';
            divname = 'Coatsbathfitting';
            atLeastOneIsChecked = $('input[name="checkdesignation"]:checked').val();
        }



        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,

            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&dealerid=' + $('#jpc_dealerid').val() + '&designation=' + atLeastOneIsChecked + '&mobile=' + $('#' + fieldmobile).val() + '&dealermobile=' + $('#jpcdealer_mobile').val() + '&verifycode=' + $('#nonmmOTP').val() + "&vCode=" + $('#codeone').val() + '&empId=&disId=&name=' + $('#' + fieldname).val(),
            success: function (data) {
                debugger;
                if (data.split('~')[0] !== "failure") {
                    $('#sky_message').html(data.split('~')[1]);
                    $('#sky_message:contains("not")').css('color', 'red');
                    // $('#checkcode').hide();
                    $('#sky_message').show();
                    $('#btnNext2').show();
                    $('#' + divname).hide();
                    $('#divOtpVerified1').hide();

                }
                else {
                    //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                    //$('#p1msg:contains("not")').css('color', 'red');
                    //$('#checkcode').hide();
                    //$('#checkcode1').show();
                    //$('#' + divname).hide();
                    $('#divOtpVerified1').show();
                    toastr.error('OTP is not valid. Please provide the valid OTP');
                    $('#btnskyVerify').attr('disabled', false);
                    //$('#divCompany').hide();
                }
            }
        });
    });
    $('#btnskyVerify1').on('click', function () {
        $('#btnskyVerify1').attr('disabled', true);
        var fieldmobile = '';
        var divname = '';
        var fieldname = '';
        var atLeastOneIsChecked = '';
        debugger;
        fieldmobile = 'coats_mobile';
        fieldname = 'coats_name';
        divname = 'Coatsbathfitting';
        atLeastOneIsChecked = $('input[name="checkdesignation"]:checked').val();
        if (compInformation == 'SKYDECOR LAMINATES PRIVATE LIMITED') {


            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&dealerid=' + $('#jpc_dealerid').val() + '&designation=' + atLeastOneIsChecked + '&mobile=' + $('#' + fieldmobile).val() + '&dealermobile=' + $('#jpcdealer_mobile').val() + '&verifycode=' + $('#nonmmOTP1').val() + "&vCode=" + $('#codeone').val() + '&empId=&disId=&name=' + $('#' + fieldname).val(),
                success: function (data) {
                    debugger;
                    if (data.split('~')[0] !== "failure") {
                        $('#p1msg2').html(data.split('~')[1]);

                        $('#p1msg2:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#msgcoats').show();
                        // $('#checkcode1').show();
                        $('#' + divname).hide();
                        $('#divOtpVerified2').hide();
                    }
                    else {
                        //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                        //$('#p1msg:contains("not")').css('color', 'red');
                        //$('#checkcode').hide();
                        //$('#checkcode1').show();
                        //$('#' + divname).hide();
                        $('#msgcoats').hide();
                        $('#divOtpVerified2').show();
                        toastr.error('OTP is not valid. Please provide the valid OTP');
                        $('#btnskyVerify1').attr('disabled', false);
                        //$('#divCompany').hide();
                    }
                }
            });
        }
        else {
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,

                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&designation=' + atLeastOneIsChecked + '&mobile=' + $('#' + fieldmobile).val() + '&verifycode=' + $('#nonmmOTP1').val() + "&vCode=" + $('#codeone').val() + '&empId=&disId=&name=' + $('#' + fieldname).val(),
                success: function (data) {
                    debugger;
                    if (data.split('~')[0] !== "failure") {
                        $('#p1msg2').html(data.split('~')[1]);

                        $('#p1msg2:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#msgcoats').show();
                        // $('#checkcode1').show();
                        $('#' + divname).hide();
                        $('#divOtpVerified2').hide();
                    }
                    else {
                        //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                        //$('#p1msg:contains("not")').css('color', 'red');
                        //$('#checkcode').hide();
                        //$('#checkcode1').show();
                        //$('#' + divname).hide();
                        $('#msgcoats').hide();
                        $('#divOtpVerified2').show();
                        toastr.error('OTP is not valid. Please provide the valid OTP');
                        $('#btnskyVerify1').attr('disabled', false);
                        //$('#divCompany').hide();
                    }
                }
            });
        }
    });
    $('#btncoats').on('click', function () {
        $('#btncoats').attr('disabled', true);

        var phoneNumber = $('#coats_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
        }

        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid name');
                    validate = false;
                    $('#coats_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btncoats').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#coats_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }
        if ($('#coats_name').val().length < 1) {
            toastr.error('Invalid Name!');
            validate = false;
        }
        var matches = $('#coats_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Name Should can contains alphabet only!');
            validate = false;
        }

        //if ($('#coats_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //    validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');
            if (compInformation == 'SKYDECOR LAMINATES PRIVATE LIMITED') {
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savedecore&mobile=' + $('#coats_mobile').val() + '&name=' + $('#coats_name').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation.toString(),
                    success: function (data) {
                        if (data == "success") {
                            $('#Coatsbathfitting').hide();
                            $('#divCompany').hide();
                            $('#warratyHeading div').css('margin-top', "0px")
                            $('#divOtpVerified2').show();
                        }
                        else {
                            if (data.includes("Failure")) {
                                $('#p1msg').html(data.split('~')[1]);
                                //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                                $('#p1msg:contains("wrong")').css('color', 'red');
                                $('#checkcode').hide();
                                $('#checkcode1').show();
                                $('#Coatsbathfitting').hide();
                                $('#divOtpVerified2').hide();
                                $('#divCompany').hide();
                                $('#btncoats').attr("disabled", false);
                                toastr.error(data.split('~')[1]);
                            } else {
                                $('#p1msg').html(data);
                                //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                                $('#p1msg:contains("wrong")').css('color', 'red');
                                $('#checkcode').hide();
                                $('#checkcode1').show();
                                $('#Coatsbathfitting').hide();
                                $('#divOtpVerified2').hide();
                                $('#divCompany').hide();
                                $('#btncoats').attr("disabled", false);
                                toastr.error(data.split('~')[1]);
                            }
                        }

                        $('#btncoats').attr("disabled", false);
                    }
                });
            }
            else {
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecoats&mobile=' + $('#coats_mobile').val() + '&name=' + $('#coats_name').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation.toString(),
                    success: function (data) {
                        if (data == "success") {
                            $('#Coatsbathfitting').hide();
                            $('#divCompany').hide();
                            $('#warratyHeading div').css('margin-top', "0px")
                            $('#divOtpVerified2').show();
                        }
                        else {
                            if (data.includes("Failure")) {
                                $('#p1msg').html(data.split('~')[1]);
                                //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                                $('#p1msg:contains("wrong")').css('color', 'red');
                                $('#checkcode').hide();
                                $('#checkcode1').show();
                                $('#Coatsbathfitting').hide();
                                $('#divOtpVerified2').hide();
                                $('#divCompany').hide();
                                $('#btncoats').attr("disabled", false);
                                toastr.error(data.split('~')[1]);
                            } else {
                                $('#p1msg').html(data);
                                //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                                $('#p1msg:contains("wrong")').css('color', 'red');
                                $('#checkcode').hide();
                                $('#checkcode1').show();
                                $('#Coatsbathfitting').hide();
                                $('#divOtpVerified2').hide();
                                $('#divCompany').hide();
                                $('#btncoats').attr("disabled", false);
                                toastr.error(data.split('~')[1]);
                            }
                        }

                        $('#btncoats').attr("disabled", false);
                    }
                });
            }
        }
        else {

            $('#btncoats').attr('disabled', false);
            //  $('#p3msg').removeClass('displayNone');
        }

    });
    $('#btnever').on('click', function () {
        $('#btnever').attr('disabled', true);

        var phoneNumber = $('#ever_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('कृपया वैध मोबाइल नंबर दर्ज करें।');
        }

        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('कृपया मान्य नाम दर्ज करें।');
                    validate = false;
                    $('#ever_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('कृपया 10 अंकों का मोबाइल नंबर डालें।');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btnever').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('कृपया वैध मोबाइल नंबर दर्ज करें।');
                $('#ever_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }
        if ($('#ever_name').val().length < 1) {
            toastr.error('कृपया मान्य नाम दर्ज करें।');
            validate = false;
        }
        var matches = $('#ever_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('नाम में केवल अक्षर डालें।');
            validate = false;
        }
        //////////////////village//////////////
        if ($('#ever_village').val().length < 1) {
            toastr.error('कृपया मान्य गांव दर्ज करें।');
            validate = false;
        }
        var matches = $('#ever_village').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('गांव में केवल अक्षर डालें।');
            validate = false;
        }

        ////////////////////////district///////////////////////////
        if ($('#ever_district').val().length < 1) {
            toastr.error('कृपया वैध जिला दर्ज करें।');
            validate = false;
        }
        var matches = $('#ever_district').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('जिला में केवल अक्षर डालें।');
            validate = false;
        }
        /////////////////////state//////////////////////
        if ($('#ever_state').val().length < 1) {
            toastr.error('कृपया वैध राज्य दर्ज करें।');
            validate = false;
        }
        var matches = $('#ever_state').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('राज्य में केवल अक्षर डालें।');
            validate = false;
        }

        ///////////////////Country//////////////////
        if ($('#ever13').is(":visible")) {
            if ($('#ever_code').val().length < 13) {
                toastr.error('कृपया 13 अंकों का मान्य कोड दर्ज करें।');
                validate = false;
            }
        }
        //var matches = $('#ever_country').val().match(/\d+/g);
        //if (matches != null) {
        //    toastr.error('Country Should can contains alphabet only!');
        //    validate = false;
        //}
        ////////////////country end//////////////////
        //if ($('#coats_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //    validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');
            if ($('#codeone').val() == "" || $('#codeone').val() == null) {

                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=saveeverdetails&district=' + $('#ever_district').val() + '&mobile=' + $('#ever_mobile').val() + '&state=' + $('#ever_state').val() + '&village=' + $('#ever_village').val() + '&name=' + $('#ever_name').val() + '&country=' + $('#ever_country').val() + '&comp=EVERCROP AGRO SCIENCE',
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#p1msg2').html(data.split('~')[1]);

                            $('#p1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgcoats').show();
                            $('#evercrop').hide();
                            // $('#checkcode1').show();
                            $('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgcoats').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error(data.split('~')[1]);
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
            else {

                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&district=' + $('#ever_district').val() + '&mobile=' + $('#ever_mobile').val() + "&vCode=" + $('#codeone').val() + '&state=' + $('#ever_state').val() + '&village=' + $('#ever_village').val() + '&name=' + $('#ever_name').val() + '&country=' + $('#ever_country').val() + '&comp=' + compInformation,
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#p1msg2').html(data.split('~')[1]);

                            $('#p1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgcoats').show();
                            $('#evercrop').hide();
                            // $('#checkcode1').show();
                            $('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgcoats').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error('OTP is not valid. Please provide the valid OTP');
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
        }
        else {

            $('#btnever').attr('disabled', false);
            //  $('#p3msg').removeClass('displayNone');
        }

    });
<%--$('#btnever').on('click', function () {
        $('#btnever').attr('disabled', true);

        var phoneNumber = $('#ever_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
        }

        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid name');
                    validate = false;
                    $('#ever_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btnever').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#ever_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }
        if ($('#ever_name').val().length < 1) {
            toastr.error('Invalid Name!');
            validate = false;
        }
        var matches = $('#ever_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Name Should can contains alphabet only!');
            validate = false;
        }
        //////////////////village//////////////
        if ($('#ever_village').val().length < 1) {
            toastr.error('Invalid village!');
            validate = false;
        }
        var matches = $('#ever_village').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Village Should can contains alphabet only!');
            validate = false;
        }

        ////////////////////////district///////////////////////////
        if ($('#ever_district').val().length < 1) {
            toastr.error('Invalid district!');
            validate = false;
        }
        var matches = $('#ever_district').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('District Should can contains alphabet only!');
            validate = false;
        }
        /////////////////////state//////////////////////
        if ($('#ever_state').val().length < 1) {
            toastr.error('Invalid State!');
            validate = false;
        }
        var matches = $('#ever_state').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('State Should can contains alphabet only!');
            validate = false;
    }

    ///////////////////Country//////////////////
    if ($('#ever_country').val().length < 1) {
        toastr.error('Invalid Country!');
        validate = false;
    }
    var matches = $('#ever_country').val().match(/\d+/g);
    if (matches != null) {
        toastr.error('Country Should can contains alphabet only!');
        validate = false;
    }
    ////////////////country end//////////////////
        //if ($('#coats_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //    validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');
            if($('#codeone').val() == "" || $('#codeone').val() == null)
            {
                
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=saveeverdetails&district=' + $('#ever_district').val() + '&mobile=' + $('#ever_mobile').val() + '&state=' + $('#ever_state').val() + '&village=' + $('#ever_village').val() + '&name=' + $('#ever_name').val() + '&country=' + $('#ever_country').val() + '&comp=EVERCROP AGRO SCIENCE',
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#p1msg2').html(data.split('~')[1]);

                            $('#p1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgcoats').show();
                            $('#evercrop').hide();
                            // $('#checkcode1').show();
                            $('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgcoats').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error('OTP is not valid. Please provide the valid OTP');
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
            else
            {
                
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&district=' + $('#ever_district').val() + '&mobile=' + $('#ever_mobile').val() + "&vCode=" + $('#codeone').val() + '&state=' + $('#ever_state').val() + '&village=' + $('#ever_village').val() + '&name=' + $('#ever_name').val() + '&country=' + $('#ever_country').val() + '&comp=' + compInformation,
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#p1msg2').html(data.split('~')[1]);

                            $('#p1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgcoats').show();
                            $('#evercrop').hide();
                            // $('#checkcode1').show();
                            $('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgcoats').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error('OTP is not valid. Please provide the valid OTP');
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
         }
         else {

            $('#btnever').attr('disabled', false);
             //  $('#p3msg').removeClass('displayNone');
         }

});--%>
    $('#btnsupriya').on('click', function () {
        debugger;
        $('#btnsupriya').attr('disabled', true);

        var phoneNumber = $('#supriya_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
        }

        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid name');
                    validate = false;
                    $('#supriya_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btnsupriya').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#supriya_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }
        if ($('#supriya_name').val().length < 1) {
            toastr.error('Invalid Name!');
            validate = false;
        }
        var matches = $('#supriya_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Name Should can contains alphabet only!');
            validate = false;
        }


        /////////////////////state//////////////////////
        if ($('#supriya_state').val().length < 1) {
            toastr.error('Invalid State!');
            validate = false;
        }
        var matches = $('#supriya_state').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('State Should can contains alphabet only!');
            validate = false;
        }

        if (validate) {

            $('#p3msg').html('');
            if ($('#codeone').val() == "" || $('#codeone').val() == null) {

                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=saveeverdetails&district=' + $('#ever_district').val() + '&mobile=' + $('#ever_mobile').val() + '&state=' + $('#ever_state').val() + '&village=' + $('#ever_village').val() + '&name=' + $('#ever_name').val() + '&country=' + $('#ever_country').val() + '&comp=EVERCROP AGRO SCIENCE',
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#p1msg2').html(data.split('~')[1]);

                            $('#p1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgcoats').show();
                            $('#evercrop').hide();
                            // $('#checkcode1').show();
                            $('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgcoats').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error('OTP is not valid. Please provide the valid OTP');
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
            else {

                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#supriya_mobile').val() + "&vCode=" + $('#codeone').val() + '&state=' + $('#supriya_state').val() + '&name=' + $('#supriya_name').val() + '&comp=' + compInformation,
                    success: function (data) {
                        debugger;
                        if (data.split('~')[0] !== "failure") {
                            $('#supriyap1msg2').html(data.split('~')[1]);

                            $('#supriyap1msg2:contains("not")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#msgsupriya').show();

                            $('#supriyaform').hide();

                            // $('#checkcode1').show();
                            //$('#' + divname).hide();
                            //$('#divOtpVerified2').hide();
                        }
                        else {
                            //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                            //$('#p1msg:contains("not")').css('color', 'red');
                            //$('#checkcode').hide();
                            //$('#checkcode1').show();
                            //$('#' + divname).hide();
                            $('#msgsupriya').hide();
                            // $('#divOtpVerified2').show();
                            toastr.error(data.split('~')[1]);
                            $('#btnskyVerify1').attr('disabled', false);
                            //$('#divCompany').hide();
                        }
                    }
                });
            }
        }
        else {

            $('#btnever').attr('disabled', false);
            //  $('#p3msg').removeClass('displayNone');
        }

    });
    $('#btnnutra').on('click', function () {
        $('#btnnutra').attr('disabled', true);

        var phoneNumber = $('#nutra_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
        }

        var validate = false;
        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid name');
                    validate = false;
                    $('#ever_mobile').val('');
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                else {
                    validate = false;
                    $('#btnnutra').attr('disabled', false);
                }
            }
        }
        else {

            if (phoneNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#nutra_mobile').val('');
                validate = false;
            }
            else
                validate = false;
        }

        //if ($('#coats_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //    validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');


            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,

                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&vCode=' + $('#codeone').val() + '&mobile=' + $('#nutra_mobile').val() + '&comp=' + compInformation,
                success: function (data) {
                    debugger;
                    if (data.split('~')[0] !== "failure") {
                        $('#p1msg2').html(data.split('~')[1]);

                        $('#p1msg2:contains("not")').css('color', 'red');
                        $('#checkcode').hide();
                        $('#msgcoats').show();
                        $('#nutravel').hide();
                        // $('#checkcode1').show();
                        $('#' + divname).hide();
                        //$('#divOtpVerified2').hide();
                    }
                    else {
                        //$('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                        //$('#p1msg:contains("not")').css('color', 'red');
                        //$('#checkcode').hide();
                        //$('#checkcode1').show();
                        //$('#' + divname).hide();
                        $('#msgcoats').hide();
                        // $('#divOtpVerified2').show();
                        toastr.error('OTP is not valid. Please provide the valid OTP');
                        $('#btnskyVerify1').attr('disabled', false);
                        //$('#divCompany').hide();
                    }
                }
            });

        }
        else {

            $('#btnever').attr('disabled', false);
            //  $('#p3msg').removeClass('displayNone');
        }

    });
    $('#btnsky').on('click', function () {
        $('#btnsky').attr('disabled', true);
        var validate = true;
        var phoneNumber = $('#sky_mobile').val();

        if (phoneNumber.length < 10) {
            toastr.error('Invalid Mobile no!');
            validate = false;
        }


        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    toastr.error('Invalid Mobile no!');
                    validate = false;
                    $('#sky_mobile').val('');
                }
                //else
                //    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    toastr.error('Please put 10  digit mobile number');
                    validate = false;
                }
                //else {
                //    validate = false;
                //    $('#btnsky').attr('disabled', false);
                //}
            }
        }
        else {

            if (phoneNumber.length == 9) {
                toastr.error('Invalid Mobile no!');
                $('#sky_mobile').val('');
                validate = false;
            }
            //else
            //    validate = false;
        }
        if ($('#sky_name').val().length < 1) {
            toastr.error('Invalid Name!');
            validate = false;
        }
        var matches = $('#sky_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Name Should can contains alphabet only!');
            validate = false;
        }


        //if ($('#sky_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //   validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');

            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savedecore&mobile=' + phoneNumber + '&name=' + $('#sky_name').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation,
                success: function (data) {
                    if (data == "success") {
                        $('#skydecore').hide();
                        $('#divCompany').hide();
                        $('#warratyHeading div').css('margin-top', "0px")
                        $('#divOtpVerified1').show();
                    }
                    else {
                        if (data.includes("Failure")) {
                            $('#p1msg').html(data.split('~')[1]);
                            //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                            $('#p1msg:contains("wrong")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#checkcode1').show();
                            $('#skydecore').hide();
                            $('#divOtpVerified1').hide();
                            $('#divCompany').hide();
                            $('#btnsky').attr("disabled", false);
                            toastr.error(data.split('~')[1]);
                        } else {
                            $('#p1msg').html(data);
                            //$('#p1msg').text("You are not valid user please enter your valid user id and dealer id.");
                            $('#p1msg:contains("wrong")').css('color', 'red');
                            $('#checkcode').hide();
                            $('#checkcode1').show();
                            $('#skydecore').hide();
                            $('#divOtpVerified1').hide();
                            $('#divCompany').hide();
                            $('#btnsky').attr("disabled", false);

                        }
                    }

                    $('#btnsky').attr("disabled", false);
                }
            });
        }
        else {

            $('#btnsky').attr('disabled', false);
            //$('#p3msg').removeClass('displayNone');
        }

    });

    $('#btnjpc').on('click', function () {
        debugger;
        $('#btnjpc').attr('disabled', true);
        var validate = true;
        var dealerNumber = $('#jpcdealer_mobile').val();
        var painterNumber = $('#jpcpainter_mobile').val();
        if (dealerNumber.length < 10) {
            toastr.error('Invalid Dealer Mobile no!');
            validate = false;
        }

        if (painterNumber.length < 10) {
            toastr.error('Invalid Painter Mobile no!');
            validate = false;
        }

        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(dealerNumber)) {
            if (dealerNumber.length == 10) {
                var c = dealerNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid number');
                    validate = false;
                    $('#jpcdealer_mobile').val('');
                }
                //else
                //    validate = true;
            } else {
                if (dealerNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                //else {
                //    validate = false;
                //    $('#btnjpc').attr('disabled', false);
                //}
            }
        }
        else {

            if (dealerNumber.length == 9) {
                $('#p3msg').html('Not a valid number');
                $('#jpcdealer_mobile').val('');
                validate = false;
            }
            //else
            //    validate = false;
        }
        if ($('#jpcpainter_name').val().length < 1) {
            toastr.error('Invalid Painter Name!');
            validate = false;
        }
        if (filter.test(painterNumber)) {
            if (painterNumber.length == 10) {
                var c = painterNumber.slice(0, 1);
                if (c <= 5) {
                    $('#p3msg').html('Not a valid number');
                    validate = false;
                    $('#jpcpainter_mobile').val('');
                }
                //else
                //    validate = true;
            } else {
                if (painterNumber.length > 10) {
                    $('#p3msg').html('Please put 10  digit mobile number');
                    //$('#p3msg').removeClass('displayNone');
                    validate = false;
                }
                //else {
                //    validate = false;
                //    $('#btnjpc').attr('disabled', false);
                //}
            }
        }
        else {

            if (painterNumber.length == 9) {
                toastr.error('Not a valid painter mobile number');
                $('#jpcpainter_mobile').val('');
                validate = false;
            }
            //else
            //    validate = false;
        }
        //if (!checkgstin($('#jpc_dealerid').val())) {
        //    toastr.error('Invalid Dealer Id!');
        //    validate = false;
        //}
        var matches = $('#jpcpainter_name').val().match(/\d+/g);
        if (matches != null) {
            toastr.error('Name Should can contains alphabet only!');
            validate = false;
        }
        if ($('#jpcpainter_mobile').val().substring($('#jpcpainter_mobile').val().length - 10, 10) == $('#jpcdealer_mobile').val().substring($('#jpcdealer_mobile').val().length - 10, 10)) {
            toastr.error('Painter and Dealer Mobile no. can not  be same!');
            validate = false;
        }
        //if ($('#sky_name').val() = '') {
        //    toastr.error('Invalid Name!');
        //   validate = false;
        //}
        //else {
        //    validate = true;
        //}
        if (validate) {

            $('#p3msg').html('');

            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savedecore&mobile=' + dealerNumber + '&name=' + $('#jpcpainter_name').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation + '&dealerid=' + $('#jpc_dealerid').val() + '&dealermobile=' + dealerNumber,
                success: function (data) {
                    debugger;
                    if (data.split('~')[0] == "success") {
                        $('#skydecore').hide();
                        $('#jpc').hide();
                        $('#divCompany').hide();
                        $('#warratyHeading div').css('margin-top', "0px")
                        $('#sky_message').html(data.split('~')[1]);
                        $('#sky_message:contains("not")').css('color', 'red');
                        // $('#checkcode').hide();
                        $('#sky_message').show();
                        $('#btnNext2').show();
                        $('#' + divname).hide();

                    }
                    else {
                        if (data.includes("Failure")) {
                            debugger;
                            $('#chkGun').hide();
                            $('#Coatsbathfitting').hide();
                            $('#skydecore').hide();
                            $('#jphcounter').hide();
                            $('#jpc').show();
                            $('#warratyHeading').show();
                            $('#checkcode').show();
                            $('#checkcode2').hide();
                            $('#divCompany').hide();

                            //$('#msg').html(data.split('&')[3].toString());
                            $('#btnjpc').attr("disabled", false);
                            toastr.error(data.split('~')[1]);
                        }
                        else {
                            debugger;
                            $('#chkGun').hide();
                            $('#Coatsbathfitting').hide();
                            $('#skydecore').hide();
                            $('#jphcounter').hide();
                            $('#jpc').show();
                            $('#warratyHeading').show();
                            $('#checkcode').show();
                            $('#checkcode2').hide();
                            $('#divCompany').hide();

                            //$('#msg').html(data.split('&')[3].toString());
                            $('#btnjpc').attr("disabled", false);

                            toastr.error(data.split('~')[1]);
                        }
                    }

                    $('#btnjpc').attr("disabled", false);
                }
            });
        }
        else {

            $('#btnjpc').attr('disabled', false);

        }

    });
    function checkgstin(g) {
        let regTest = /\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}/.test(g)
        if (regTest) {
            let a = 65, b = 55, c = 36;
            return Array['from'](g).reduce((i, j, k, g) => {
                p = (p = (j.charCodeAt(0) < a ? parseInt(j) : j.charCodeAt(0) - b) * (k % 2 + 1)) > c ? 1 + (p - c) : p;
                return k < 14 ? i + p : j == ((c = (c - (i % c))) < 10 ? c : String.fromCharCode(c + b));
            }, 0);
        }
        return regTest
    }
    $('#btnResendOtp').on('click', function () {
        debugger;
        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=resendotp&mobile=' + $('#MM_mobile').val(),
            success: function (data) {
                //debugger;
                if (data == "success") {
                    $('#otpMsg').text('OTP has been resent on your registered number.');
                    //$('#checkcode1').show();
                    $('#checkcode').show();
                    $('#divOtpVerified').show();
                    $('#warrenty').hide();
                }
                else if (data == "exceed") {
                    $('#p1msg').text('You have exceeded your attempts, Please try again.');
                    $('#p1msg:contains("exceeded")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#divOtpVerified').hide();
                    $('#divCompany').hide();
                    $('#checkcode').hide();
                }
                else {
                    $('#p1msg').text('Unable send OTP, Please contact to system administrator');
                    $('#p1msg:contains("Unable")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#divOtpVerified').hide();
                    $('#divCompany').hide();
                }
            }
        });
    });
    $('#btnResendOtp1').on('click', function () {
        debugger;
        var fieldname = '';
        var divname = ''
        if (compInformation.toString() == 'SKYDECOR LAMINATES PRIVATE LIMITED') {
            fieldname = 'sky_mobile';
            divname = 'skydecore';
        }
        else if (compInformation.toString() == 'JOHNSON PAINTS CO.') {
            fieldname = 'jpcpainter_mobile';

            divname = 'jpc';
        }
        else {
            fieldname = 'coats_mobile';

            divname = 'Coatsbathfitting';
        }
        //debugger;

        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=resendotp&mobile=' + $('#' + fieldname).val(),
            success: function (data) {
                //debugger;
                if (data == "success") {
                    $('#otpMsg1').text('OTP has been resent on your registered number.');
                    //$('#checkcode1').show();
                    $('#checkcode').show();
                    $('#divOtpVerified1').show();
                    $('#warrenty').hide();
                }
                else if (data == "exceed") {
                    $('#p1msg').text('You have exceeded your attempts, Please try again.');
                    $('#p1msg:contains("exceeded")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#' + divname).hide();
                    $('#divOtpVerified1').hide();
                    $('#divCompany').hide();
                    $('#checkcode').hide();
                }
                else {
                    $('#p1msg').text('Unable send OTP, Please contact to system administrator');
                    $('#p1msg:contains("Unable")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#' + divname).hide();
                    $('#divOtpVerified1').hide();
                    $('#divCompany').hide();
                }
            }
        });
    });
    $('#btnResendOtp2').on('click', function () {
        debugger;
        var fieldname = '';
        var divname = ''
        //if (compInformation.toString() == 'SKYDECOR LAMINATES PRIVATE LIMITED') {
        //    fieldname = 'sky_mobile';
        //    divname = 'skydecore';
        //}
        //else
        if (compInformation.toString() == 'JOHNSON PAINTS CO.') {
            fieldname = 'jpcpainter_mobile';

            divname = 'jpc';
        }
        else {
            fieldname = 'coats_mobile';

            divname = 'Coatsbathfitting';
        }
        //debugger;

        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=resendotp&mobile=' + $('#' + fieldname).val(),
            success: function (data) {
                //debugger;
                if (data == "success") {
                    $('#otpMsg2').text('OTP has been resent on your registered number.');
                    //$('#checkcode1').show();
                    //$('#checkcode').show();
                    $('#divOtpVerified2').show();
                    $('#warrenty').hide();
                }
                else if (data == "exceed") {
                    $('#p1msg2').text('You have exceeded your attempts, Please try again.');
                    $('#p1msg2:contains("exceeded")').css('color', 'red');
                    $('#msgcoats').show();
                    $('#' + divname).hide();
                    $('#divOtpVerified2').hide();
                    $('#divCompany').hide();
                    $('#checkcode').hide();
                }
                else {
                    $('#p1msg2').text('Unable send OTP, Please contact to system administrator');
                    $('#p1msg2:contains("Unable")').css('color', 'red');
                    $('#msgcoats').show();
                    $('#' + divname).hide();
                    $('#divOtpVerified2').hide();
                    $('#divCompany').hide();
                }
            }
        });
    });

    $('#purchasedate').datepicker({
        maxDate: new Date(),
        autoclose: true
    });
</script>

<div align="center" id="progress" style="display: none; position: fixed; left: 0px; height: 100%; width: 100%; z-index: 100001; background-color: #000; opacity: 0.65;" class="NewmodalBackground">
    <div style="margin-top: 300px;" align="center">
        <img alt="" src="Content/images/ajax-loader.gif" /><br />
        <span style="color: White;">Processing.....<br />
        </span>
    </div>
</div>

<!-- Vendor New design -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/jquery.appear/jquery.appear.min.js"></script>
<script src="vendor/jquery.easing/jquery.easing.min.js"></script>
<script src="vendor/jquery-cookie/jquery-cookie.min.js"></script>
<script src="vendor/popper/umd/popper.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="vendor/common/common.min.js"></script>
<script src="vendor/jquery.validation/jquery.validation.min.js"></script>
<script src="vendor/jquery.easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
<script src="vendor/jquery.gmap/jquery.gmap.min.js"></script>
<script src="vendor/jquery.lazyload/jquery.lazyload.min.js"></script>
<script src="vendor/isotope/jquery.isotope.min.js"></script>
<script src="vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
<script src="vendor/vide/vide.min.js"></script>

<!-- Theme Base, Components and Settings -->
<script src="js/theme.js"></script>

<!-- Current Page Vendor and Views -->
<script src="vendor/rs-plugin/js/jquery.themepunch.tools.min.js"></script>
<script src="vendor/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
<script src="vendor/circle-flip-slideshow/js/jquery.flipshow.min.js"></script>
<script src="js/views/view.home.js"></script>

<!-- Theme Custom -->
<script src="js/custom.js"></script>

<!-- Theme Initialization Files -->
<script src="js/theme.init.js"></script>

<!-- Examples -->
<script src="js/examples/examples.demos.js"></script>

<!-- End Vendor New design -->

<script src="../Content/js/toastr.min.js"></script>
<link href="../Content/css/toastr.min.css" rel="stylesheet" />


<link href="../Content/css/jquery-confirm.css" rel="stylesheet" />
<script src="../Content/js/jquery-confirm.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
    rel="stylesheet" />
<link href="Content/css/flexslider.css" rel='stylesheet' type='text/css' />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js" type="text/javascript"></script>

