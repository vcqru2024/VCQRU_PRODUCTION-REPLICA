<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PFLlogin.ascx.cs" Inherits="PFLlogin" %>

<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap" rel="stylesheet">
<style>
    body {
        background: url(https://www.istockphoto.com/vector/bokeh-background-gm1162684930-318998606);
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;
    }

    .otplink {
        color: darkgreen !important;
        font-size: 14px !important;
        cursor: pointer;
        font-weight: 500;
    }
    .material-half-bg .cover {
    background-color: #91c49b;
    height: 50vh;
}

        .otplink:hover {
            text-decoration: underline !important;
        }

    .otplink_red {
        color: red !important;
        text-decoration: underline !important;
        font-size: 12px !important;
        cursor: pointer;
    }

    .otplink_red1 {
        color: red !important;
        text-decoration: underline !important;
        font-size: 12px !important;
        cursor: pointer;
    }

    .container1 {
        display: block;
        position: relative;
        padding-left: 32px !important;
        margin-bottom: 0px;
        cursor: pointer;
        font-size: 14px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        font-weight: 400;
        margin-right: 15px !important;
        line-height: 23px;
        text-transform: uppercase;
        margin-left: 5px;
    }

        /* Hide the browser's default checkbox */
        .container1 input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
            height: 0;
            width: 0;
            margin: 0px !important;
            width: 100%;
            height: 100%;
            left: 0px !important;
            top: 0px !important;
            z-index: 11111;
        }

    /* Create a custom checkbox */
    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 20px;
        width: 20px;
        background-color: white;
        border: 2px solid #e6e5e5;
        border-radius: 3px;
    }

    /* On mouse-over, add a grey background color */
    .container1:hover input ~ .checkmark {
        background-color: #ccc;
    }

    /* When the checkbox is checked, add a blue background */
    .container1 input:checked ~ .checkmark {
        background-color: white;
        border: 2px solid #0088cc;
    }

    /* Create the checkmark/indicator (hidden when not checked) */
    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    /* Show the checkmark when checked */
    .container1 input:checked ~ .checkmark:after {
        display: block;
    }

    /* Style the checkmark/indicator */
    .container1 .checkmark:after {
        left: 6px;
        top: 2px;
        width: 5px;
        height: 10px;
        border: solid #066594;
        border-width: 0 2px 2px 0;
        -webkit-transform: rotate(45deg);
        -ms-transform: rotate(45deg);
        transform: rotate(45deg);
    }

    .group {
        position: relative;
        margin-bottom: 0px;
        margin-top: 15px;
    }

        .group input {
            font-size: 18px;
            padding: 10px 10px 10px 5px;
            display: block;
            width: 100%;
            border: none;
            border-bottom: 1px solid #0a0a0a;
            background: transparent;
        }
        .cover {
    background-color: #ed1b24;
    height: 50vh;
}

    input:focus {
        outline: none;
    }

    /* LABEL ======================================= */
    label {
        color: #525252;
        font-size: 14px;
        font-weight: normal;
        position: absolute;
        pointer-events: none;
        left: 5px;
        top: 10px;
        transition: 0.2s ease all;
        -moz-transition: 0.2s ease all;
        -webkit-transition: 0.2s ease all;
        font-weight: 300;
        text-transform: uppercase;
    }

    /* active state */
    input:focus ~ label, input:valid ~ label {
        top: -8px;
        font-size: 14px;
        color: #5264AE;
    }

    /* BOTTOM BARS ================================= */
    .bar {
        position: relative;
        display: block;
        width: 100%;
    }

        .bar:before, .bar:after {
            content: '';
            height: 1px;
            width: 0;
            bottom: 0px;
            position: absolute;
            background: #5264AE;
            transition: 0.2s ease all;
            -moz-transition: 0.2s ease all;
            -webkit-transition: 0.2s ease all;
        }

        .bar:before {
            left: 50%;
        }

        .bar:after {
            right: 50%;
        }

    /* active state */
    input:focus ~ .bar:before, input:focus ~ .bar:after {
        width: 50%;
    }

    /* HIGHLIGHTER ================================== */
    .highlight {
        position: absolute;
        height: 60%;
        width: 100px;
        top: 25%;
        left: 0;
        pointer-events: none;
        opacity: 0.5;
    }

    /* active state */
    input:focus ~ .highlight {
        -webkit-animation: inputHighlighter 0.3s ease;
        -moz-animation: inputHighlighter 0.3s ease;
        animation: inputHighlighter 0.3s ease;
    }

    /* ANIMATIONS ================ */
    @-webkit-keyframes inputHighlighter {
        from {
            background: #e8f0fe;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    @-moz-keyframes inputHighlighter {
        from {
            background: #e8f0fe;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    @keyframes inputHighlighter {
        from {
            background: #5264AE;
        }

        to {
            width: 0;
            background: transparent;
        }
    }

    .Login_layout {
        max-width: 480px;
        width: 100%;
        padding: 2em 2em;
        margin: 0 auto;
        background: white;
        border: 1px dashed #81c4ff;
       /* margin: 4em auto;*/
        border-radius: 9px;
        box-shadow: 1px 1px 20px rgb(38 85 123);
        position: relative;
        z-index: 88;
        overflow: hidden;
        border-collapse: collapse;
    }

    header {
        display: none
    }

    .group input {
        font-size: 14px;
        padding: 10px 10px 10px 5px;
        display: block;
        width: 100%;
        border: none;
        border-bottom: 1px solid #a7a7a7;
        background: white;
    }

    .Register_form {
        transition: left 0.3s;
    }

    .hidepop {
        position: absolute;
        left: -400px;
    }

    .showpop {
        position: relative;
        left: 0px;
    }

    .login_form {
        transition: left 0.3s;
    }

    .register_pop {
        cursor: pointer;
    }

    .login_pop {
        cursor: pointer;
    }

    /*.layout-btn {
        color: #FFF !important;
    }*/
    .layout-btn {
    color: #FFF !important;
    padding: 5px 30px;
    font-size: 15px;
   }

    .forgetpas {
        color: darkgreen !important;
        font-weight: 500;
        cursor: pointer !important;
        font-size: 14px;
    }

        .forgetpas:hover {
            text-decoration: underline !important
        }
</style>
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>
<script src="../Content/js/toastr.min.js"></script>
<link href="../Content/css/toastr.min.css" rel="stylesheet" />

<script type="text/javascript">
    var rquestpage = ''; //UpdateProfile.aspx
    var usertypr = "user";


    $(document).ready(function () {
        debugger;
        $('.register_pop').click(function () {
            $('.login_form').addClass('hidepop').removeClass('showpop');
            $('.Register_form').addClass('showpop').removeClass('hidepop').show();
            chkforusersignup("user");
        });
        $('.login_pop').click(function () {
            $('.Register_form').addClass('hidepop').removeClass('showpop');
            $('.login_form').addClass('showpop').removeClass('hidepop');
        });

        chkforuser();
        doSomething();
        getQueryStrings2();
        $('#divvendor').hide();
        chkforusersignup("user");
        doSomething2();
        $('#divEmployee').hide();
        doSomethingEmp();
        getQueryStrings3();

        $('#login_txt_idC').bind("cut copy paste", function (e) {
            e.preventDefault();
        });

    });

    function doSomethingEmp() {
        var EquixUserName = $.cookie('EquixUserNameEmp');
        var EquixPassword = $.cookie('EquixPasswordEmp');
        if (EquixUserName != null && EquixPassword != null || EquixUserName != undefined && EquixPassword != undefined) {
            $('#login_txt_idEmp').val(EquixUserName);
            $('#login_txt_passEmp').val(EquixPassword);
            $("#chkRememberMeEmp").prop("checked", true);
            //alert($('#login_txt_id').val());
        }
        else {
        }
    }

    function doSomething2() {
        var EquixUserName = $.cookie('ConsumerUserName');
        var EquixPassword = $.cookie('ConsumerPassword');
        if (EquixUserName != null && EquixPassword != null || EquixUserName != undefined && EquixPassword != undefined) {
            $('#login_txt_idC').val(EquixUserName);
            $('#login_txt_passC').val(EquixPassword);
            $("#chkRememberMeC").prop("checked", true);
        }
        else {
        }
    }

    function doSomething() {

        var EquixUserName = $.cookie('EquixUserName');
        var EquixPassword = $.cookie('EquixPassword');
        if (EquixUserName != null && EquixPassword != null || EquixUserName != undefined && EquixPassword != undefined) {
            $('#login_txt_id').val(EquixUserName);
            $('#login_txt_pass').val(EquixPassword);
            $("#chkRememberMe").prop("checked", true);
            //alert($('#login_txt_id').val());
        }
        else {
        }
    }

    function getQueryStrings3() {
        var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
        var queryString = location.search.substring(1);
        var keyValues = queryString.split('&');
        var urlusertype = keyValues[0];
        if (keyValues.length > 1) {
            for (var i in keyValues) {
                var key = keyValues[i].split('=');
                if (key[1] == "Page") {
                    rquestpage = key[1];
                }
                if (key[1] == "usertype") {
                    usertypr = key[1];
                }
            }
        }
    }

    function login() {
        toastr.clear();
        if ($('#login_txt_id').val() == '') {
            toastr.error("Please enter Email Address !");
        } else {
            if ($('#login_txt_pass').val() == '') {
                toastr.error("Please enter password !");
            }
            else {
                var Userid = $('#login_txt_id').val();
                var Password = $('#login_txt_pass').val();
                var Remember = 0;
                if ($("#chkRememberMe").is(":checked") == true) {
                    Remember = 1;
                }
                if ($("#chkRememberMe").is(":checked") == false) {
                    Remember = 2;
                }

                $('#progress').show();

                <%--var vendorlogin = '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=login&remember=' + Remember + '&userid=' + Userid + '&pass=' + Password;
                console.log(vendorlogin);--%>
                debugger;
                $.ajax({
                    type: "POST",
                    //contentType: false,
                    //processData: false,
                    //data: loginData,

                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=login&userid=' + Userid + '&pass=' + Password + '&rememberme=' + Remember,
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (resut == 1) {
                            toastr.error("Invalid Email Address or Password !");
                        }
                        if (resut == 2) {
                            toastr.error("Your account has been deleted permanently, please contact to admin.");
                        }
                        if (resut == 3) {
                            toastr.error("Invalid Email Address or Password !");
                        }
                        if (resut == 4) {
                            if (usertypr == "user") {
                                if (rquestpage == "") {
                                    page = "frmManfEnquiry.aspx";
                                }
                                else {
                                    // page = rquestpage;
                                    page = "frmManfEnquiry.aspx";
                                }
                                window.location.href = "../Manufacturer/" + page;
                            }
                        }
                        if (resut == 5) {
                            if (usertypr == "user") {
                                if (rquestpage != "") {
                                    page = rquestpage;
                                }
                                else {
                                    page = "frmUploadDocuments.aspx";
                                }
                                window.location.href = "../Manufacturer/" + page;
                            }
                        }
                        if (resut == 6) {
                            if (usertypr == "user") {
                                if (rquestpage != "") {
                                    page = rquestpage;
                                }
                                else {
                                    page = "Message.aspx";
                                }
                                window.location.href = "../Manufacturer/" + page;
                            }
                        }
                        $('#progress').hide();
                    },
                });
            }
        }
    }

    function loginEmp() {
        toastr.clear();
        if ($('#login_txt_idEmp').val() == '') {
            toastr.error("Please enter Email Address !");
        } else {
            if ($('#login_txt_passEmp').val() == '') {
                toastr.error("Please enter password !");
            }
            else {
                var Userid = $('#login_txt_idEmp').val();
                var Password = $('#login_txt_passEmp').val();
                var Remember = 0;
                if ($("#chkRememberMeEmp").is(":checked") == true) {
                    Remember = 1;
                }
                if ($("#chkRememberMeEmp").is(":checked") == false) {
                    Remember = 2;
                }
                //    alert(Userid + '  ,  ' + Password + '  ,  ' + Remember);
                $('#progress').show();
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=loginEmp&userid=' + Userid + '&pass=' + Password + '&rememberme=' + Remember,
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (resut == 3) {
                            toastr.error("Invalid Email Address or Password !");
                        }
                        if (resut == 2) {
                            toastr.error("Your account has been deleted permanently, please contact to admin.");
                        }
                        if (resut == 5) {
                            toastr.error("Invalid Email Address or Password !");
                        }
                        if (resut == 1) {
                            //if (usertypr == "user") {
                            //    if (rquestpage == "") {
                            //        page = "CompProfile.aspx";
                            //    }
                            //    else {
                            //        page = rquestpage;
                            //    }
                            window.location.href = "../Employee/UpdateProfile.aspx";
                            //alert(window.location);
                            //}
                        }
                        //if (resut == 5) {
                        //    if (usertypr == "user") {
                        //        if (rquestpage != "") {
                        //            page = rquestpage;
                        //        }
                        //        else {
                        //            page = "frmUploadDocuments.aspx";
                        //        }
                        //        window.location.href = "../Manufacturer/" + page;
                        //    }
                        //}
                        //if (resut == 6) {
                        //    if (usertypr == "user") {
                        //        if (rquestpage != "") {
                        //            page = rquestpage;
                        //        }
                        //        else {
                        //            page = "Message.aspx";
                        //        }
                        //        window.location.href = "../Manufacturer/" + page;
                        //    }
                        //}
                        $('#progress').hide();
                    },
                });
            }
        }
    }

    function Adminlogin() {
        toastr.clear();
        if ($('#login_txt_id').val() == '') {
            toastr.error("Please enter valid Email Address  !");
        } else {
            if ($('#login_txt_pass').val() == '') {
                toastr.error("Please enter password !");
            }
            else {
                var Userid = $('#login_txt_id').val();
                var Password = $('#login_txt_pass').val();
                $('#progress').show();
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=Adminlogin&userid=' + Userid + '&pass=' + Password,
                    success: function (data) {
                        // alert('');
                        $('#progress').hide();
                        var page = "";
                        var resut = data;
                        if (resut == 1) {
                            if (usertypr == "Admin") {
                                if (rquestpage == "") {
                                    page = "Dashboard.aspx";
                                }
                                else {
                                    page = rquestpage;
                                }
                                window.location.href = "../Admin/" + page;
                            }
                            else {
                                window.location.href = "../Admin/Dashboard.aspx";
                            }
                        }
                        else if (resut == 2) {
                            toastr.error("Invalid user id or password !");
                        }

                    },
                    error: function () {
                        //alert('erro');
                        $('#progress').hide();
                        //$(".message").text(returnval + " failure");
                        //$(".message").fadeIn("slow");
                        //$(".message").delay(2000).fadeOut(1000);
                    },

                });
            }
        }
    }

    function subscribenewsletter() {
        toastr.clear();
        if ($('#txtSend1').val() == '') {
            toastr.error("Please enter valid Email Address");
            msg = "no";
            return false
        }
        if ($('#txtSend1').val() != '') {
            var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            var valid = emailReg.test($('#txtSend1').val());
            if (!valid) {
                toastr.error("Please enter valid Email Address "); return false;
            }
            else {
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=forgotpassword&email=' + $('#txtSend1').val(),
                    success: function (data) {
                        $('#txtSend1').val('');
                        toastr.info(data);
                    },
                });
            }
        }
    }

    function subscribenewsletterEmp() {
        toastr.clear();
        if ($('#txtSendEmp').val() == '') {
            toastr.error("Please enter valid Email Address"); msg = "no"; return false
        }
        if ($('#txtSend1').val() != '') {
            var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            var valid = emailReg.test($('#txtSendEmp').val());
            if (!valid) {
                toastr.error("Please enter valid Email Address "); return false;
            }
            else {
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=forgotpasswordEmp&email=' + $('#txtSendEmp').val(),
                    success: function (data) {
                        $('#txtSend1').val('');
                        toastr.info(data);
                    },
                });
            }
        }
    }

    function chkforEmp(strval) {
        $("#chkuser").prop("checked", false);
        $("#chkadmin").prop("checked", false);
        $("#chkEmp").prop("checked", false);
        $('#divEndUser').hide();
        $('#divvendor').hide();
        $('#divEmployee').hide();
        if (strval == 'user') {
            $("#chkuser").prop("checked", true);
            $('#divEndUser').show();
        }
        if (strval == 'vendor') {
            $("#chkadmin").prop("checked", true);
            $('#divvendor').show();
        }
        if (strval == 'emp') {
            $("#chkEmp").prop("checked", true);
            $('#divEmployee').show();
        }

        //  getQueryStrings2();
        //$("#chkadmin").prop("checked", true);
        //$("#chkuser").prop("checked", false);
        //$('#divvendor').show();
        //$('#divEndUser').hide();
        //doSomething();
        // $('#btnadmin').show();
        // $('#btnuser').hide();
        //$('#login_txt_id').val('');
        //$('#login_txt_pass').val('');
    }
    function chkforusersignup(strval) {
        $("#chkusersignup").prop("checked", false);
        $("#chkadminsignup").prop("checked", false);
        $("#chkEmpsignup").prop("checked", false);
        $('#divEndUsersignup').hide();
        $('#divvendorsignup').hide();
        $('#divEmpUsersignup').hide();
        if (strval == 'user') {
            $("#chkusersignup").prop("checked", true);
            $('#divEndUsersignup').show();
        }
        if (strval == 'vendor') {
            $("#chkadminsignup").prop("checked", true);
            $('#divvendorsignup').show();
        }
        if (strval == 'emp') {
            $("#chkEmpsignup").prop("checked", true);
            $('#divEmpUsersignup').show();
        }

    }

    //function chkforusersignup() {
    //    $("#chkusersignup").prop("checked", true);
    //    $("#chkadminsignup").prop("checked", false);
    //    $('#divEndUsersignup').show();
    //    $('#divvendorsignup').hide();
    //    //  $('#btnadmin').hide();
    //    //  $('#btnuser').show();
    //    doSomething2();
    //}
    //function chkforadmin() {

    //  //  getQueryStrings2();
    //    $("#chkadmin").prop("checked", true);
    //    $("#chkuser").prop("checked", false);
    //    $('#divvendor').show();
    //    $('#divEndUser').hide();
    //    //doSomething();
    //   // $('#btnadmin').show();
    //   // $('#btnuser').hide();
    //    //$('#login_txt_id').val('');
    //    //$('#login_txt_pass').val('');
    //}
    function chkforuser() {
        $("#chkuser").prop("checked", true);
        $("#chkadmin").prop("checked", false);
        $('#divEndUser').show();
        $('#divvendor').hide();
        //  $('#btnadmin').hide();
        //  $('#btnuser').show();
        //doSomething();
    }
    //function chkforadminsignup() {
    //    $("#chkadminsignup").prop("checked", true);
    //    $("#chkusersignup").prop("checked", false);
    //    $('#divvendorsignup').show();
    //    $('#divEndUsersignup').hide();
    //    // $('#btnadmin').show();
    //    // $('#btnuser').hide();
    //    $('#login_txt_idC').val('');
    //    $('#login_txt_passC').val('');
    //}

    function forgotpassword() {
        $('#fgtpawd').show();
        $('#trylogin').hide();
    }
    function loginshow() {
        $('#fgtpawd').hide();
        $('#trylogin').show();
    }
    function loginshowEmp() {
        $('#fgtpawdEmp').hide();
        // $('#fgtpawd').hide();
        $('#trylogin').show();
    }
