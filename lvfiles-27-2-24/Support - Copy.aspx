<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNew.master" AutoEventWireup="true" CodeFile="Support.aspx.cs" Inherits="Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <style type="text/css">
        .vcqru_support {
            background: #fff;
            box-shadow: 0px 0px 10px grey;
            padding: 20px;
            margin: auto;
            margin-top: 50px;
            margin-bottom: 20px;
        }

        .connect-whatsapp {
            margin: auto;
            color: #007bff;
            font-family: sans-serif;
            font-size: 19px;
            border-bottom: 2px solid #007bff;
            width: 253px;
            /* padding-top: 5px; */
            padding-bottom: 5px;
            text-align: center;
        }

        .scanner-mobile-phone-margin {
            margin-top: 60px;
        }
    </style>

    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>
    <script src="../Content/js/toastr.min.js"></script>

    <script type="text/javascript">
        $("#aspnetForm").on("submit", function () {
            return false;
        });

        function sendcquery() {
            debugger;
            toastr.clear();
            if ($('#cname').val() == '') {
                toastr.error("Please enter Name"); msg = "no"; return false
            }
            else if (/[^a-zA-Z ]/.test($('#cname').val())) {
                toastr.error('Please enter correct Name');
                return false;
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="vcqru_support">
            <div class="row">
                <div class="col-md-6">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="scanner-mobile-phone" style="text-align: center;">
                                <img src="assets/images/whatsapp-logo.png" />
                            </div>

                        </div>
                    </div>
                    <h3 class="connect-whatsapp"><a href="https://api.whatsapp.com/send?phone=917669017720&text=&source=&data=" target="_blank">Connect with us on Whatsapp</a></h3>
                </div>
                <div class="col-md-6">
                    <div class="contact-formBox">
                        <div class="overflow-hidden mb-1">
                            <h2 class="font-weight-normal text-7 mt-2 mb-0 appear-animation animated maskUp appear-animation-visible text-primary" data-appear-animation="maskUp" data-appear-animation-delay="200" style="animation-delay: 200ms;">Contact Us</h2>
                        </div>
                        <div class="overflow-hidden mb-4 pb-3">
                            <p class="mb-0 appear-animation animated maskUp appear-animation-visible" data-appear-animation="maskUp" data-appear-animation-delay="400" style="animation-delay: 400ms;">Feel free to ask for details, don't save any questions!</p>
                        </div>

                        <form onsubmit="return false;" class="contact-form appear-animation animated fadeIn appear-animation-visible" data-appear-animation="fadeIn" data-appear-animation-delay="600" style="animation-delay: 600ms;">
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
                                    <input type="text" id="cname" placeholder="name" onkeyup="alphanumeric(this);" data-msg-required="Please enter your name." maxlength="50" class="form-control" />
                                </div>
                                <div class="form-group col-lg-6">
                                    <label class="required font-weight-bold text-dark">Email Address</label>
                                    <input type="email" id="cemail" placeholder="email" onfocus="this.value = '';" name="email" data-msg-required="Please enter your email." maxlength="50" class="form-control" />
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col">
                                    <label class="font-weight-bold text-dark">Mobile no</label>
                                    <input type="text" id="cmobile" placeholder="mobile No" onfocus="this.value = '';" data-msg-required="Please enter mobile no." maxlength="13" class="form-control" />
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
                                    <button type="button" onclick="sendcquery();" class="btn btn-primary btn-modern" data-loading-text="Loading...">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
