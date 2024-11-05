<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginSignUpDealer.ascx.cs" Inherits="UserControl_LoginSignUpDealer" %>
 <script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>
 
    <script type="text/javascript">
        var rquestpage = ''; //UpdateProfile.aspx
        var usertypr = "user";
        $(document).ready(function () {
            
           doSomething();
            getQueryStrings2();
            $('#divvendor').hide();
            doSomething2();
            $('#divEmployee').hide();
            doSomethingEmp();
            getQueryStrings3();
            $('#divvendorsignup').hide();
            $('#divEmpUsersignup').hide();
            
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
            //if(rquestpage.)
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
                //    alert(Userid + '  ,  ' + Password + '  ,  ' + Remember);
                    $('#progress').show();
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=login&userid=' + Userid + '&pass=' + Password + '&remember=' + Remember,
                        success: function (data) {
                           
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
                                        page = "CompProfile.aspx";
                                    }
                                    else {
                                        page = rquestpage;
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
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=loginEmp&userid=' + Userid + '&pass=' + Password + '&remember=' + Remember,
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
                toastr.error("Please enter valid Email Address"); msg = "no"; return false
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
            if (strval == 'user')
            {
                $("#chkuser").prop("checked", true);
                $('#divEndUser').show();
            }
            if (strval == 'vendor')
            {
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
        //function chkforuser() {
        //    $("#chkuser").prop("checked", true);
        //    $("#chkadmin").prop("checked", false);
        //    $('#divEndUser').show();
        //    $('#divvendor').hide();
        //  //  $('#btnadmin').hide();
        //  //  $('#btnuser').show();
        //    doSomething();
        //}
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


<script>
    function getQueryStrings2() {
           
            var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
            //var queryString = location.search.substring(1);
            //var keyValues = queryString.split('=');
            //rquestpage = keyValues[1];
            var queryString = location.search.substring(1);
            var keyValues = queryString.split('&');
            for (var i in keyValues) {
                var key = keyValues[i].split('=');
                if (key.length > 1) { rquestpage = key[1]; }
                else { }

            }
            //if(rquestpage.)
        }
    function Register() {
        toastr.clear();
            var Name = $('#reg_txt_name').val();
            var email = $('#reg_txt_id').val();
            var mobile = $('#reg_txt_Mobile').val();
            var City =""; //$('#reg_txt_city').val();
            var Pin = "";// $('#reg_txt_pin').val();
            var pwd = $('#reg_txt_pwd').val();
            var cpwd = $('#reg_txt_Cfpwd').val();
            var loc = $('#reg_txt_Location').val();
            var DealerType = $('#ddlDealerType').val();
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
                                                    if (DealerType == 0) {
                                                        toastr.error("Please select type");
                                                        return false;
                                                    }
                                                    if (loc == '') {
                                                        toastr.error("Please enter location");
                                                        return false;
                                                    }
                                                    $('#progress').show();
                                                    $.ajax({
                                                        type: "POST",
                                                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=DealerRegister&Name=' + Name + '&email=' + email + '&mobile=' + mobile + '&City=' + City + '&Pin=' + Pin + '&pwd=' + pwd + '&loc=' + loc + '&type=' + DealerType,
                                                        success: function (data) {
                                                            $('#progress').hide();
                                                            toastr.success(data);
                                                            $('#reg_txt_name').val('');
                                                            $('#reg_txt_id').val('');
                                                            $('#reg_txt_Mobile').val('');
                                                          //  $('#reg_txt_city').val('');
                                                           // $('#reg_txt_pin').val('');
                                                            $('#reg_txt_pwd').val('');
                                                            $('#reg_txt_Cfpwd').val('');
                                                            $('#reg_txt_Location').val('');
                                                            $('#ddlDealerType').val("0");
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
            var City =""; //$('#reg_txt_city').val();
            var Pin = "";// $('#reg_txt_pin').val();
            var pwd = $('#reg_txt_CfpwdEmp').val();
            var cpwd = $('#reg_txt_pwdEmp').val();
            if (EmpType == "0")
            {
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
            if (strType == 'user')
            {
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
            strvalue =$('#reg_txt_Mobile').val();
            v = $('#reg_txt_Mobile').val().length;
        }
        else if (strType == 'vendor') {
            strvalue =$('#login_txt_MobileNoR').val();
            v = $('#login_txt_MobileNoR').val().length;
        }
        else if (strType == 'emp') {
            strvalue =$('#reg_txt_MobileEmp').val();
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
                            //$('#reg_txt_Mobile').val('');

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


        function login2() {
            toastr.clear();
            //if ($('#login_txt_idC').val() != '')
            //{
            //    RegExp p  =  new RegExp("[a-zA-Z@#$%&*()^]",$('#login_txt_idC').val());

            //    if ($('#login_txt_idC').val().match(new RegExp("[a-zA-Z@#$%&*()^]",$('#login_txt_idC').val())))
            //    {
            //        alert('');
            //        return;
            //    }
                    
            //}

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
                    $.ajax({
                        type: "POST",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=Dealerlogin&userid=' + Userid + '&pass=' + Password + '&remember=' + Remember,
                        success: function (data) {
                            
                            $('#progress').hide();                         
                            var page = "";
                            var resut = data;
                            if (resut != "success")
                            {  
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
                                window.location.href = "../Dealer/MyProfile.aspx";
                                //alert(window.location.href);
                            }
                            
                        },
                    });
                }
            }
        }

        function subscribenewsletter2() {
            toastr.clear();
            if ($('#mobileno').val() == '') {
                toastr.error("Please enter your Mobile No."); msg = "no"; return false
            }
            if ($('#mobileno').val() != '') {
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
                if (theEvent.preventDefault) theEvent.preventDefault();
            }
        }
    </script>
<section class="section-center section-no-border section-light">
         <div class="" id="login">
					<div class="container">
                        <div class="row justify-content-center">
                          <%--  <div class="col-md-6 section-box-padding mt-0 mb-0">

                              



                            </div>--%>

                            <%--forgot PASSWORD--%>
                            <div class="col-md-6 mt-3 text-left" style="display: none" id="fgtpawdC">
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
                                                 maxlength="13" class="form-control" name="mobile no"  id="mobileno" onkeypress='return validate(event)'   />
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

                            <div class="col-md-6 section-box-padding mt-0 mb-0" style="display: none" id="fgtpawd">
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
                                            maxlength="50" class="form-control" name="email" id="txtSend1"/>
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
                                            maxlength="50" class="form-control" name="email" id="txtSendEmp"  />
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
                            <%--End forgotpassword--%>

                            <%--Login start--%>
                                <div  class="col-md-6 section-box-padding mt-0 mb-0" id="trylogin"><%--class="col-md-6 mt-3 text-left"--%>
                                      <br />
                                    <br />
                                <h3 class="mb-0 mt-2">Login</h3>                                
                               
                                 <p style="margin-top:10px;">
                                   &nbsp;
                                </p>
                                <hr />
                              

                                    <div class="form-row" style="display:none;">
                                    <div class="form-group col-3">
										Login As<label>*</label>
										</div>  
										<div class="form-group col-2">
											 <input type="checkbox" checked="checked" class="form-check-input" id="chkuser" onclick="return chkforEmp('user');" />User
										</div>
										<div class="form-group col-3">
											<input type="checkbox"  id="chkadmin" class="form-check-input" onclick="return chkforEmp('vendor');" />Vendor
										</div>
                                        	<div class="form-group col-2">
											<input type="checkbox"  id="chkEmp" class="form-check-input" onclick="return chkforEmp('emp');" />Employee
										</div>
									</div>

                                <div id="divEndUser">
                               <div class="form-row">
                                    <div class="form-group col">Mobile No.*                                      
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" placeholder="mobile no" 
                                            maxlength="13" class="form-control" name="mobileno" id="login_txt_idC" onkeypress='return validate(event)'  />
                                    </div>
                                </div>
                                <div class="form-row">
										<div class="form-group col">
											Password*
										</div>
									</div>
									<div class="form-row">
										<div class="form-group col">
											<input type="password" placeholder="password"  
                                                maxlength="50" class="form-control" name="pwd" 
                                                id="login_txt_passC"    />
										</div>
									</div>
                                    <div class="form-row">
                                    <div class="form-group col-5">
                                        <a class="forgot"  href="javascript:;" onclick="return forgotpassword2();">Forgot Your Password?</a>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-1"></div>
                                    <div class="form-group col-3">
                                        <input type="checkbox" checked="checked" class="form-check-input" value="Remember me" id="chkRememberMeC" />Remember Me
                                    </div>

									</div>
                                <div class="form-row">
                                    <div class="form-group col">
                                       <%-- <div class="clearfix" style="height: 15px"></div>--%>
                                        <input type="submit" value="Login" onclick="return login2();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />

                                    </div>
                                </div>
                                    </div>

                                <div  id="divvendor" style="display:none;">
                                     <div class="form-row">
                                    <div class="form-group col">
                                        <asp:Label Text="Email Address*" runat="server" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" placeholder="email" data-msg-required="Please enter your email address." 
                                            data-msg-email="Please enter a valid email address." maxlength="50" class="form-control" name="email" id="login_txt_id"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password" data-msg-required="Please enter your password." maxlength="50" 
                                            class="form-control" name="email" id="login_txt_pass"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-5">
                                        <a class="forgot" href="javascript:;" onclick="return forgotpassword();">Forgot Your Password?</a>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-1"></div>
                                    <div class="form-group col-3">
                                        <input type="checkbox" checked="checked" class="form-check-input" value="Remember me" id="chkRememberMe" />Remember Me
                                    </div>

                                </div>
                                <div class="form-row">
                                    <div class="form-group col">

                                        <input type="submit" value="Login" onclick="return login();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />

                                    </div>
                                </div>
                                </div>

                                <div  id="divEmployee" style="display:none;">
                                     <div class="form-row">
                                    <div class="form-group col">
                                        <asp:Label Text="Employee Email *" runat="server" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" placeholder="email" data-msg-required="Please enter your email address." 
                                            data-msg-email="Please enter a valid email address." maxlength="50" class="form-control"
                                             name="email" id="login_txt_idEmp"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password" data-msg-required="Please enter your password." maxlength="50" 
                                            class="form-control" name="email" id="login_txt_passEmp"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-5">
                                        <a class="forgot" href="javascript:;" onclick="return forgotpasswordEmp();">Forgot Your Password?</a>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-1"></div>
                                    <div class="form-group col-3">
                                        <input type="checkbox" checked="checked" class="form-check-input" value="Remember me" id="chkRememberMeEmp" />Remember Me
                                    </div>

                                </div>
                                <div class="form-row">
                                    <div class="form-group col">

                                        <input type="submit" value="Login" onclick="return loginEmp();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />

                                    </div>
                                </div>
                                </div>

                            </div>
                            <%--End login--%>

                            <%--Sign up for User  and vendor --%>
                            <div class="col-md-6 section-box-padding mt-0 mb-0" id="signup">
                                <br /> <br />
                                <h3 class="mb-0 mt-2"> Create an account</h3>                                
                               
                                 <p style="margin-top:10px;">
                                   It's free and always will be.
                                </p>
                                <hr />
                               
                                 <div class="form-row" style="display:none;">
                                    <div class="form-group col-3">
										Account As&nbsp;<label>*</label>
										</div>
										<div class="form-group col-2">
											 <input type="checkbox" checked="checked" class="form-check-input" id="chkusersignup" onclick="return chkforusersignup('user');" />User
										</div>
										<div class="form-group col-3">
											<input type="checkbox"  id="chkadminsignup" class="form-check-input" onclick="return chkforusersignup('vendor');" />Vendor
										</div>
                                     <div class="form-group col-2">
                                         <input type="checkbox"  id="chkEmpsignup" class="form-check-input" onclick="return chkforusersignup('emp');" />Employee
                                     </div>
									</div>
                                
                              <%--  <a class="btn btn-primary btn-lg" href="register.aspx#register">Create an Account</a>--%>
                                <div id="divEndUsersignup">
                                     <div class="form-row">
                                    <div class="form-group col">
                                        Name*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_name" placeholder="name"  maxlength="50" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Email Address*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" id="reg_txt_id" onchange="return CheckEmailid('dealer');" placeholder="email" name="email"
                                             data-msg-required="Please enter your email." maxlength="50" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Mobile No.*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_Mobile" onchange="return CheckMobileNo('dealer');" 
                                            onkeypress='return validate(event)' placeholder="mobile no" maxlength="13" class="form-control" />
                                    </div>
                                </div>
                             <%--   <div class="form-row">
                                    <div class="form-group col">
                                        City Name*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_city" placeholder="city" data-msg-required="Please enter city" maxlength="13" class="form-control" required="required" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Pin Code*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_pin" onkeypress='return validate(event)' placeholder="pincode" data-msg-required="Please enter pincode" maxlength="13" class="form-control" required="required" />
                                    </div>
                                </div>--%>
                                    <div class="form-row">
                                    <div class="form-group col">
                                        Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password *"  maxlength="50" 
                                            class="form-control" name="pwd"
                                            id="reg_txt_Cfpwd"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Confirm Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password *"  maxlength="50"
                                             class="form-control" name="pwd"
                                            id="reg_txt_pwd" />
                                    </div>
                                </div>
                                    <div class="form-row">
                                    <div class="form-group col">
                                        Type*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <%--<input type="text" id="reg_txt_Type" placeholder="name" data-msg-required="Please select type." maxlength="50" class="form-control" required="required" />--%>
                                         <select class="form-control" id="ddlDealerType">
                                                <option value="0" selected="selected">Select</option>
                                                <option value="1">Store Keeper</option>
                                                <option value="2">Distributor</option>
                                                <option value="3">Retailer</option>
                                                <%--<option value="3">Sr Supervisor</option>--%>
                                            </select>
                                    </div>
                                </div>
                                 <div class="form-row">
                                    <div class="form-group col">
                                        Location*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_Location" placeholder="name"  maxlength="50" class="form-control"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="submit" value="Submit" onclick="return Register();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />
                                    </div>
                                </div>
                                </div>
                                <div id="divvendorsignup" style="display:none;">
                                    <div class="form-row">
                                    <div class="form-group col">
                                        <asp:Label Text="Company Name*" runat="server" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" placeholder="company name" data-msg-required="Please enter company name."
                                            maxlength="50" class="form-control" name="email" id="login_txt_CompanyNmR"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <asp:Label Text="Email Address*" runat="server" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" placeholder="email *" data-msg-required="Please enter your email address." id="login_txt_EmailR" 
                                            onchange="return CheckEmailid('vendor');"
                                            data-msg-email="Please enter a valid email address." maxlength="50" class="form-control" name="email" />
                                    </div>
                                </div>
                                    <div class="form-row">
                                    <div class="form-group col">
                                        Contact Person*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="login_txt_ContactPR" placeholder="contact person"  data-msg-required="Please enter contact person." 
                                            maxlength="50" class="form-control"   />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                       Mobile No.*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="login_txt_MobileNoR" onkeypress='return validate(event)' placeholder="mobile no" data-msg-required="mobile no." 
                                            maxlength="13" class="form-control"   onchange="return CheckMobileNo('vendor');" />
                                    </div>
                                </div>
                                  <div class="form-row">
                                    <div class="form-group col">
                                        <%-- <div class="clearfix" style="height: 15px"></div>--%>
                                        <input type="submit" value="submit" onclick="return RegisterVendor();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />

                                    </div>
                                </div>
                                    <br />
                                <h3 class="mb-0 mt-2"> Demo Register</h3>                                
                               
                                 <p style="margin-top:10px;">
                                   It's free and always will be.
                                </p>
                                <hr />
                                      <div class="form-row">
                                    <div class="form-group col">
                                        <asp:Label Text="Packet secret code*" runat="server" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="Packetsecretcode" onkeypress='return validate(event)' placeholder="Packet secret code" data-msg-required="Please enter secret code."
                                            maxlength="50" class="form-control"  required="required" />
                                    </div>
                                </div>
                                  <div class="form-row">
                                    <div class="form-group col">
                                        <%-- <div class="clearfix" style="height: 15px"></div>--%>
                                        <input type="submit" value="submit" onclick="return DemoRegister();"  class="btn btn-primary btn-lg"  />

                                    </div>
                                </div>
                            </div>
                                <div id="divEmpUsersignup" style="display:none;">
                                    <div class="form-row">
                                        <div class="form-group col">
                                            Employee Type*
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col">
                                            <%--<input type="" id="reg_txt_nameEmp" placeholder="name" data-msg-required="Please enter your name." maxlength="50" class="form-control" required="required" />--%>
                                            <select class="form-control" id="dropdownid">
                                                <option value="0">Select</option>
                                                <option value="1" selected="selected">Employee</option>
                                                <option value="2">Supervisor</option>
                                                <option value="3">Sr Supervisor</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col">
                                            Name*
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col">
                                            <input type="text" id="reg_txt_nameEmp" placeholder="name" data-msg-required="Please enter your name." maxlength="50" class="form-control" required="required" />
                                        </div>
                                    </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Email Address*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="email" id="reg_txt_idEmp" onchange="return CheckEmailid('emp');" placeholder="email" name="email" 
                                            data-msg-required="Please enter your email." maxlength="50" class="form-control"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Mobile No.*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_MobileEmp" onchange="return CheckMobileNo('emp');" 
                                            onkeypress='return validate(event)' placeholder="mobile no" data-msg-required="Please enter mobile no." 
                                            maxlength="13" class="form-control"  />
                                    </div>
                                </div>
                             <%--   <div class="form-row">
                                    <div class="form-group col">
                                        City Name*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_city" placeholder="city" data-msg-required="Please enter city" maxlength="13" class="form-control" required="required" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Pin Code*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="text" id="reg_txt_pin" onkeypress='return validate(event)' placeholder="pincode" data-msg-required="Please enter pincode" maxlength="13" class="form-control" required="required" />
                                    </div>
                                </div>--%>
                                    <div class="form-row">
                                    <div class="form-group col">
                                        Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password *" data-msg-required="Please enter your password." 
                                            maxlength="50" class="form-control" name="pwd"
                                            id="reg_txt_CfpwdEmp"  />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        Confirm Password*
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="password" placeholder="password *" data-msg-required="Please enter your Confirm password."
                                             maxlength="50" class="form-control" name="pwd"
                                            id="reg_txt_pwdEmp" />
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group col">
                                        <input type="submit" value="Submit" onclick="return RegisterEmp();" class="btn btn-primary btn-lg" data-loading-text="Loading..." />
                                    </div>
                                </div>
                                </div>
                                </div>
                            </div>
                        </div>
					</div>
             
				</section>