</script>


<script type="text/javascript">
    ///////////////////////////////////////////////////////
    var cnt = 0;
    var mblno;
    function otpsend() {
        toastr.clear();
        if ($('#login_txt_idC').val() != mblno) {
            cnt = 0;
            mblno = $('#login_txt_idC').val()
        }

        if (cnt < 3) {
            $('#otp_link').removeClass('otplink');
            $('#otp_link').addClass('otplink_red');
            $.ajax({
                type: "POST",
                contentType: false,
                processData: false,
                //url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=savecompany&mobile=' + $('#MM_mobile').val() + + '&proID=' + $('#productID').val() + '&empId=' + $('#empID').val() + '&disId=' + $('#distributorID').val() + '&code=' + $('#codeone').val()+ '&compName=' + compInformation.toString(),
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=otpsend&mobile=' + $('#login_txt_idC').val(),
                success: function (data) {
                    //alert(data);
                    if (data == "2") {
                        toastr.error("Sorry! You are not Registered with us.");

                    }
                    else {
                        //$('#password_otp').html("OTP");
                        debugger;
                        $('#otp_link').removeClass('otplink_red');
                        $('#otp_link').addClass('otplink_red1');
                        cnt = parseInt($('#counter').html());
                        $('#counter').html(cnt + 1);
                    }

                }
            });
        }
        else {
            toastr.error("Sorry! You have reached the maximum limit for requesting an OTP. Please try again later.");
        }
    };
    ////////////////////////////////////////////////////////
    function getQueryStrings2() {
        var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };

        var queryString = location.search.substring(1);
        var keyValues = queryString.split('&');
        for (var i in keyValues) {
            var key = keyValues[i].split('=');
            if (key.length > 1) { rquestpage = key[1]; }
            else { }
        }
    }

    function Register() {
        debugger
        toastr.clear();
        var Name = $('#reg_txt_name').val();
        var email = $('#reg_txt_id').val();
        var mobile = $('#reg_txt_Mobile').val();
        var City = ""; //$('#reg_txt_city').val();
        var Pin = "";// $('#reg_txt_pin').val();
        var pwd = $('#reg_txt_pwd').val();
        var cpwd = $('#reg_txt_Cfpwd').val();
        if (Name == '') {
            toastr.error("Enter your Name !");
        }
        else {
            if (email == '') {
                toastr.error("Enter Email Address !");
            }
            else {
                var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                var valid = emailReg.test(email);
                if (!valid) {
                    toastr.error("Please enter the correct email."); return false;
                }
                else {
                    if (mobile == '') {
                        toastr.error("Please enter mobile no."); return false;
                    }
                    else {
                        var v = mobile.length;
                        if (v < 10 && v > 12) {
                            toastr.error("Please enter correct Mobile Number."); return false;
                        }
                        else {
                            //if (City == '') {
                            //    toastr.error("Please enter your city."); return false;
                            //}
                            //else {
                            //    if (Pin == '') {
                            //        toastr.error("Please enter your area pin"); return false;
                            //    }
                            // else {
                            if (pwd == '') {
                                toastr.error("Please enter password"); return false;
                            }
                            else {
                                if (cpwd == '') {
                                    toastr.error("Please enter Confirm Password"); return false;
                                }
                                else {
                                    if (pwd != cpwd) {
                                        toastr.error("Password not match"); return false;
                                    }
                                    else {
                                        $('#progress').show();
                                        $.ajax({
                                            type: "POST",
                                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=ConsumerRegister&Name=' + Name + '&email=' + email + '&mobile=' + mobile + '&City=' + City + '&Pin=' + Pin + '&pwd=' + pwd,
                                            success: function (data) {
                                                $('#progress').hide();
                                                toastr.success(data);
                                                $('#reg_txt_name').val('');
                                                $('#reg_txt_id').val('');
                                                $('#reg_txt_Mobile').val('');
                                                $('#reg_txt_city').val('');
                                                $('#reg_txt_pin').val('');
                                                $('#reg_txt_pwd').val('');
                                                $('#reg_txt_Cfpwd').val('');
                                            },
                                        });
                                    }
                                }
                            }
                        }
                        //  }
                        //}
                    }
                }
            }
        }
    }


    function RegisterEmp() {
        toastr.clear();
        var EmpType = $('#dropdownid').val();
        var Name = $('#reg_txt_nameEmp').val();
        var email = $('#reg_txt_idEmp').val();
        var mobile = $('#reg_txt_MobileEmp').val();
        var City = ""; //$('#reg_txt_city').val();
        var Pin = "";// $('#reg_txt_pin').val();
        var pwd = $('#reg_txt_CfpwdEmp').val();
        var cpwd = $('#reg_txt_pwdEmp').val();
        if (EmpType == "0") {
            toastr.error("Please select Employee Type!");
            return;
        }
        if (Name == '') {
            toastr.error("Enter your Name !");
        }
        else {
            if (email == '') {
                toastr.error("Enter Email Address !");
            }
            else {
                var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                var valid = emailReg.test(email);
                if (!valid) {
                    toastr.error("Please enter the correct email."); return false;
                }
                else {
                    if (mobile == '') {
                        toastr.error("Please enter mobile no."); return false;
                    }
                    else {
                        var v = mobile.length;
                        if (v < 10 && v > 12) {
                            toastr.error("Please enter correct Mobile Number."); return false;
                        }
                        else {
                            //if (City == '') {
                            //    toastr.error("Please enter your city."); return false;
                            //}
                            //else {
                            //    if (Pin == '') {
                            //        toastr.error("Please enter your area pin"); return false;
                            //    }
                            // else {
                            if (pwd == '') {
                                toastr.error("Please enter password"); return false;
                            }
                            else {
                                if (cpwd == '') {
                                    toastr.error("Please enter Confirm Password"); return false;
                                }
                                else {
                                    if (pwd != cpwd) {
                                        toastr.error("Password not match"); return false;
                                    }
                                    else {
                                        $('#progress').show();
                                        $.ajax({
                                            type: "POST",
                                            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=EmployeeRegister&Etype=' + EmpType + '&Name=' + Name + '&email=' + email + '&mobile=' + mobile + '&City=' + City + '&Pin=' + Pin + '&pwd=' + pwd,
                                            success: function (data) {
                                                $('#progress').hide();
                                                toastr.success(data);
                                                $("#dropdownid").val("0");
                                                $('#reg_txt_nameEmp').val('');
                                                $('#reg_txt_nameEmp').val('');
                                                $('#reg_txt_idEmp').val('');
                                                $('#reg_txt_MobileEmp').val('');
                                                //$('#reg_txt_city').val('');
                                                //$('#reg_txt_pin').val('');
                                                $('#reg_txt_pwdEmp').val('');
                                                $('#reg_txt_CfpwdEmp').val('');
                                            },
                                        });
                                    }
                                }
                            }
                        }
                        //  }
                        //}
                    }
                }
            }
        }
    }

    function CheckEmailid(strType) {
        $('#progress').show();
        var strvalue = $('#reg_txt_id').val();
        if (strType == 'user') {
            strvalue = $('#reg_txt_id').val();
        }
        else if (strType == 'vendor') {
            strvalue = $('#login_txt_EmailR').val();
        }
        else if (strType == 'emp') {
            strvalue = $('#reg_txt_idEmp').val();
        }

        $.ajax({
            type: "POST",
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=checkconsumer&type=Email&value=' + strvalue + '&Utype=' + strType,
            success: function (data) {
                var result = data;
                if (result != "") {
                    if (strType == 'user') {
                        $('#reg_txt_id').val('');
                    }
                    else if (strType == 'vendor') {
                        $('#login_txt_EmailR').val('');
                    }
                    else if (strType == 'emp') {
                        $('#reg_txt_idEmp').val('');

                    }
                    toastr.info(result);
                }
                $('#progress').hide();
            },
        });
    }

    function CheckMobileNo(strType) {
        toastr.clear();
        var strvalue = $('#reg_txt_Mobile').val();
        var v = $('#reg_txt_Mobile').val().length;

        if (strType == 'user') {
            strvalue = $('#reg_txt_Mobile').val();
            v = $('#reg_txt_Mobile').val().length;
        }
        else if (strType == 'vendor') {
            strvalue = $('#login_txt_MobileNoR').val();
            v = $('#login_txt_MobileNoR').val().length;
        }
        else if (strType == 'emp') {
            strvalue = $('#reg_txt_MobileEmp').val();
            v = $('#reg_txt_MobileEmp').val().length;
        }

        if (v < 10 && v > 12) {
            toastr.error("Please enter correct Mobile Number."); return false;
        }
        else {
            $('#progress').show();
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=checkconsumer&type=Mobile&value=' + strvalue + '&Utype=' + strType,
                success: function (data) {
                    var result = data;
                    if (result != "") {
                        if (strType == 'user') {
                            $('#reg_txt_Mobile').val('');
                        }
                        else if (strType == 'vendor') {
                            $('#login_txt_MobileNoR').val('');
                        }
                        else if (strType == 'emp') {
                            $('#reg_txt_MobileEmp').val('');
                        }
                        toastr.info(result);
                    }
                    $('#progress').hide();
                },
            });
        }
    }

    $(document).ready(function () {
        $("#login_txt_passC").keyup(function (event) {
            if (event.keyCode === 13) {
                $("#btnUserLogin").click();
            }
        });
        $("#login_txt_pass").keyup(function (event) {
            if (event.keyCode === 13) {
                $("#btnVendor").click();
            }
        });
    });


    function login2() {
        toastr.clear();

        if ($('#login_txt_idC').val() == '') {
            toastr.error("Please enter the mobile no !");
        } else {
            if ($('#login_txt_passC').val() == '') {
                toastr.error("Please enter the password !");
            }
            else {
                var Userid = $('#login_txt_idC').val();
                var Password = $('#login_txt_passC').val();

                var Remember = 0;
                if ($("#chkRememberMeC").is(":checked") == true) {
                    Remember = 1;
                }
                if ($("#chkRememberMeC").is(":checked") == false) {
                    Remember = 2;
                }
                if ($('#otp_link').attr('class') == 'otplink_red1') {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                        //data: userData,

                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=web_OTPVerify&mobile=' + Userid + '&verifycode=' + Password,
                        success: function (data) {
                            $('#progress').hide();
                            var page = "";
                            var resut = data;
                            if (resut != "Success") {
                                toastr.error(resut);
                            }
                            else {
                                //debugger;
                                //alert('');
                                //if (rquestpage == '' && rquestpage == 'undefined') {
                                //    page = "UpdateProfile.aspx";
                                //}
                                //else {
                                //    page = rquestpage;
                                //}
                                // window.location.href = "../Consumer/UpdateProfile.aspx";
                                window.location.href = "../Consumer/Dashboard.aspx?";
                                //alert(window.location.href);
                            }

                        },
                    });

                }
                else {
                    //userData = { "userid": Userid, "pass": Password, "remember": Remember };
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,
                        //data: userData,
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=consumerlogin&userid=' + Userid + '&pass=' + Password + '&remember=' + Remember,
                        success: function (data) {
                            //alert(data);
                            debugger
                            $('#progress').hide();
                            var page = "";
                            var resut = data;
                            if (resut.includes("success")) {
                                window.location.href = "../Consumer/Dashboard.aspx?";


                            }
                            else {

                                toastr.error(resut);

                            }

                        },
                    });
                }

            }
        }
    }

    function subscribenewsletter2() {
        toastr.clear();
        if ($('#mobileno').val() == '') {
            toastr.error("Please enter your Mobile No."); msg = "no"; return false
        }
        if ($('#mobileno').val() != '') {
            debugger;
            var v = $('#mobileno').val().length;
            if (v < 10 && v > 12) {
                toastr.error("Please enter the correct Mobile No."); return false;
            }
            else {
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=Consumerforgotpassword&mobile=' + $('#mobileno').val(),
                    success: function (data) {
                        $('#mobileno').val('');
                        $('#fgtpawd').hide();
                        $('#fgtpawdC').hide();
                        $('#trylogin').show();
                        toastr.info(data);
                    },
                });
            }
        }
    }

    function forgotpassword2() {

        $('#fgtpawdC').show();
        $('#trylogin').hide();
    }
    function forgotpasswordEmp() {
        $('#fgtpawdEmp').show();
        $('#trylogin').hide();
    }
    function loginshow2() {
        $('#fgtpawdC').hide();
        $('#trylogin').show();
    }
