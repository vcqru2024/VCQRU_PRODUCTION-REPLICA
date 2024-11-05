<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GetinTouch.ascx.cs" Inherits="UserControl_GetinTouch" %>
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>
<script src="../Content/js/toastr.min.js"></script>
<link href="../Content/css/toastr.min.css" rel="stylesheet" />
<script type="text/javascript">

    function getintouch() {
        $('#submitbtn').attr('disabled', true)
        toastr.clear();
        debugger;
        var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
        var page_name = location.pathname.split('/').slice(-1)[0].split('.')[0];
        var valid1 = emailReg.test($('#email').val());
        var phoneNumber = $('#phone').val();
        //var valid = true;


        var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

        if (filter.test(phoneNumber)) {
            if (phoneNumber.length == 10) {
                var c = phoneNumber.slice(0, 1);
                if (c <= 5) {
                    validate = false;
                    $('#submitbtn').attr('disabled', false)
                    toastr.error('Invalid Phone no!'); return false;
                }
                else
                    validate = true;
            } else {
                if (phoneNumber.length > 10) {
                    validate = false;
                    $('#submitbtn').attr('disabled', false)
                    toastr.error('Please put 10  digit Phone number');
                    return false;
                }
            }
        }
        else {
            validate = false;
            $('#submitbtn').attr('disabled', false)
            toastr.error('Invalid Phone no!'); return false;
        }
        if ($('#fname').val() == '') {
            $('#submitbtn').attr('disabled', false)
            toastr.error("First name can not be blank"); return false;

        }
        else if (phoneNumber.length < 10) {
            $('#submitbtn').attr('disabled', false)
            toastr.error('Invalid Phone no!'); return false;
        }
        else if ($('#lname').val() == '') {
            $('#submitbtn').attr('disabled', false)
            toastr.error("Last name can not be blank"); return false;
        }
        else if ($('#phone').val() == '') {
            $('#submitbtn').attr('disabled', false)
            toastr.error("Phone no. can not be blank"); return false;
        }
        else if ($('#message').val() == '') {
            $('#submitbtn').attr('disabled', false)
            toastr.error("Message can not be blank"); return false;
        }
        else if (!valid1) {
            $('#submitbtn').attr('disabled', false)
            toastr.error("Please enter the correct email."); return false;
        }

        else {
            $('#progress').show();
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=getintouch&email=' + $('#email').val() + '&phone=' + $('#phone').val() + '&fname=' + $('#fname').val() + '&lname= &message=' + $('#message').val() + '&requested=' + page_name,
                success: function (data) {
                    var result = data;
                    if (result.split('~')[0] != "Success") {
                        toastr.error(result);
                        $('#submitbtn').attr('disabled', false)
                    }
                    else {

                        toastr.success(result.split('~')[1]);
                        $('#email').val('');
                        $('#phone').val('');
                        $('#fname').val('');
                        $('#lname').val('');
                        $('#message').val('');
                        $('#submitbtn').attr('disabled', false);

                        location.href = "Thanks.aspx";
                    }
                },
            });
        }
    }
    function isNumber(evt, cntrl_id) {
        debugger;
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;

        //if ($('#' + cntrl_id).val().length == 0) {

        //    if (parseInt(evt.key) >= 6)
        //        return true;

        //}
        //else if (charCode >= 48 && charCode <= 57)
        //    return true;
        //if ($('#' + cntrl_id).val().length > 10) {

        //   return false;

        //}
        //if (charCode >= 96 && charCode <= 105) {
        //    return true;
        //}

        //if (charCode == 8)
        //    return true;
        //if (charCode == 46)
        //    return false;

        //return false;

        if ($('#' + cntrl_id).val().length == 0) {

            if (parseInt(evt.key) > 6)
                return true;

        }
        if ($('#' + cntrl_id).val().length > 10) {

            return false;

        }
        if (charCode >= 96 && charCode <= 105) {
            return true;
        }
        if (charCode >= 48 && charCode <= 57)
            return true;
        if (charCode == 8)
            return true;
        if (charCode == 46)
            return false;

        return false;
    }
</script>
<div class="card-body">
    <%--<form id="contact_form" class="col-form" action="#" method="post">--%>
    <div class="row">
        <div class="col-lg-12">
            <div class="form-group">
                <input type="text" class="form-control" id="fname" name="first_name" placeholder="First Name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)">
            </div>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <input type="text" class="form-control" id="lname" name="last_name" placeholder="Last Name" onkeydown="return /^[a-zA-Z ]*$/i.test(event.key)" onkeypress="return /^[a-zA-Z ]*$/i.test(event.key)">
            </div>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <input type="text" class="form-control" id="phone" name="phone" maxlength="10" placeholder="Phone" onkeypress="return isNumber(event,'phone')" onkeydown="return isNumber(event,'phone')">
            </div>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <input type="email" class="form-control" id="email" name="email" placeholder="Email">
            </div>
        </div>
        <div class="col-lg-12">
            <div class="form-group">
                <textarea class="form-control" rows="3" cols="3" id="message" placeholder="Your Message"></textarea>
            </div>
        </div>
        <div class="col-lg-12">
            <button type="button" class="theme-btn btn-white" id="submitbtn" onclick="getintouch()">
                <span>Submit</span>
            </button>
        </div>
    </div>

</div>



