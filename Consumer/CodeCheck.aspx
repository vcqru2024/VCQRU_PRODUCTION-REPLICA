<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CodeCheck.aspx.cs" Inherits="CodeCheck" %>

<%@ Register Src="~/Consumer/User_control/CheckYourCodes.ascx" TagPrefix="uc1" TagName="CheckYourCodes" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>VCQRU | We Secure You</title>
    <meta name="keywords" content="HTML5 Template" />
    <meta name="description" content="Porto - Responsive HTML5 Template" />
    <meta name="author" content="okler.net" />
    <!-- Favicon -->
    <link rel="shortcut icon" href="image/fave-icon.png" type="image/x-icon" />
    <link rel="apple-touch-icon" href="image/fave-icon.png" />
    <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, shrink-to-fit=no" />
    <!-- Web Fonts  -->
    <%--<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light%7CPlayfair+Display:400" rel="stylesheet" type="text/css" />--%>
    <!-- Vendor CSS -->
    
 <%--   <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../vendor/fontawesome-free/css/all.min.css" />
    <link rel="stylesheet" href="../vendor/animate/animate.min.css" />
    <link rel="stylesheet" href="../vendor/simple-line-icons/css/simple-line-icons.min.css" />
    <link rel="stylesheet" href="../vendor/owl.carousel/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="../vendor/owl.carousel/assets/owl.theme.default.min.css" />
    <link rel="stylesheet" href="../vendor/magnific-popup/magnific-popup.min.css" />
    <!-- Theme CSS -->
    <link rel="stylesheet" href="../css/theme.css" />
    <link rel="stylesheet" href="../css/theme-elements.css" />
    <link rel="stylesheet" href="../css/theme-blog.css" />
    <link rel="stylesheet" href="../css/theme-shop.css" />
    <!-- Current Page CSS -->
    <link rel="stylesheet" href="../vendor/rs-plugin/css/settings.css" />
    <link rel="stylesheet" href="../vendor/rs-plugin/css/layers.css" />
    <link rel="stylesheet" href="../vendor/rs-plugin/css/navigation.css" />
    <link rel="stylesheet" href="../vendor/circle-flip-slideshow/css/component.css" />--%>
      <link href="../assetsfrui/icon/icofont/css/icofont.css" rel="stylesheet" type="text/css"/>
	
      <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css"/>
      <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css"/>
      <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css"/>
    <!-- Demo CSS -->
    <!-- Skin CSS -->
    <!--link rel="stylesheet" href="css/skins/skin-corporate-19.css"-->
    <%--<link rel="stylesheet" href="../css/skins/default.css" />--%>
    <!-- Theme Custom CSS -->
    <%--<link rel="stylesheet" href="../css/custom.css" />--%>
    <!-- Head Libs -->
  <%--  <script src="../vendor/modernizr/modernizr.min.js"></script>
    <script src="../Content/js/jquery-1.11.1.min.js"></script>--%>
     <script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>
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
         <asp:HiddenField ID="mobilenumber" runat="server" />
    <asp:HiddenField ID="techninicianid" runat="server" />
    <asp:HiddenField ID="dealercode" runat="server" />
              <asp:HiddenField ID="code" runat="server" />
         <div class="theme-loader">
        <div class="loader-track">
            <div class="loader-bar"></div>
        </div>
    </div>
        <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">

        <nav class="navbar header-navbar pcoded-header">
               <div class="navbar-wrapper">
                   <div class="navbar-logo">
                       
                       <div class="mobile-search">
                           <div class="header-search">
                               <div class="main-search morphsearch-search">
                                   <div class="input-group">
                                       <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                                       <input type="text" class="form-control" placeholder="Enter Keyword">
                                       <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                                   </div>
                               </div>
                           </div>
                       </div>
					    <div class="menu_toogle" style="display:none;">
					   <i class="ti-menu"></i>
					   </div>
                       <a href="dashboard.aspx">
      <img class="img-fluid logo_img" src="../assetsfrui/images/auth/logo.png"  />
                       </a>
                       <a class="mobile-options">
                           <i class="ti-more"></i>
                       </a>
                   </div>

                   <div class="navbar-container container-fluid">
                       <ul class="nav-left">
                            <li class="active">
                                <%--<input type="file" id="camera" accept="image/*;capture=camera" style="display:none">--%>
								<a href="CodeCheck.aspx">Check Code</a>
                           </li>
                           <li >
								<a href="Dashboard.aspx">Dashboard</a>
                           </li>
                           <li>
								<a href="profile.aspx">Profile</a>
						
                           </li>
						    <li>
								<a href="transactions.aspx">Transactions</a>
                           </li>
						   
                       </ul>
                       <ul class="nav-right">
                          
                           <li class="user-profile header-notification">
                               <a href="#!">
                                   <asp:Image  runat="server" class="img-radius" alt="User-Profile-Image" id="top_profile_img" crossorigin="anonymous"
  referrerpolicy="no-referrer"/>
                                  <span><asp:Label ID="lblUser_name" runat="server" /></span>
                                   <i class="ti-angle-down"></i>
                               </a>
                              <ul class="show-notification profile-notification">
                                   <li>
                                       <a href="changepassword.aspx">
                                           <i class="ti-user"></i> Change Password
                                       </a>
                                   </li>
                                    <li>
                                         <a href="../index.html">     
                                         <i class="ti-layout-sidebar-left"></i> 
                                             <%--<asp:Button runat="server" BorderStyle="None" style="padding:0px; width:unset;    font-size: 16px; display:initial; margin-left:4px; font-family:sans-serif; cursor:pointer"  BackColor="Transparent" Text="Logout" OnClick="Logout" />--%>
                              Logout
                                         </a>
                                  
                                   </li>
                               </ul>
                           </li>
                       </ul>
                   </div>
               </div>
           </nav>
       <%--          start 
           --%>
           
           
                <div class="pcoded-wrapper">
                  
                    <div class="pcoded-content">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">

                                    <div class="page-body">
                                                                                  
                                           <uc1:CheckYourCodes runat="server" ID="CheckYourCodes" />
   
   
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
                                              
    <%--<div style="float:right; position:fixed; top:10px;right:10px; color:white"><a href="dashboard.aspx" style="color:white">Close</a></div>--%>

						
						
                                