</script>

<style type="text/css">
    .col-md-6.login-right {
        border: 2px solid #eee;
    }

    span.m_25 {
        color: #000;
        font-size: 0.8125em;
    }
    #carouselExampleControls .carousel-item img{
        position: relative;
        filter: brightness(0.5);
    }
    #carouselExampleControls .carousel-item p{
        position: absolute;
        bottom: 0;
        color: #fff;
        padding: 23px;
        font-size: 18px;
        font-weight: 600;
    }
</style>
<%--Register script--%>
<script type="text/javascript">

    function RegisterVendor() {
        toastr.clear();
        var comp = $('#login_txt_CompanyNmR').val();
        var contactpersion = $('#login_txt_ContactPR').val();
        var email = $('#login_txt_EmailR').val();
        var mobile = $('#login_txt_MobileNoR').val();
        if ($('#login_txt_CompanyNmR').val() == '') {
            toastr.error("Enter Company Name !");
        }
        else {
            if ($('#login_txt_ContactPR').val() == '') {
                toastr.error("Enter Contact Person Name !");
            }
            else {
                if ($('#login_txt_EmailR').val() == '') {
                    toastr.error("Enter Email Address !");
                }
                else {
                    var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                    var valid = emailReg.test($('#login_txt_EmailR').val());
                    if (!valid) {
                        toastr.error("Please enter the correct email."); return false;
                    }
                    else {
                        if ($('#login_txt_MobileNoR').val() == '') {
                            toastr.error("Please enter mobile no."); return false;
                        }
                        else {
                            var v = $('#login_txt_MobileNoR').val().length;
                            if (v != 10) {
                                toastr.error("Please enter correct Mobile Number."); return false;
                            }
                            else {
                                $('#progress').show();
                                $.ajax({
                                    type: "POST",
                                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=register&company=' + comp + '&contactpersion=' + contactpersion + '&email=' + email + '&mobile=' + mobile,
                                    success: function (data) {
                                        $('#progress').hide();
                                        toastr.success(data);
                                        $('#login_txt_CompanyNmR').val("");
                                        $('#login_txt_ContactPR').val("");
                                        $('#login_txt_EmailR').val("");
                                        $('#login_txt_MobileNoR').val("");
                                    },
                                });
                            }
                        }
                    }
                }
            }
        }
        //$('#progress').hide();
    }


    function demoRegister() {
        toastr.clear();
        var comp = $('#login_txt_CompanyNm1').val();
        var contactpersion = $('#login_txt_ContactP1').val();
        var email = $('#login_txt_Email1').val();
        var mobile = $('#login_txt_MobileNo1').val();
        if ($('#login_txt_CompanyNm1').val() == '') {
            toastr.error("Enter Company Name !");
        }
        else {
            if ($('#login_txt_ContactP1').val() == '') {
                toastr.error("Enter Contact Person Name !");
            }
            else {
                if ($('#login_txt_Email1').val() == '') {
                    toastr.error("Enter Email Address !");
                }
                else {
                    var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                    var valid = emailReg.test($('#login_txt_Email1').val());
                    if (!valid) {
                        toastr.error("Please enter the correct email."); return false;
                    }
                    else {
                        if ($('#login_txt_MobileNo1').val() == '') {
                            toastr.error("Please enter mobile no."); return false;
                        }
                        else {
                            var v = $('#login_txt_MobileNo1').val().length;
                            if (v != 10) {
                                toastr.error("Please enter correct Mobile Number."); return false;
                            }
                            else {
                                $('#progress').show();
                                $.ajax({
                                    type: "POST",
                                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=demoreegister&company=' + comp + '&contactpersion=' + contactpersion + '&email=' + email + '&mobile=' + mobile,
                                    success: function (data) {
                                        $('#progress').hide();
                                        toastr.success(data);
                                        $('#login_txt_CompanyNm1').val("");
                                        $('#login_txt_ContactP1').val("");
                                        $('#login_txt_Email1').val("");
                                        $('#login_txt_MobileNo1').val("");
                                    },
                                });
                            }
                        }
                    }
                }
            }
        }
    }

    function DemoRegister() {
        toastr.clear();
        if ($('#Packetsecretcode').val() == '') {
            toastr.error("Please Enter Packet Secret Code !");
        }
        else {
            $('#progress').show();
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=DemoPackeageCode&code=' + $('#Packetsecretcode').val(),
                success: function (data) {
                    debugger;
                    var result = data;
                    var values = result.split('#');
                    if (values.length > 1) {
                        $('#login_txt_Email1').val(values[0]);
                        $('#login_txt_CompanyNm1').val(values[1]);
                        $('#login_txt_ContactP1').val(values[2]);
                        $('#login_txt_MobileNo1').val(values[3]);
                        $('#progress').hide();
                        $('#demoregister').hide();
                        $('#registerdiv').show();
                    }
                    else {
                        toastr.error(result);
                        $('#Packetsecretcode').val("");
                        $('#progress').hide();
                    }

                },
            });
        }
    }
    function CheckEmailid123() {

        toastr.clear();
        var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
        var valid = emailReg.test($('#login_txt_EmailR').val());
        if (!valid) {
            $('#progress').hide();
            toastr.error("Please enter the correct email."); return false;
        }
        else {
            $('#progress').show();
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=CheckEmailid&email=' + $('#login_txt_EmailR').val(),
                success: function (data) {
                    var result = data;
                    if (result == "Email ID Already Registered!") {
                        $('#progress').hide();
                        $('#login_txt_EmailR').val('');
                        $('#login_txt_EmailR').focus();
                        toastr.error(result);
                    }
                    else {
                        $('#progress').hide();
                        toastr.success(result);
                    }
                },
            });
        }
    }

    function validate(evt) {
        toastr.clear();
        var theEvent = evt || window.event; var key = theEvent.keyCode || theEvent.which; key = String.fromCharCode(key);
        var regex = /[0-9]|\./;
        if (!regex.test(key)) {
            theEvent.returnValue = false; toastr.error("Input is not Numeric \n Enter numbers only (Like 0 to 9) Or select the letter and press delete button to remove");
            if (theEvent.preventDefault)
                theEvent.preventDefault();
        }
    }
