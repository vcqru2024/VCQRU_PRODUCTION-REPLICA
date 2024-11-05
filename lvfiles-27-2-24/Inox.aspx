<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inox.aspx.cs" Inherits="Inox" %>


<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>INOX</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        .inox-bg {
            background-image: url(./assets/images/Inox/inox_bg.jpg);
            background-repeat: no-repeat;
            background-position: top;
            background-size: cover;
            width: 100%;
            height: 100vh;
            display: table;
            padding-bottom: 50px;
        }

            .inox-bg .inox-logo {
                width: 300px;
                padding: 65px;
            }

            .inox-bg .inox-form {
                background-color: #fff;
                border: 1px solid #d5271e;
                border-radius: 10px;
                padding: 25px;
                text-align: center;
                margin-top: 5%;
                box-shadow: 1px 4px 12px #000;
            }

                .inox-bg .inox-form h4 {
                    color: #d5271e;
                    text-align: center;
                    margin-bottom: 45px;
                    margin-top: 10px;
                    font-weight: 500;
                }

                .inox-bg .inox-form input {
                    margin-bottom: 18px;
                    border-radius: 12px;
                    height: 50px;
                }

                .inox-bg .inox-form select {
                    margin-bottom: 18px;
                    border-radius: 12px;
                    height: 50px;
                }

                .inox-bg .inox-form input:focus {
                    color: #212529;
                    background-color: #fff;
                    border-color: #d5271f;
                    outline: 0;
                    box-shadow: 0 0 0 1px #d5271f;
                }

                .inox-bg .inox-form button {
                    background-color: #d5271e;
                    color: #fff;
                    margin-top: 20px;
                    padding: 9px 40px;
                    border-radius: 10px;
                    border: 0px;
                }

        .product-img {
            float: right;
            margin-top: 18%;
        }

            .product-img ul li {
                list-style: none;
                margin-bottom: 15px;
                border: 2px solid;
                width: 200px;
                box-shadow: 0px 5px 12px;
                -moz-box-shadow: 0px 5px 12px;
                -webkit-box-shadow: 0px 5px 12px;
                border-radius: 10px;
            }

                .product-img ul li img {
                    width: 100%;
                    border-radius: 10px;
                }

        footer a {
            text-decoration: none;
            color: #fff;
        }

        .logo-center {
            text-align: center;
        }

        #btnNext {
            color: #d4281e;
        }

        #formtest {
            background-color: #0000007a;
        }

        .form-box p {
            color: #fff;
        }

        @keyframes zoom-in-zoom-out {
            0% {
                transform: scale(0, 0);
            }

            50% {
                transform: scale(0, 0);
            }

            100% {
                transform: scale(1, 1);
            }
        }







        @media screen and (max-width:768px) {
            .product-img {
                float: initial;
            }

                .product-img ul li {
                    width: 91%;
                }

            footer {
                text-align: center;
            }
        }

        @media screen and (width:912px) {
            footer {
                position: absolute;
                bottom: 40px;
                left: 10%;
            }
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript">


        function Getdata() {
            debugger;
            var mobileno = document.querySelector("#field_h1bqb").value;

            if (mobileno.length == 10) {
                $.ajax({
                    type: "Post",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=ConsumerDetailsByMobileNo&MobileNo= ' + $("#field_h1bqb").val(), 
                    success: function (data) {

                        debugger;

                        var Name = data.split('~')[0];

                        var roleId = data.split('~')[1];
                        var city = data.split('~')[2];
                        var state = data.split('~')[3];
                        if (Name != "")
                            $("#field_nrnx1").val(Name);
                        if (roleId != "")
                            $("#Role_ID").val(roleId);
                        if (city != "")
                            $("#field_nrnx2").val(city);
                        if (state != "")
                            $("#State").val(state);

                    }
                });
            }


        }

        $(function () {
            $("#Role_ID").change(function () {
                if ($(this).val() == "40") {
                    $("#dvother").show();
                    $('#txtotherrole').prop('required', true);

                } else {
                    $("#dvother").hide();
                    $("#txtotherrole").value() == "";
                    $('#txtotherrole').removeAttr('required');

                }
            });
        });

       



        function myfunction() {
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=chkgenuenity&codeone=' + $("#field_r0655").val().substring(0, 5) + '&codetwo=' + $("#field_r0655").val().substring(5, 13) + '&mobile=' + $("#field_h1bqb").val() + '&Role_Id=' + $("#Role_ID option:selected ").val() + '&name=' + $("#field_nrnx1").val() + '&city=' + $("#field_nrnx2").val() + '&State=' + $("#State").val() + '&Other_Role=' + $("#txtotherrole").val() + '&client=Comp-1434',

                success: function (data) {
                    if (data.indexOf("not valid") !== -1) {
                        data = data.split(".")[0];
                    }
                    $('#ShowMessage').show();
                    $('#step1').hide();
                    $('#p3msg').html(data);
                    var input = document.getElementById("ShowMessage").focus();
                    $('#p3msg:contains("not")').css('color', 'white');
                }
            });
        }

        //<========== Validation Sart===========>
        function allowOnlyLetters(e, t) {
            if (window.event) {
                var charCode = window.event.keyCode;
            }
            else if (e) {
                var charCode = e.which;
            }
            else { return true; }
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
                return true;
            else {
                alert("Please enter only alphabets");
                return false;
            }
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function isNumber(evt, cntrl_id) {
            debugger;
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
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


        $(function () {
            $("#btnWarranty").click(function () {
                var role_id = $("#Role_ID");
                if (role_id.val() == "") {
                   
                    alert("Please select Role!");

                    /*$('#field2').removeClass('required');*/
                   
                    return false;

                }
                //else if (role_id.val() == "40") {
                //    alert('ok');
                //    if (txtotherrole.val() == "") {
                //        alert("Please Enter Role!");
                //    }
                //}
                
                return true;
            });
        });

        //<=============Validation End==============>


        $(document).on("click", "#btnNext", () => {
            debugger;
            window.location.href = 'https://www.inoxdecor.com/';
        });
    </script>
</head>
<body>
    <section class="inox-bg">
        <div class="container">
            <header>
                <div class="row">
                    <div class="col-sm-5 logo-center">
                        <a href="#">
                            <img src="assets/images/Inox/inox-logo.png" alt="inox-logo" class="inox-logo" /></a>
                    </div>
                    <div class="col-sm-7"></div>
                </div>
            </header>
            <div class="row">
                <div class="col-sm-5 ">
                    <form class="inox-form" id="formtest" onsubmit="myfunction(); return false;">


                        <div id="step1">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h4>TO CHECK AUTHENTICITY AND AVAIL BENEFITS</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="text" id="field_nrnx1" runat="server" placeholder="Enter your Name *" onkeypress="return allowOnlyLetters(event,this);" class="form-control" required="" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">

                                    <input type="text" runat="server" id="field_h1bqb" onkeyup="Getdata()" placeholder="  Enter your Number *" minlength="10" maxlength="10" class="form-control" required="" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <select id="Role_ID" name="--Select by Role--" class="form-control">
                                        <option value="">--Select Your Role--</option>
                                        <option value="20">Carpenter</option>
                                        <option value="25">Interior Designer</option>
                                        <option value="30">Architect</option>
                                        <option value="35">Customer</option>
                                        <option value="40">Other</option>
                                    </select>
                                </div>
                            </div>

                            <div id="dvother" style="display: none">
                                 <input type="text" class="form-control" placeholder="Enter Role*" id="txtotherrole" />
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="text" id="field_nrnx2" placeholder="Enter your City *" onkeypress="return allowOnlyLetters(event,this);" class="form-control" required="" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="text" id="State" placeholder="Enter your State *" required="" class="form-control" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="text" id="field_r0655" required="" placeholder="Enter your 13 Digit Code *" minlength="13" maxlength="13" class="form-control" onkeypress="if ( isNaN(this.value + String.fromCharCode(event.keyCode) )) return false;" />
                                </div>
                            </div>
                            <button type="submit" data-toggle="modal" class="btn" id="btnWarranty">SUBMIT</button>
                        </div>
                        <div style="display: none;" id="ShowMessage">
                            <div class="form-box">
                                <p id="p3msg" style="overflow: hidden; font-size: 18px !important;" class="displayNone massage_box"></p>
                                <a href="javascript:void(0)" class="next_btn" id="btnNext">Close</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-sm-7">
                    <div class="product-img">
                        <ul>
                            <li>
                                <a href="https://www.inoxdecor.com/product-category/drawer-system/eds/" target="_blank">
                                    <img src="assets/images/Inox/1st.jpg" alt="product1" class="" /></a></li>
                            <%--<li><img src="image/1st.jpg" alt="product1" class="" /></li>--%>
                            <li>
                                <a href=" https://www.inoxdecor.com/product-category/hardwere-slides-hinges/slides-series/" target="_blank">
                                    <img src="assets/images/Inox/2nd.jpg" alt="product2" class="" /></a></li>
                            <li>
                                <a href="https://www.inoxdecor.com/product-category/hardwere-slides-hinges/hinges-series/" target="_blank">
                                    <img src="assets/images/Inox/3rd.jpg" alt="product3" class="" /></a></li>
                            <li>
                                <a href=" https://www.inoxdecor.com/product-category/hardwere-slides-hinges/slides-series/" target="_blank">
                                    <img src="assets/images/Inox/4th.jpg" alt="product4" class="" /></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <div class="container">
                <div class="col-sm-12">
                    <a href="https://www.inoxdecor.com/">www.inoxdecor.com</a>
                </div>
            </div>
        </footer>
    </section>
</body>
</html>

