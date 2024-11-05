<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Nicolt.aspx.cs" Inherits="Nikoltnutrition" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>

    <title>Nikolt-Nutrition</title>
    <style>
        * {
            padding: 0px;
            margin: 0px;
        }

        .Nikolt-Nutrition {
            background-image: url(../assets/images/Nikolt/Background.png);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            padding-bottom: 10px;
        }

            .Nikolt-Nutrition .nikoltlogo {
                padding: 10px;
                width: 17%;
            }

            .Nikolt-Nutrition .nikolt-product {
                width: 78%;
            }

            .Nikolt-Nutrition .form-box {
                padding: 23px;
                background-color: #ffffff5c;
                border: 4px solid #0d4d9d;
                border-radius: 7px;
                width: 75%;
                margin: auto;
            }

        #wlink {
            color: #fff;
            padding: 10px 0px;
            text-align: center;
        }

            #wlink a {
                color: #d74440;
                text-decoration: none;
                font-weight: 800;
            }

        .Nikolt-Nutrition .form-box h5 {
            color: #fff;
            text-align: center;
        }

        .Nikolt-Nutrition .form-box label {
            color: #fff;
        }

        .Nikolt-Nutrition .form-box button {
            color: #fff;
            padding: 8px 33px;
            background-color: #0d4d9d;
            border-radius: 18px;
            border: 2px solid #fff;
            margin-top: 22px;
        }

        .Nikolt-Nutrition .form-box input {
            margin-bottom: 5px;
        }


        .Nikolt-Nutrition .nikolt-footer {
            background-color: #0d4d9d;
            padding: 5px;
            text-align: center;
            position: absolute;
            width: 100%;
            bottom: 0;
        }

            .Nikolt-Nutrition .nikolt-footer a {
                color: #fff;
                text-decoration: none;
            }



        @media screen and (max-width:767px) {
            .Nikolt-Nutrition .form-box {
                width: 100%;
            }

            .Nikolt-Nutrition .nikoltlogo {
                padding: 10px;
                width: 40%;
            }

            .Nikolt-Nutrition .nikolt-product {
                width: 100%;
                padding: 4%;
            }
        }

        @media screen and (min-width:768px) and (max-width:920px) {
            .Nikolt-Nutrition .nikolt-product {
                width: 60%;
                position: absolute;
                right: 0;
                bottom: 12px;
            }

            .Nikolt-Nutrition .form-box {
                width: 100%;
            }
        }

        @media screen and (min-width:1000px) and (max-width:1300px) {
            .Nikolt-Nutrition .nikolt-product {
                width: 46%;
                position: absolute;
                right: 42px;
                bottom: 20px;
            }
        }
    </style>

    

    <script>

        var getPosition = function (options) {
            return new Promise(function (resolve, reject) {
                navigator.geolocation.getCurrentPosition(resolve, reject, options);
            });
        }
        $('#otherfield').hide();
        //$("#btnnxt2").on('click', function () {
        function Getdata() {

            var mobileno = document.querySelector("#mobilenumber").value;
            var d = mobileno.slice(0, 1);
            var c = parseInt(d);

            if ($('#mobilenumber').val() == "") {
                toastr.error("Please enter mobile number");
                $('#btnsubmit').attr('disabled', false);
                return false;
            }





            if (mobileno.match(/[^$,.\d]/)) {
                toastr.error("Please enter numeric value for mobile No.");
                $('#mobilenumber').val() == "";
                $('#btnsubmit').attr('disabled', false);
                return false;
            }

            else {
                if (mobileno.length == 10) {
                    $.ajax({
                        type: "Post",
                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobilenumber").val(),
                          success: function (data) {


                              if (c <= 5) {
                                  toastr.error('Please Enter Valid Mobile No');
                                  $('#mobilenumber').val('');
                                  return false;
                              }
                              else {


                                  var Name = data.split('~')[0];
                                  var pin = data.split('~')[6];
                                  var city = data.split('~')[2];
                                  var shopname = data.split('~')[4];
                                  if (Name != "") {
                                      $("#Name").val(Name);
                                      $("#Name").readOnly = true;
                                      document.getElementById('Name').readOnly = true;
                                  }
                                  else {
                                      $('#ChkCode').hide();
                                      $('#otherfield').show();
                                      $('#mobilefield').hide();
                                      $('#Chkfields').show();
                                  }

                                  if (pin != "") {
                                      $("#pin").val(pin);
                                      $("#pin").readOnly = true;
                                      document.getElementById('pin').readOnly = true;
                                  }
                                  else {
                                      $('#ChkCode').hide();
                                      $('#otherfield').show();
                                      $('#mobilefield').hide();
                                      $('#Chkfields').show();
                                  }


                                  if (city != "") {
                                      $("#city").val(city);
                                      $("#city").readOnly = true;
                                      document.getElementById('city').readOnly = true;
                                  }
                                  else {
                                      $('#ChkCode').hide();
                                      $('#otherfield').show();
                                      $('#mobilefield').hide();
                                      $('#Chkfields').show();
                                  }

                              }
                          }
                      });
                }
            }


        }
        // });

        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }

        function onlyNumberKey(evt) {

            // Only ASCII character in that range allowed
            var ASCIICode = (evt.which) ? evt.which : evt.keyCode
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                return false;
            return true;
        }


        function getaddress() {
            let pin = document.getElementById("pin").value;
            if (pin.length == 6) {
                $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                    createHTML(data);
                })
                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        var city = "";
                        var state = "";
                        var pin = "";
                        var city = data[0].PostOffice[0]['District'];
                        var state = data[0].PostOffice[0]['State'];
                        var Pin = data[0].PostOffice[0]['PinCode'];
                        $("#city").val(city);
                        if (pin == "") {
                            $("#pin").val();
                        }
                        else {
                            $("#pin").val(Pin);
                        }
                        $('#btnsubmit').attr('disabled', false);
                    }
                    else {
                        toastr.error("Please enter valid pin.");
                        $('#btnsubmit').attr('disabled', true);
                        return false;
                    }
                }
            }
        }




        function pinval() {

            var pin = $('#pin').val();
            if (pin != undefined) {

                if ($('#pin').val().length < 6) {
                    toastr.error('Please Enter valid Pin Code');
                    validate = false;
                }
                if (pin.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for Pin Code.");
                    validate = false;
                }

                var matches1 = $('#pin').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('Pin Code Should Not Contain any Special Character!');
                    validate = false;
                }
            }
        }


        function namevalid() {
            var name = $('#Name').val();
            if (name != undefined) {

                if ($('#Name').val().length < 1) {
                    toastr.error('Please Enter valid Name');
                    validate = false;
                    return false;
                }
                var matches = $('#Name').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('Name Should be alphabet only!');
                    //validate = false;
                    return false;
                }
                var matches1 = $('#Name').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('Name Should Not Contain any Special Character!');
                    validate = false;
                    return false;
                }
            }
        }

        function cityvalid() {
            var city = $('#city').val();
            if (city != undefined) {

                if ($('#city').val().length < 1) {
                    toastr.error('Please Enter valid City');
                    validate = false;
                }
                var matches = $('#city').val().match(/\d+/g);
                if (matches != null) {
                    toastr.error('City Name Should be alphabet only!');
                    validate = false;
                }
                var matches1 = $('#city').val().match(/[^a-zA-Z0-9 ]/);
                if (matches1 != null) {
                    toastr.error('City Name Should Not Contain any Special Character!');
                    validate = false;
                }
            }
        }

        function valmobile() {
            var phoneNumber = $('#mobilenumber').val();

            if (phoneNumber != undefined) {
                if (phoneNumber.length < 10) {
                    toastr.error('Please Enter Valid Mobile Number');
                    return false;
                }
                if (phoneNumber.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for mobile No.");
                    validate = false;
                    return false;
                }

                var validate = false;
                var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;

                if (filter.test(phoneNumber)) {
                    if (phoneNumber.length == 10) {
                        var c = phoneNumber.slice(0, 1);
                        if (c <= 5) {
                            $('#p3msg').html('Not a valid mobile number');
                            validate = false;
                            $('#mobilenumber').val('');
                        }
                        else
                            validate = true;
                    } else {
                        if (phoneNumber.length > 10) {
                            $('#p3msg').html('Please put 10  digit mobile number');

                            validate = false;
                        }
                        else {
                            validate = false;
                            $('#btnsubmit').attr('disabled', false);
                        }
                    }
                }
                else {
                    if (phoneNumber.length == 9) {
                        $('#p3msg').html('Please Enter Valid mobile number');
                        $('#mobilenumber').val('');
                        validate = false;
                    }
                    else
                        validate = false;
                }
                if (phoneNumber.match(/[^$,.\d]/)) {
                    toastr.error("Please enter numeric value for mobile No.");
                    validate = false;
                    return false;
                }
            }
        }
        $(document).ready(function () {

            $('#ChkCode').show();
            $('#Chkfields').hide();
            $('#mobilefield').hide();
            firstfunction();
            var id = $('#HdnID').val();
            if (id == "1") {

                $('#ChkCode').show();
                $('#Chkfields').hide();
                $('#mobilefield').hide();
            }

            else if (id == "Nikolt") {
                $('#ChkCode').hide();
                $('#otherfield').hide();
                $('#mobilefield').show();
                $('#Chkfields').show();
                var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                $("#codeone").val(code);
            }
            $("#codeone").mask("99999-99999999");

            $("#btnnxt").on('click', function () {

                var codeone = $('#codeone').val();
                if (codeone != undefined) {

                    if ($('#codeone').val().length < 14) {
                        toastr.error('Please Enter valid Code');
                        validate = false;
                        return false;
                    }
                }
                $('#ChkCode').hide();
                var rquestpage_Dcrypt = $("#codeone").val();
                $.ajax({
                    type: "POST",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1],
                      success: function (data) {
                          $.ajax({
                              type: "POST",
                              url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkwarranty&codeone=' + rquestpage_Dcrypt.split('-')[0] + '&codetwo=' + rquestpage_Dcrypt.split('-')[1] + '&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                              success: function (data) {

                                  if (data.split('&')[0] === "1" && data.split('&')[1] === "Auto Max India") {
                                  }
                                  else {
                                      $('#CompName').val(data.split('&')[1]);

                                      if ($('#CompName').val() == "MANGAL DASS TRADING CO" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
                                          $('#ChkCode').hide();
                                          //ChkCode.style.display = 'none';
                                          $('#Chkfields').show();
                                          $('#mobilefield').show();
                                          $('#Otherfield').hide();
                                      }
                                      else {
                                          //$('#ChkCode').show();
                                          //$('#Chkfields').hide();
                                          //alert('Invalid Code');
                                          window.location.href = 'https://www.vcqru.com/CodeCheck.aspx';
                                      }
                                  }


                                  //else {
                                  //    $('#CompName').val(data.split('&')[1]);
                                  //    $('#Chkfields').show();
                                  //    $('#otherfield').hide();
                                  //    $('#mobilefield').show();

                                  //}
                              }
                          });
                      }
                  });
                  //}
              });

              $('#btnsubmit').on('click', function () {

                  $('#btnsubmit').attr('disabled', true);
                  var mobilenumber = $('#mobilenumber').val()
                  var pincode = $('#pin').val()
                  var d = mobilenumber.slice(0, 1);
                  var c = parseInt(d);
                  if (mobilenumber.match(/[^$,.\d]/)) {
                      toastr.error("Please enter numeric value for mobile No.");
                      $('#mobilenumber').val('');
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  if (mobilenumber.length == 10 && c <= 5) {
                      // toastr.error("Please enter valid mobile No.");
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  if (mobilenumber.length != 10) {
                      toastr.error("Please enter 10 digit of mobile No.");
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  else {
                      var matches = $('#Name').val().match(/\d+/g);
                      if (matches != null) {
                          toastr.error('Name Should be alphabet only!');
                          $('#btnsubmit').attr('disabled', false);
                          $('#Name').val('');
                          return false;
                      }

                      if ($('#Name').val() == "") {
                          namevalid();
                          $('#btnsubmit').attr('disabled', false);
                          return false;
                      }
                      if (pincode.length != 6) {
                          pinval();
                          $('#btnsubmit').attr('disabled', false);
                          return false;
                      }
                      if ($('#pin').val() == "") {
                          pinval();
                          $('#btnsubmit').attr('disabled', false);
                          return false;
                      }
                      if ($('#city').val() == "") {
                          cityvalid();
                          $('#btnsubmit').attr('disabled', false);
                          return false;
                      }




                  }
                  $('#p3msg').html('');
                  if (code != "") {
                      $.ajax({
                          type: "POST",
                          contentType: false,
                          processData: false,

                          url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&PinCode=' + $('#pin').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1280',
                        success: function (data) {

                            if (data.split('~')[0] !== "failure") {
                                window.scrollTo(0, 0);
                                if (data.indexOf("not valid") !== -1) {
                                    data = data.split(".")[0];
                                }
                                $('#head').hide();
                                $('#Chkfields').hide();
                                $('#CodeHeading').hide();
                                $('#fields').hide();
                                $('#ShowMessage').show();
                                $('#chkLine').hide();
                                $('#p3msg').html(data.split('~')[1]);
                                $('#p3msg:contains("not")').css('color', 'white');
                            }
                            else {

                                $('#msgcoats').hide();
                                toastr.error('OTP is not valid. Please provide the valid OTP');
                                $('#btnskyVerify1').attr('disabled', false);
                            }
                        }
                    });
                }
                // }
                else {

                    $('#btnsubmit').attr('disabled', false);
                }
            });
              $('#btnNext').click(function () {
                  window.location.href = 'https://nikoltnutrition.com/';
              });
          });
        async function firstfunction() {

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

            var lat = $('#lat').val();
            var long = $('#long').val();

            $.ajax({
                type: "POST",
                async: true,
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=chklocation&lat=' + $('#lat').val() + '&long=' + $('#long').val(),
                success: function (data) {


                }
            });
        }
    </script>


</head>
<body>
    <section class="Nikolt-Nutrition">
        <header>
            <div class="container">
                <a href="https://nikoltnutrition.com/">
                    <img src="../assets/images/Nikolt/nikoltlogo.png" alt="nikoltlogo" class="nikoltlogo animate__animated animate__fadeInDown" /></a>
            </div>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-box mt-2 animate__animated animate__fadeInLeft">
                        <form runat="server">

                            <asp:HiddenField ID="hdnmob" runat="server" />
                            <asp:HiddenField ID="HdnID" runat="server" />
                            <asp:HiddenField ID="HdnCode1" runat="server" />
                            <asp:HiddenField ID="HdnCode2" runat="server" />
                            <asp:HiddenField ID="CompName" runat="server" />
                            <asp:HiddenField ID="long" runat="server" />
                            <asp:HiddenField ID="lat" runat="server" />

                            <div id="fields">
                                <div class="row">
                                    <div class="col-12">
                                        <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                    </div>
                                </div>
                                <div class="width-box">
                                    <div id="ChkCode">
                                        <div class="col-sm-12">
                                            <label>Enter 13-Digit Code*</label>
                                            <input type="text" id="codeone" maxlength="13" minlength="13" class="form-control" required placeholder="Enter Unique 13 Digit Code*" />
                                        </div>
                                        <div>
                                            <center>
                                                <button type="button" id="btnnxt" class="btn btn-primary">Next</button>
                                                <%--<button type="button" data-toggle="modal" id="btnnxt" class="btn text-uppercase">Next</button>--%>
                                            </center>
                                        </div>
                                    </div>
                                    <div id="mobilefield" style="display: none">
                                        <div class="col-12">
                                            <label>Enter Mobile Number*</label>
                                            <input type="text" onkeyup="Getdata()" id="mobilenumber" required maxlength="10" minlength="10" data-msg-required="Please Enter Your Moblie Number" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="Enter Mobile Number*" />
                                        </div>
                                    </div>
                                    <div id="Chkfields">
                                        <div id="otherfield">
                                            <div class="col-12">
                                                <label>Enter Name*</label>
                                                <input type="text" class="form-control" id="Name"  placeholder="Enter Name*" required />

                                            </div>
                                            <div class="col-12">
                                                <label>Pin Code*</label>
                                                <input type="text" onkeyup="getaddress()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="6" minlength="6" class="form-control" placeholder="Enter Pin Code*" id="pin" required />
                                            </div>

                                            <div class="col-12">
                                                <label>Enter City*</label>
                                                <input type="text" class="form-control" id="city" placeholder="Enter City *" />
                                            </div>
                                        </div>


                                        <div class="col-12 text-center">
                                            <button type="button" id="btnsubmit" data-toggle="modal" class="btn text-uppercase">SUBMIT</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="display: none;" id="ShowMessage" class="row no-gutters pl-4 pr-4 textmessage">
                                <center>
                                    <div class="col-md-12">
                                        <br />
                                        <div class="form-group" style="padding: 20px;">
                                            <p id="p3msg" style="overflow: hidden; color: white; font-size: 17px !important;" class="displayNone massage_box"></p>
                                        </div>
                                        <a href="javascript:void(0)" class="next_btn" id="btnNext" style="font-size: 17px !important;"><b>Close</b></a>

                                    </div>
                                </center>
                            </div>
                        </form>
                    </div>
                    <p id="wlink" class="blink_me animate__animated animate__flash">
                        QR/Code  Related Support Available on
                        <br>
                        <i class="fa fa-phone" aria-hidden="true"></i><a href="tel:7353000903">7353000903</a> / 
                        <i class="fa fa-whatsapp" aria-hidden="true"></i>
                        <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1" target="blank">9355903119</a>
                    </p>
                </div>
                <div class="col-md-6 text-center">
                    <img src="../assets/images/Nikolt/product.png" alt="product-img" class="nikolt-product animate__animated animate__zoomIn" />
                </div>
            </div>
        </div>
        <footer class="nikolt-footer">
            <a href="https://nikoltnutrition.com/">www.nikoltnutrition.com</a>
        </footer>
    </section>

</body>
</html>