</script>
 
<label id="counter" style="display: none">0</label>

<section class="material-half-bg" style:"background: #186c38;">
    <div class="cover">
        <div class="row">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg p-0">
                        <a class="navbar-brand logo h3" href="https://www.patanjaliayurved.net/">
                            <img src="https://www.patanjaliayurved.net/media/images/logo.svg" width="160px" style="margin-left:10%;margin-top:15%;" alt="">

                        </a>
    </div>
</section>
<section class="login-content">
    <div class="logo">
        
<br/>
        <h1 style="font-family: Publica Sans Medium, sans-serif;">Welcome To Patanjali </h1>
    </div>
    <div class="row w-100">
        <div class="col-sm-6">
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <%--<div class="carousel-item active">
                        <img class="d-block w-100" src="../NewContent/img-home/hpl/switch-ats.jpg" alt="First slide">
                        <p>Anti Counterfeit Solution - VCQRU provides anti-counterfeiting solutions that enable users to verify the authenticity of products and help to eliminate counterfeiting.</p>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="../NewContent/img-home//hpl/smart-meter.jpg" alt="Second slide">
                        <p>Build Loyalty - Our build loyalty schemes are designed to incentivize existing customers to continue with your business and also attract new customers</p>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="../NewContent/img-home/hpl/modular.jpg" alt="Third slide">
                        <p>E Warranty - The E Warranty solution provided by VCQRU is an effective way to simplify the process of making warranty claims for your customers.</p>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="../NewContent/img-home/hpl/lighting-focus.jpg" alt="Third slide">
                        <p>Cash Transfer - VCQRU is providing cash transfer schemes, which are offered to customers when they made any specific purchase and get a cash refund</p>
                    </div>--%>
                   <%-- <div class="carousel-item active">
                        <img class="d-block w-100" src="../NewContent/img-home/hpl/Ceiling-Fan-MAIN-image.jpg" alt="Third slide">
                       
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="" alt="Third slide">
                      
                    </div>--%>
                    <div>
                        <img class="d-block w-100" src="../NewContent/front-assets/img/PFL/1692619002Ghee1LTR1.png" alt="Third slide">
                      
                    </div>

                </div>

            </div>
        </div>

        <div class="Login_layout">
            <div class="col-sm-6 text-left" style="display: none" id="fgtpawdC">
                <br />
                <br />
                <h3>Recover Password</h3>
                <hr />
                <p>
                    Enter your registered mobile no for password recovery.
                </p>
                <div class="form-row">
                    <div class="form-group col">
                        <asp:Label Text="Mobile No*" runat="server" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <input type="text" placeholder="mobile no *" data-msg-required="Please enter your mobile no." data-msg-email="Please enter a mobile no."
                            maxlength="13" class="form-control" name="mobile no" id="mobileno" onkeypress='return validate(event)' />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <a href="javascript:;" onclick="return loginshow2();">
                            <asp:Label Text="Try Login Again" runat="server" /></a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <%-- <div class="clearfix" style="height: 15px"></div>--%>
                        <input type="submit" value="Submit" onclick="return subscribenewsletter2();" class="btn btn-primary btn-lg" />

                    </div>
                </div>
            </div>

            <div class="col-md-12" style="display: none" id="fgtpawd">
                <br />
                <br />
                <h3>Recover Password</h3>
                <hr />
                <p>
                    Enter your registered email id for password recovery.
                </p>
                <div class="form-row">
                    <div class="form-group col">
                        <asp:Label Text="Email Address*" runat="server" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <input type="email" placeholder="email" data-msg-required="Please enter your email address." data-msg-email="Please enter a valid email address."
                            maxlength="50" class="form-control" id="txtSend1" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <a href="javascript:;" onclick="return loginshow();">
                            <asp:Label Text="Try Login Again" runat="server" /></a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">

                        <input type="submit" value="Submit" onclick="return subscribenewsletter();" class="btn btn-primary btn-lg" />

                    </div>
                </div>
            </div>


            <div class="col-md-6 section-box-padding mt-0 mb-0" style="display: none" id="fgtpawdEmp">
                <br />
                <br />
                <h3>Recover Password</h3>
                <hr />
                <p>
                    Enter your email id for password recovery.
                </p>
                <div class="form-row">
                    <div class="form-group col">
                        <asp:Label Text="Email*" runat="server" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">
                        <input type="email" placeholder="email" data-msg-required="Please enter your email address." data-msg-email="Please enter a valid email address."
                            maxlength="50" class="form-control" id="txtSendEmp" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col">
                        <a href="javascript:;" onclick="return loginshowEmp();">
                            <asp:Label Text="Try Login Again" runat="server" /></a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col">

                        <input type="submit" value="Submit" onclick="return subscribenewsletterEmp();" class="btn btn-primary btn-lg" />

                    </div>
                </div>
            </div>

            <div id="trylogin" class="login_form ">
            <%--    <h3>Welcome User</h3>--%>
                <div class="form-row">

                    <div class="container1 form-group" style="display:none;">
                        <input type="checkbox" checked="checked" class="form-check-input" id="chkuser" onclick="return chkforEmp('user');" />User
                <span class="checkmark"></span>
                    </div>
                    <div class="container1 form-group ">
                      <input type="checkbox" id="chkadmin" class="form-check-input" style="display: none;" onclick="return chkforEmp('vendor');" />
                <span class="checkmark" style="display: none;"></span>
                    </div>

                    <div class="form-group col-2" style="display: none">
                        <input type="checkbox" id="chkEmp" class="form-check-input" onclick="return chkforEmp('emp');" />Employee
                    </div>
                </div>

                <div id="divEndUser">

