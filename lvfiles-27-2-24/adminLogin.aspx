<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/adminLogin.aspx.cs" Inherits="Admin_Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>Login Page - Ace Admin</title>
    <script src="Admin/assets/js/jquery.min.js" type="text/javascript"></script>
    <meta name="description" content="User login page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="Admin/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="Admin/assets/css/font-awesome.min.css" />

    <!-- text fonts -->
    <link rel="stylesheet" href="Admin/assets/css/ace-fonts.css" />

    <!-- ace styles -->
    <link rel="stylesheet" href="Admin/assets/css/ace.min.css" />

    <!--[if lte IE 9]>
        <link rel="stylesheet" href="../Admin/assets/css/ace-part2.min.css" />
    <![endif]-->
    <link rel="stylesheet" href="Admin/assets/css/ace-rtl.min.css" />

    <!--[if lte IE 9]>
      <link rel="stylesheet" href="../Admin/assets/css/ace-ie.min.css" />
    <![endif]-->
    <link rel="stylesheet" href="Admin/assets/css/ace.onpage-help.css" />

    <link href="../Content/css/toastr.min.css" rel="stylesheet" />
    <script src="../Content/js/toastr.min.js" type="text/javascript"></script>


    <script type="text/javascript">
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
                m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-56329391-1', 'auto');
        ga('send', 'pageview');

    </script>


    <script type="text/javascript">
        function CallHandler() {
            debugger;
            if ($('#txtusername').val() == "") {
                toastr.error("Please enter userid");
                return false;
            }
            if ($('#txtpassword').val() == "") {
                toastr.error("Please enter Password");
                return false;
            }
            if ($('#txtVerificationCode').val() == "") {
                toastr.error("Please enter captcha code");
                return false;
            }

            $('#divprogress').css("display", "block")
            //    $('#divprogress').css("display", "block")
            //    $.ajax({
            //        type: "POST",
            //        url: "/Admin/adminhandeler.asmx/SomeWebMethodName",
            //        data: "{ 'Userid': '" + $('#txtusername').val() + "', 'password': '" + $('#txtpassword').val() + "' }",
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d == 3) {
            //                $('#txtusername').val("");
            //                $('#txtpassword').val("");
            //                toastr.error("Invalid user id or password !");
            //                $('#divprogress').css("display", "none")
            //            }
            //            if (data.d == 1) {
            //                window.location("Dashboard.aspx");
            //            }
            //            if (data.d == 2) {
            //                var qs = window.GetQueryString(query);
            //                window.location(qs);
            //            }
            //            else {
            //                toastr.error("There is something wrong !");
            //                $('#divprogress').css("display", "none")
            //            }

            //        }
            //    });
        }
    </script>
</head>

<body class="login-layout">
    <form runat="server">
        <div id="divprogress" align="center" style="position: absolute; left: 0; height: 150px; width: 100%; top: 0px; display: none; z-index: 111;"
            class="NewmodalBackground">
            <div style="margin-top: 300px;" align="center">
                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                <span style="color: black;">Please Wait.....<br />
                </span>
            </div>
        </div>
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="login-container">
                            <div class="center" style="background-color: #eee; margin: 20px 5px 5px;">

                                <img src="Admin/assets/images/logo.png" alt="Vcqru" />
                            </div>

                            <div class="space-6"></div>

                            <div class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header blue lighter bigger">
                                                <i class="ace-icon fa fa-coffee green"></i>
                                                Please Enter Your Information
                                            </h4>

                                            <div class="space-6"></div>

                                            <fieldset>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <%--<input type="text" class="form-control" placeholder="Username" />--%>
                                                        <asp:TextBox runat="server" ID="txtusername" MaxLength="30" required CssClass="form-control" placeholder="Username"></asp:TextBox>
                                                        <i class="ace-icon fa fa-user"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <%--<input type="password" class="form-control" placeholder="password" />--%>
                                                        <asp:TextBox runat="server" TextMode="Password" ID="txtpassword"  required CssClass="form-control" placeholder="Password"></asp:TextBox>
                                                        <i class="ace-icon fa fa-lock"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox runat="server" ID="txtVerificationCode" CssClass="form-control" required placeholder="Captcha Code"></asp:TextBox>
                                                        <i class="ace-icon fa fa-key"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:Image ID="Image2" runat="server" Height="55px" ImageUrl="~/Captcha.aspx" Width="186px" />
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-primary"><i class="ace-icon fa fa-2x fa-refresh"></i></asp:LinkButton>
                                                        <%--<button id="btnRefresh" runat="server" onclick="btnRefresh_click"><i class="ace-icon fa fa-2x fa-key"></i></button>--%>
                                                        <br />
                                                        <asp:Label runat="server" ID="lblCaptchaMessage"></asp:Label>
                                                    </span>
                                                </label>

                                                <div class="space"></div>

                                                <div class="clearfix">
                                                    <label class="inline">
                                                        <%--<input type="checkbox" class="ace" />
                                                        <span class="lbl">Remember Me</span>--%>
                                                    </label>

                                                    <asp:Button runat="server" ID="btnLogin" OnClientClick="CallHandler();" CssClass="width-35 pull-right btn btn-sm btn-primary" Text="Login" OnClick="btnLogin_Click">
                                                        <%--<i class="ace-icon fa fa-key"></i>
                                                        <span class="bigger-110">Login</span>--%>
                                                    </asp:Button>
                                                </div>

                                                <div class="space-4"></div>
                                            </fieldset>

                                        </div>
                                        <!-- /.widget-main -->


                                    </div>
                                    <!-- /.widget-body -->
                                </div>
                                <!-- /.login-box -->




                            </div>
                            <!-- /.position-relative -->


                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.main-content -->
        </div>
        <!-- /.main-container -->
        <!-- basic scripts -->

    </form>
</body>
</html>