</div>

</div>

</div>

</div>

</div>

</div>



                
            </div>

</div>
<%--end--%>
          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       
    </form>
 <script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>

<%--<script type="text/javascript" src="../assetsfrui/js/bootstrap.min.js"></script>--%>
 <%--<script type="text/javascript" src="../assets/js/jquery-slimscroll/jquery.slimscroll.js"></script>--%>
<script type="text/javascript" src="../assetsfrui/js/script.js"></script>
<script src="../assetsfrui/js/pcoded.min.js"></script>
<script src="../assetsfrui/js/vartical-demo.js"></script>
     
  </body>
</html>
<script type="text/javascript">
    $('#billNumber').on('change', function () {
        if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
            this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
        }
    });

    $('#purchasedate').on('change', function () {
        $('#purhase_label').hide();
            });
    $(document).ready(function () {
        $("#codeone").mask("99999-99999999");
        var queryString = location.search.substring(1);
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
                        $.ajax({
                            type: "POST",
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                                      success: function (data) {

                                          $.ajax({
                                              type: "POST",
                                              url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                        success: function (data) {
                            debugger;
                            if (data.split('&')[0] === "1") {
                                $('#p1msg').html(data.split('&')[3]);
                                $('#p1msg:contains("not")').css('color', 'red');
                                $('#checkcode1').show();
                                $('#warrenty').hide();
                                $('#warratyHeading').show();
                                $('#divCompany').hide();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[3] === "MS") {
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                            }
                            else if (data.split('&')[0] === "2") {
                                $('#chkGun').hide();
                                $('#warrenty').show();
                                $('#warratyHeading').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                               
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[3] === "MM") {
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').show();

                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else if (data.split('&')[1] === "MAHINDRA AND MAHINDRA LTD") {
                                $('#chkGun').hide();
                                $('#warrenty').hide();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').show();

                                $('#warratyHeading div').css('margin-top', "0px")
                                compInformation = data.split('&')[1];
                                $('#warratyHeading').show();
                                $('#warrantyMsg').text("Welcome " + data.split('&')[1]);
                                $("#imgWarrantyLogo").attr("src", data.split('&')[2].toString().replace('~', ''));
                            }
                            else {
                                $('#warrenty').hide();
                                $('#warratyHeading').hide();
                                $('#chkGun').show();
                                $('#checkcode').show();
                                $('#checkcode2').hide();
                                $('#divCompany').hide();
                            }
                        }
                    });
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
     });

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
    $(".mobile_number").focus(function () {
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
                if ($('#mobile1').val() != '' ) {
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
                    else if ($('#mobile1').val() == '9243029420') {
                        toastr.error("Please enter Your Mobile Number."); msg = "no";
                        $('#mobile1').show();
                        $('#checkcode').show();
                        $('#checkcode2').hide();
                        return false;
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
                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile1').val() + '&RefCd=' + $('#RefCd').val(),
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
                                $('#checkcode2').hide();
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
    $(".mobile_num").focus(function () {
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
                debugger;
                var code1;
                var code2;
                if ($('#codeone').val().includes("-")) {
                    var array = $('#codeone').val().split("-");
                     code1 = array[0];
                     code2 = array[1]
                }
                else {
                     code1= $('#codeone').val().substring(0, 5);

                    code2 = $('#codeone').val().substring(5, 13);
                }
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
                    else if ($('#mobile').val() == '9243029420') {
                        toastr.error("Please enter Your Mobile Number."); msg = "no";
                        $('#mobile1').show();
                        $('#checkcode').show();
                        $('#checkcode2').hide();
                        return false;
                    }
                    else {
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
                                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile').val() + '&RefCd=' + $('#RefCd').val(),
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
                                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + code1 + '&codetwo=' + code2 + '&mobile=' + $('#mobile').val() + '&RefCd=' + $('#RefCd').val(),
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
                                    $('#checkcode2').hide();
                                    flag = false;
                                },
                            });
                        }
                    }
                }
            }
        }
        //}
    });

    $('#btnWarranty').on('click', function () {
        var flag = true;
        var emailaddressVal = $("#emailAddress").val();
        var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

        if (!$('#emailAddress').valid()) {

            $('#emaillabelwarr').addClass('hide');
            $('#emailAddress-error').addClass('red');

            flag = false;
        }
        else {
            if (!emailReg.test(emailaddressVal)) {
                $('#emaillabelwarr').addClass('hide');
                $('#emailAddress-error').addClass('red');

                flag = false;
            }
        }

        //if (!$('#emailAddress').valid()) {
        //    $('#emaillabelwarr').addClass('hide');
        //    $('#emailAddress-error').addClass('red');
        //    flag = false;
        //}
         if (!$('#billNumber').valid()) {
            $('#bill_label').addClass('hide');
            $('#billNumber-error').addClass('red');
            flag = false;
        }
        if (!$('#purchasedate').valid()) {
            $('#purhase_label').addClass('hide');
             
            $('#purchasedate-error').addClass('red');
            flag = false;
        }
         if (!$('#img_bill').valid())
        {

            
             $('#img_bill-error').hide();
           alert("Upload a bill image first.")
            flag = false;
        }
        if(flag)
        {
            $("#btnWarranty").attr("disabled", true);
            var fd = new FormData();
            var files = $('#img_bill')[0].files[0];
            fd.append('file', files);
            var codes = $('#codeone').val();
            var datamsg = "";
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                data: fd,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&&codeone=' + codes.split('-')[0] + '&codetwo=' + codes.split('-')[1] + '&mobile=' + $('#warr_mobile').val(),
                success: function (data) {
                    datamsg = data;
                }
            });
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                data: fd,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=browsesave&email=' + $('#emailAddress').val() + '&mobile=' + $('#warr_mobile').val() + '&billno=' + $('#billNumber').val() + '&purchasedate=' + $('#purchasedate').val() + '&code=' + $('#codeone').val(),
                success: function (data) {

                    data = data + "<br/><br/>" + datamsg;
                    $('#p1msg').html(data);
                    $('#p1msg:contains("not")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#checkcode').hide();
                }
            });
        }
    });
    $("#autowarr_mobile").focus(function () {
    //$('#btnautoWarranty').on('click', function () {
        debugger;
        var flag = true;
        if (!document.querySelector('#autowarr_mobile').checkValidity()) {
            //$('#emaillabelwarr').addClass('hide');

            $('#mobilelabelwarr').addClass('red');
            flag = false;
        }

        if (flag) {
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
    });
    $('#btnCompany').on('click', function () {
        debugger;
        $('#btnCompany').attr("disabled", true);
        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val() + '&compName=' + compInformation.toString(),

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
    });

    $('#btnVerify').on('click', function () {
        debugger;
        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#MM_mobile').val() + '&verifycode=' + $('#mmOTP').val() + "&vCode=" + $('#codeone').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val(),
            success: function (data) {
                //debugger;
                if (data.split('~')[0] !== "failure") {
                    $('#p1msg').html(data.split('~')[1]);
                    $('#p1msg:contains("not")').css('color', 'red');
                    $('#checkcode').hide();
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#divOtpVerified').hide();
                }
                else {
                    $('#p1msg').text("OTP is not valid. Please provide the valid OTP");
                    $('#p1msg:contains("not")').css('color', 'red');
                    $('#checkcode1').show();
                    $('#warrenty').hide();
                    $('#divOtpVerified').hide();
                    $('#divCompany').hide();
                }
            }
        });
    });

    $('#btnResendOtp').on('click', function () {
        //debugger;
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
    $(function () {
        $('#purchasedate').datepicker({
            maxDate: new Date(),
            autoclose: true
        });
    });
    //$('.menu_toogle').click(function () {
    //    $('.nav-left').toggleClass('slide_show');
    //});
</script>

<div align="center" id="progress" style="display: none; position: fixed; left: 0px; height: 100%; width: 100%; z-index: 100001; background-color: #000; opacity: 0.65;" class="NewmodalBackground">
    <div style="margin-top: 300px;" align="center">
        <img alt="" src="../Content/images/ajax-loader.gif" /><br />
        <span style="color: White;">Processing.....<br />
        </span>
    </div>
</div>

<!-- Vendor New design -->
<%--<script src="../vendor/jquery/jquery.min.js"></script>--%>
<script src="../vendor/jquery.appear/jquery.appear.min.js"></script>
<script src="../vendor/jquery.easing/jquery.easing.min.js"></script>
<script src="../vendor/jquery-cookie/jquery-cookie.min.js"></script>
<script src="../vendor/popper/umd/popper.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="../vendor/common/common.min.js"></script>
<script src="../vendor/jquery.validation/jquery.validation.min.js"></script>
<script src="../vendor/jquery.easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
<script src="../vendor/jquery.gmap/jquery.gmap.min.js"></script>
<script src="../vendor/jquery.lazyload/jquery.lazyload.min.js"></script>
<script src="../vendor/isotope/jquery.isotope.min.js"></script>
<script src="../vendor/owl.carousel/owl.carousel.min.js"></script>
<script src="../vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
<script src="../vendor/vide/vide.min.js"></script>

<!-- Theme Base, Components and Settings -->
<script src="../js/theme.js"></script>

<!-- Current Page Vendor and Views -->
<script src="../vendor/rs-plugin/js/jquery.themepunch.tools.min.js"></script>
<script src="../vendor/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
<script src="../vendor/circle-flip-slideshow/js/jquery.flipshow.min.js"></script>
<script src="../js/views/view.home.js"></script>

<!-- Theme Custom -->
<script src="../js/custom.js"></script>

<!-- Theme Initialization Files -->
<script src="../js/theme.init.js"></script>

<!-- Examples -->
<script src="../js/examples/examples.demos.js"></script>

<!-- End Vendor New design -->

<script src="../Content/js/toastr.min.js"></script>
<link href="../Content/css/toastr.min.css" rel="stylesheet" />


<link href="../Content/css/jquery-confirm.css" rel="stylesheet" />
<script src="../Content/js/jquery-confirm.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
    rel="stylesheet" />
<link href="../Content/css/flexslider.css" rel='stylesheet' type='text/css' />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js" type="text/javascript"></script>