<h5 style="text-align:center;">User Login</h5>

                    <div class="group">

                        <input type="text" data-msg-required="Please enter mobile no."
                            maxlength="13" name="mobileno" id="login_txt_idC" onkeypress='return validate(event)' required="required" />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Mobile No</label>
                    </div>

                    <div class="group">
                        <input type="password" data-msg-required="Please enter your password." maxlength="50" id="login_txt_passC" required="required" />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label id="password_otp">Password/OTP</label>
                    </div>
                    <div class="mt-2">
                        <a class="otplink" onclick="return otpsend();" id="otp_link">Click to Get One Time Password (OTP)</a>
                    </div>
                    <div class="form-row mt-4 mb-3">
                        <!--<div class="form-group col-1"></div>
                <label class="form-group col-9">
                </label>-->
                        <div class="container1 form-group"  style="display: none">
                            <input type="checkbox" class="form-check-input" value="Remember me" name="chkRememberMeC" id="chkRememberMeC" />Remember Me
                        <span class="checkmark" style="display: none;"></span>
                        </div>
                    </div>
                    <div class="row mt-12">
                        <div class="col-12">
                            <button class="layout-btn  theme-btn btn-primary btn-sm" type="submit" value="Login" onclick="return login2();" id="btnUserLogin">login</button>
                        </div>
                        <div class="col-12 mt-2">
                            <a class="forgetpas" onclick="return forgotpassword2();">Forgot password</a>
                        </div>
                    </div>
                </div>


                <div id="divvendor">
                    <div class="group">
                        <input type="email" data-msg-required="Please enter your email address." data-msg-email="Please enter a valid email address." maxlength="50" name="email" id="login_txt_id" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>E-mail Address</label>
                    </div>

                    <div class="group">
                        <input type="password" data-msg-required="Please enter your password." maxlength="50" name="email" id="login_txt_pass" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Password</label>
                    </div>
                    <div class="form-row mt-4 mb-3">

                        <div class="container1 form-group ">
                            <input type="checkbox" class="form-check-input" value="Remember me" id="chkRememberMe" />Remember Me
                <span class="checkmark"></span>
                        </div>
                    </div>
                    <div class="row mt-12">
                        <div class="col-12">
                            <button class="layout-btn  theme-btn btn-primary btn-sm" type="submit" value="Login" onclick="return login();" id="btnVendor">login</button>
                        </div>
                        <div class="col-12 mt-2">
                            <a class="forgetpas" onclick="return forgotpassword();">Forgot password</a>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">

                    <%--<div class="col-12">
                        <span>Don't have a account? <a class="register_pop forgetpas">Register Now</a></span>--%>


                    </div>

                </div>
            </div>

            <div id="signup" class="Register_form" style="display: none">
                <h3>Create an account</h3>
                <div class="form-row">

                    <div class="container1 form-group ">
                        <input type="checkbox" checked="checked" class="form-check-input" id="chkusersignup" onclick="return chkforusersignup('user');" />User
                <span class="checkmark"></span>
                    </div>
                    <div class="container1 form-group ">
                        <input type="checkbox" id="chkadminsignup" class="form-check-input" onclick="return chkforusersignup('vendor');" />HPL
                <span class="checkmark"></span>
                    </div>


                    <div class="form-group col-2" style="display: none">
                        <input type="checkbox" id="chkEmpsignup" class="form-check-input" onclick="return chkforusersignup('emp');" />Employee
                    </div>
                </div>

                <div id="divEndUsersignup">
                    <div class="group">
                        <input type="text" id="reg_txt_name" data-msg-required="Please enter your name." maxlength="50" required="required" />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Consumer Name</label>
                    </div>

                    <div class="group">
                        <input type="email" id="reg_txt_id" onchange="return CheckEmailid('user');" name="email"
                            data-msg-required="Please enter your email." maxlength="50" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>E-mail Address</label>
                    </div>

                    <div class="group">
                        <input type="text" id="reg_txt_Mobile" onchange="return CheckMobileNo('user');" onkeypress='return validate(event)' data-msg-required="Please enter mobile no." maxlength="13" required="required" />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Mobile Number</label>
                    </div>
                    <div class="group">
                        <input type="password" data-msg-required="Please enter your password." maxlength="50"
                            name="pwd"
                            id="reg_txt_Cfpwd" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Password</label>
                    </div>
                    <div class="group">
                        <input type="password" data-msg-required="Please enter your Confirm password." maxlength="50"
                            name="pwd"
                            id="reg_txt_pwd" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Confirm Password</label>
                    </div>
                    <div class="row mt-12">

                        <div class="col-12 mt-3">
                            <button type="submit" value="Submit" class="layout-btn theme-btn btn-primary" onclick="return Register();">Register Now</button>
                        </div>

                    </div>
                </div>
                <div id="divvendorsignup">
                    <div class="group">
                        <input type="text" data-msg-required="Please enter company name."
                            maxlength="50" name="email" id="login_txt_CompanyNmR" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Company Name</label>
                    </div>

                    <div class="group">
                        <input type="email" data-msg-required="Please enter your email address." id="login_txt_EmailR"
                            onchange="return CheckEmailid('vendor');"
                            data-msg-email="Please enter a valid email address." maxlength="50" name="email" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>E-mail Address</label>
                    </div>

                    <div class="group">
                        <input type="text" id="login_txt_ContactPR" data-msg-required="Please enter contact person."
                            maxlength="50" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Contact Person</label>
                    </div>


                    <div class="group">
                        <input type="text" id="login_txt_MobileNoR" onkeypress='return validate(event)' data-msg-required="mobile no."
                            maxlength="13" onchange="return CheckMobileNo('vendor');" required />
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Mobile Number</label>
                    </div>

                    <div class="row mt-12">

                        <div class="col-12 mt-3">
                            <button type="submit" value="Submit" class="layout-btn theme-btn btn-primary" onclick="return RegisterVendor();">Register Now</button>
                        </div>

                    </div>
                </div>


                <div class="row mt-4">

                    <div class="col-12">
                        <span>Already have a account <a class="login_pop forgetpas">Login</a></span>

                    </div>

                </div>

            </div>
        </div>
    </div>
</section>


