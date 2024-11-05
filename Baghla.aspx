<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Baghla.aspx.cs" Inherits="Baghla" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <script src="https://use.fontawesome.com/53f5a10329.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script src="../Content/js/jquery-1.11.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.js"
        integrity="sha256-yE5LLp5HSQ/z+hJeCqkz9hdjNkk1jaiGG0tDCraumnA="
        crossorigin="anonymous"></script>
    <title>BaghlaSanitaryware</title>

    <style>
        .clbl {
            color: red;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
        }

        .BaghlaSanitaryware {
            background-image: url(../assets/images/BaghlaSanitaryware-img/BaghlaSanitaryware-bg.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            position: relative;
            display: table;
            height: 100vh;
            /* padding: 10px 0px; */
        }

        header .BaghlaSanitaryware-logo {
            padding: 20px 0px;
            width: 17%;
        }

        footer {
            background-color: #000;
            padding: 8px;
            position: absolute;
            bottom: 0;
            width: 100%;
        }

            footer a {
                text-decoration: none;
                color: #fff;
            }

        .BaghlaSanitaryware-product {
            width: 80%;
            padding: 60px;
        }

        .BaghlaSanitaryware .BaghlaSanitaryware-form {
            width: 28%;
            padding: 20px;
            background-color: #fff;
            margin: auto;
            border: 4px solid #008dd2;
            position: absolute;
            bottom: 60px;
            top: 30px;
            right: 12%;
            display: table;
        }

        .BaghlaSanitaryware .width-box input {
            background-color: #e9e5e5;
            margin-bottom: 10px;
            padding: 12px;
        }

        .BaghlaSanitaryware-form button {
            background-color: #008dd2;
            color: #fff;
            padding: 10px 52px;
            margin: 18px;
        }

        .BaghlaSanitaryware-form h5 {
            color: #008dd2;
            font-weight: 700;
            padding: 10px;
        }



        @media screen and (max-width:767px) {
            header .BaghlaSanitaryware-logo {
                padding: 20px 0px;
                width: 52%;
            }

            .BaghlaSanitaryware-product {
                width: 100%;
                padding: 10px 0px;
                margin-bottom: 50px;
            }

            .BaghlaSanitaryware .BaghlaSanitaryware-form {
                width: 100%;
            }

            .form-div {
                display: flex;
                flex-direction: column-reverse;
            }

                .form-div label {
                    font-size: 13px;
                }

            .BaghlaSanitaryware .BaghlaSanitaryware-form {
                width: 100%;
                padding: 20px;
                background-color: #fff;
                margin: auto;
                position: initial;
            }
        }







        @media screen and (min-width:768px) and (max-width:1024px) {
            .BaghlaSanitaryware-product {
                width: 100%;
                padding: 45% 0px 0px 0px;
            }

            .form-div {
                position: absolute;
                margin: auto;
                left: 0;
                top: 20%;
            }

            .BaghlaSanitaryware .BaghlaSanitaryware-form {
                width: 85%;
                position: initial;
            }

            header .BaghlaSanitaryware-logo {
                padding: 20px 0px;
                width: 40%;
            }
        }

        @media screen and (width:1024px) {
            .BaghlaSanitaryware-product {
                width: 90%;
                padding: 16% 0px 0px 0px;
            }

            .BaghlaSanitaryware {
                padding: 0px 0px 57% 0px;
            }

            .form-div {
                top: 10%;
            }

            header .BaghlaSanitaryware-logo {
                width: 25%;
            }
        }


        @media screen and (width:1280px) {
            .BaghlaSanitaryware-product {
                width: 85%;
                padding: 22px 0px 0px 0px;
            }

            .BaghlaSanitaryware .BaghlaSanitaryware-form {
                position: initial;
                width: 80%;
            }
        }
    </style>

      <script>
          var state = "";
          var getPosition = function (options) {
              return new Promise(function (resolve, reject) {
                  navigator.geolocation.getCurrentPosition(resolve, reject, options);
              });
          }
          $('#otherfield').hide();
          function Getdata() {
              var mobileno = document.querySelector("#mobilenumber").value;
              var d = mobileno.slice(0, 1);
              var c = parseInt(d);



              if ($('#mobilenumber').val() == "") {
                  $('#lbl').text('Please enter your mobile number*');
                  $('#mobilenumber').focus();
                  return false;
              }
              if (mobileno.match(/[^$,.\d]/)) {
                  $('#lbl').text('Mobile numbers should be numeric only.*');
                  $('#mobilenumber').val('');
                  $('#mobilenumber').focus();
                  return false;
              }
              if (mobileno.length == 10) {
                  $.ajax({
                      type: "Post",
                      url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#mobilenumber").val(),
                      success: function (data) {

                          if (c <= 5) {
                              $('#lbl').text('Please enter a valid number*');
                              $('#mobilenumber').focus();
                              $('#mobilenumber').val('');
                              return false;
                          }
                          else {
                              $('#Loader').show();
                              $('#btnsubmit').hide();
                              $('#lbl').text('');
                              var Name = data.split('~')[0];
                              var pin = data.split('~')[6];
                              var city = data.split('~')[2];
                              if (Name != "") {
                                  $("#Name").val(Name);
                                  document.getElementById('Name').readOnly = true;
                                  $('#Loader').hide();
                                  $('#btnsubmit').show();
                              }
                              else {
                                  $('#ChkCode').hide();
                                  $('#otherfield').show();
                                  $('#mobilefield').hide();
                                  $('#Chkfields').show();
                                  $('#Loader').hide();
                                  $('#btnsubmit').show();
                              }

                              //if (pin != "") {
                              //    $("#pin").val(pin);
                              //    document.getElementById('pin').readOnly = true;
                              //    $('#Loader').hide();
                              //    $('#btnsubmit').show();
                              //}
                              //else {
                              //    $('#ChkCode').hide();
                              //    $('#otherfield').show();
                              //    $('#mobilefield').hide();
                              //    $('#Chkfields').show();
                              //    $('#Loader').hide();
                              //    $('#btnsubmit').show();
                              //}


                              if (city != "") {
                                  $("#city").val(city);
                                  document.getElementById('city').readOnly = true;
                                  $('#Loader').hide();
                                  $('#btnsubmit').show();
                              }
                              else {
                                  $('#ChkCode').hide();
                                  $('#otherfield').show();
                                  $('#mobilefield').hide();
                                  $('#Chkfields').show();
                                  $('#Loader').hide();
                                  $('#btnsubmit').show();
                              }
                          }
                      }
                  });
              }
              else {
                  $("#Name").val('');
                  // $("#pin").val('');
                  $("#city").val('');
                  document.getElementById('Name').readOnly = false;
                  document.getElementById('pin').readOnly = false;
                  document.getElementById('city').readOnly = false;
                  $('#lbl').text('Please Enter Valid Mobile Number');
              }
          }


          //function getaddress() {
          //    let pin = document.getElementById("pin").value;
          //    if (pin.length == 6) {
          //        $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
          //            createHTML(data);
          //        })
          //        function createHTML(data) {
          //            if (data[0].Status == "Success") {

          //                var city = data[0].PostOffice[0]['District'];
          //                 state = data[0].PostOffice[0]['State'];
          //                var Pin = data[0].PostOffice[0]['PinCode'];
          //                $("#city").val(city);
          //                $('#lbl').text('');
          //                document.getElementById('city').readOnly = true;
          //            }
          //            else {
          //                $('#lbl').text('Please enter a valid pin*');
          //                $('#pin').focus();
          //                document.getElementById('city').readOnly = false;
          //                return false;
          //            }
          //        }
          //    }
          //    else {
          //        $("#city").val('');
          //        $('#lbl').text('Please enter a valid pin*');
          //        document.getElementById('city').readOnly = false;
          //    }
          //}

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

              else if (id == "Bhagla") {
                  $('#ChkCode').hide();
                  $('#otherfield').hide();
                  $('#mobilefield').show();
                  $('#Chkfields').show();
                  var code = $('#HdnCode1').val() + '-' + $('#HdnCode2').val();
                  $("#codeone").val(code);
              }
              $("#codeone").mask("99999-99999999");

              $("#btnnxt").on('click', function (e) {
                  e.preventDefault();
                  var codeone = $('#codeone').val();
                  if (codeone != undefined) {

                      if ($('#codeone').val().length < 14) {
                          $('#lblcode').text('Please enter 13-digit code*');
                          $('#codeone').focus();
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
                                      if ($('#CompName').val() == "BAGHLA SANITARYWARE" || $('#CompName').val() == "" || $('#CompName').val() == undefined) {
                                          $('#ChkCode').hide();
                                          $('#Chkfields').show();
                                          $('#otherfield').hide();
                                          $('#mobilefield').show();
                                      }
                                      else {
                                          $('#ChkCode').show();
                                          $('#Chkfields').hide();
                                          $('#otherfield').hide();
                                          $('#mobilefield').hide();
                                          $('#lblcode').text('Invalid Code');
                                          return false;
                                      }

                                  }
                              }
                          });
                      }
                  });
              });







              $('#btnsubmit').on('click', function (e) {
                  e.preventDefault();
                  $('#btnsubmit').attr('disabled', true);
                  var mobilenumber = $('#mobilenumber').val()
                  var pincode = $('#pin').val()
                  var d = mobilenumber.slice(0, 1);
                  var c = parseInt(d);
                  if (mobilenumber.match(/[^$,.\d]/)) {
                      $('#lbl').text("Mobile numbers should be numeric only*");
                      $('#mobilenumber').focus();
                      $('#mobilenumber').val('');
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  if (mobilenumber.length == 10 && c <= 5) {
                      $('#lbl').text("Please Enter a valid mobile number*");
                      $('#mobilenumber').val('');
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  if (mobilenumber.length != 10) {
                      $('#lbl').text("Please enter 10 digits of your mobile phone number*");
                      $('#mobilenumber').focus();
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }

                  if ($('#Name').val().replace(/\s+/g, '').length == 0) {
                      $('#lbl').text('Please Enter Your Name*');
                      $('#Name').focus();
                      $('#Name').val('');
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  var matches = $('#Name').val().match(/\d+/g);
                  if (matches != null) {
                      $('#lbl').text('Name Should be alphabet only*');
                      $('#Name').focus();
                      $('#btnsubmit').attr('disabled', false);
                      $('#Name').val('');
                      return false;
                  }
                  var matches1 = $('#Name').val();
                  if (matches1.includes('~') || matches1.includes('!') || matches1.includes('@') || matches1.includes('#') || matches1.includes(')') || matches1.includes('_') || matches1.includes('-') || matches1.includes('>') || matches1.includes(',') || matches1.includes('?')
                      || matches1.includes('$') || matches1.includes('%') || matches1.includes('^') || matches1.includes('&') || matches1.includes('*') || matches1.includes('(') || matches1.includes('+') || matches1.includes('<') || matches1.includes('.')
                      || matches1.includes('=') || matches1.includes('{') || matches1.includes('}') || matches1.includes('[') || matches1.includes(']') || matches1.includes(':') || matches1.includes(';') || matches1.includes('"') || matches1.includes('/')
                  ) {
                      $('#lbl').text('Name should not contain any special char*');
                      $('#Name').focus();
                      $('#btnsubmit').attr('disabled', false);
                      $('#Name').val('');
                      return false;
                  }
                  //if (matches1 != null) {
                  //    $('#lbl').text('Name should not contain any special char*');
                  //    $('#Name').focus();
                  //    $('#btnsubmit').attr('disabled', false);
                  //    $('#Name').val('');
                  //    return false;
                  //}

                  //if ($('#pin').val() == "") {
                  //    $('#lbl').text('Please enter the pin code*');
                  //    $('#pin').focus();
                  //    $('#btnsubmit').attr('disabled', false);
                  //    return false;
                  //}
                  //if ($('#pin').val().replace(/\s+/g, '').length == 0) {
                  //    $('#lbl').text('Please enter the pin code*');
                  //    $('#pin').focus();
                  //    $('#btnsubmit').attr('disabled', false);
                  //    return false;
                  //}
                  //if (pincode.length != 6) {
                  //    $('#lbl').text('Please provide valid pin code*');
                  //    $('#pin').focus();
                  //    $('#btnsubmit').attr('disabled', false);
                  //    return false;
                  //}

                  if ($('#city').val().replace(/\s+/g, '').length == 0) {
                      $('#lbl').text('Please enter your city name*');
                      $('#city').focus();
                      $('#btnsubmit').attr('disabled', false);
                      return false;
                  }
                  var matches2 = $('#city').val();
                  if (matches2.includes('~') || matches2.includes('!') || matches2.includes('@') || matches2.includes('#') || matches2.includes(')') || matches2.includes('_') || matches2.includes('-') || matches2.includes('>') || matches2.includes(',') || matches2.includes('?')
                      || matches2.includes('$') || matches2.includes('%') || matches2.includes('^') || matches2.includes('&') || matches2.includes('*') || matches2.includes('(') || matches2.includes('+') || matches2.includes('<') || matches2.includes('.')
                      || matches2.includes('=') || matches2.includes('{') || matches2.includes('}') || matches2.includes('[') || matches2.includes(']') || matches2.includes(':') || matches2.includes(';') || matches2.includes('"') || matches2.includes('/')
                  ) {
                      $('#lbl').text('City name should not contain any special charector*');
                      $('#city').focus();
                      $('#city').val('');
                      $('#btnsubmit').attr('disabled', false);
                      $('#city').val('');
                      return false;
                  }

                  $('#p3msg').html('');
                  if (code != "") {
                      $.ajax({
                          type: "POST",
                          contentType: false,
                          processData: false,
                          <%--url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&state=' + state + '&PinCode=' + $('#pin').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1303',--%>
                          url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=verifyotp&mobile=' + $('#mobilenumber').val() + "&vCode=" + $('#codeone').val() + '&name=' + $('#Name').val() + '&city=' + $('#city').val() + '&comp=' + $('#CompName').val() + '&Comp_ID=Comp-1550',
                          success: function (data) {

                              if (data.split('~')[0] !== "failure") {
                                  window.scrollTo(0, 0);
                                  if (data.indexOf("not valid") !== -1) {
                                      data = data.split(".")[0];
                                  }
                                  $('#Header').hide();
                                  $('#Chkfields').hide();
                                  $('#CodeHeading').hide();
                                  $('#fields').hide();
                                  $('#mobilefield').hide();
                                  $('#ShowMessage').show();
                                  $('#chkLine').hide();
                                  $('#p3msg').html(data.split('~')[1]);
                                  $('#p3msg:contains("not")').css('color', 'Black');
                              }
                              else {

                                  $('#msgcoats').hide();
                                  alert('OTP is not valid. Please provide the valid OTP');
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
                  window.location.href = 'https://prestigebathfittings.com/';
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

    <section class="BaghlaSanitaryware">
        <header>
            <div class="container">
                <a href="https://prestigebathfittings.com/">
                <img src="../assets/images/BaghlaSanitaryware-img/Prestigelogo.png" alt="BaghlaSanitaryware-logo" class="BaghlaSanitaryware-logo animate__animated animate__heartBeat">
           </a>
                    </div>
        </header>
        <div class="container">
            <div class="row form-div">
                <div class="col-sm-6 text-center">
                    <img src="../assets/images/BaghlaSanitaryware-img/product.png" alt="BaghlaSanitaryware-product" class="BaghlaSanitaryware-product animate__animated animate__fadeInLeft">
                </div>
                <div class="col-sm-6">
                    <form class="BaghlaSanitaryware-form animate__animated animate__animated animate__slideInDown m-auto" runat="server">
                       
                         <asp:HiddenField ID="hdnmob" runat="server" />
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnCode1" runat="server" />
                        <asp:HiddenField ID="HdnCode2" runat="server" />
                        <asp:HiddenField ID="CompName" runat="server" />
                        <asp:HiddenField ID="long" runat="server" />
                        <asp:HiddenField ID="lat" runat="server" />
                        
                        
                        <div class="form-box ">
                            <div id="Header">
                                <div class="row">
                                    <div class="col-12 text-center mb-4">
                                        <h5 class="text-uppercase">to check authenticity And Avail Benefits</h5>
                                    </div>
                                </div>
                                </div>

                                <div class="width-box">
                                   <div id="ChkCode">
                                    <div class="col-sm-12">
                                        <label>Enter 13-Digit Code/13 अंकों का कोड दर्ज करें *</label>
                                        <input type="text" maxlength="13" id="codeone" class="form-control"/>
                                        <center>
                                        <label class="clbl" id="lblcode"></label>
                                            </center>
                                    </div>
                                       <center>
                                       <div class="mb-3">
                                        <button type="submit" id="btnnxt" class="btn btn-primary">Next</button>
                                       </div>
                                           </center>
                                   </div>
                                    <div id="mobilefield" style="display: none">
                                    <div class="col-12">
                                        <label>Enter Mobile Number/मोबाइल नंबर दर्ज करें *</label>
                                        <input type="text" maxlength="10" id="mobilenumber" onkeyup="Getdata()" data-msg-required="Please Enter Your Moblie Number" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" " />
                                    </div>
                                        </div>
                                    <div id="Chkfields">
                                        <div id="otherfield">
                                    <div class="col-12">
                                        <label>Enter Name/नाम दर्ज करें *</label>
                                        <input type="text" id="Name" class="form-control" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode = 123)" " />
                                    </div>
                                    <%--<div class="col-12">
                                        <label>Enter PinCode/पिन कोड दर्ज करें *</label>
                                        <input type="text" id="pin" class="form-control" onkeyup="getaddress()" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode = 123)" " />
                                    </div>--%>
                                    <div class="col-12">
                                        <label>Enter City/शहर दर्ज करें *</label>
                                        <input type="text" id="city" class="form-control" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)" " />
                                    </div>
                               </div>

                                    <label class="clbl" id="lbl"></label>
                                <div class="col-12 text-center">
                                    <img src="assets/images/BaghlaSanitaryware-img/Loader.gif" id="Loader" style="display:none;width: 257px;" />
                                    <button type="button" id="btnsubmit" class="btn text-uppercase">SUBMIT</button>
                                </div>
                                         </div>
                                    <div style="display: none;" id="ShowMessage">
                            <div class="form-box">
                                <p id="p3msg" style="overflow: hidden; text-align:center; color: black; font-size: 13px !important; font-weight: 500;" class="displayNone massage_box"></p>
                                <br />
                                <center><a href="javascript:void(0)" class="btn btn-primary" id="btnNext">Close</a></center>
                            </div>
                        </div>
                                     <h6 class=" pt-2 qr-heading" style="font-size:18px; color:#000; text-align:center;">QR/Code Related Support Available on</h6>
                        <p class="  text-center number-style">
                            <img src="../assets/images/BaghlaSanitaryware-img/telephone.png" style="width: 20px; color:#000; text-decoration:none;">  <a href="tel:7353000903"  style="text-decoration:none">7353000903</a> /
                            <img src="../assets/images/BaghlaSanitaryware-img/whatsapp.png" style="width: 20px; color: #000; text-decoration: none;">  <a href="https://api.whatsapp.com/send?phone=+919355903119&amp;text&amp;type=phone_number&amp;app_absent=1"  style="text-decoration:none" target="blank">9355903119</a>
                        </p>
                                     </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <footer class="text-center">
            <a href="https://prestigebathfittings.com/"> www.prestigebathfittings.com </a>
        </footer>
    </section>
    
</body>
</html>
