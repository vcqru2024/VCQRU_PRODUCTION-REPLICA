<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Consumer_Profile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VCQRU | We secure you </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="codedthemes" />
    <link rel="icon" href="../img-1/favicon.png" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet" />
    <link href="../assetsfrui/icon/icofont/css/icofont.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css" />
        <link rel="icon" href="../img-1/favicon.png" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/icofont/css/icofont.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css" />
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet" />

    <script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>
    <style>
        
		 #nvh{
                background-color: #5da8ff;
        }
         #nvh ul li a{
                color:#fff;
        }

        .mandotary {
        }

        .bnkdetails {
            padding-left: 40px;
        }

        .lblmsg {
            padding: 40px;
        }

        input {
            box-shadow: none !important;
        }

        .msg_green {
            color: green;
        }

        .msg_red {
            color: red;
        }

        .profile-overlap {
            position: absolute;
            bottom: 26px;
            left: 79px;
            /* right: 0; */
            top: 56px;
            width: 40px;
            height: 40px;
            background: #eaeaea;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 22px;
            border-radius: 50%;
            padding: 5px;
            margin: 0 auto;
            box-shadow: 3px 3px 5px #2d2b2b;
        }

        .profile-overlap-edit {
            display: none;
        }


        @media (max-width: 400px) {
            .profile-overlap {
                position: absolute;
                bottom: 26px;
                left: 0px;
                right: -50px;
                width: 40px;
                height: 40px;
                background: #eaeaea;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 22px;
                border-radius: 50%;
                padding: 5px;
                margin: 0 auto;
                box-shadow: 3px 3px 5px #2d2b2b;
            }

            .profile-overlap-edit {
                display: none;
            }
        }

        @media (max-width: 600px) {
            .profile-overlap {
                position: absolute;
                bottom: 26px;
                left: 0px;
                right: -50px;
                width: 40px;
                height: 40px;
                background: #eaeaea;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 22px;
                border-radius: 50%;
                padding: 5px;
                margin: 0 auto;
                box-shadow: 3px 3px 5px #2d2b2b;
            }

            .bnkdetails {
                padding-left: 40px;
            }

            .lblmsg {
                padding: 15px;
            }

            .profile-overlap-edit {
                display: none;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">



        <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
           </asp:ScriptManager>--%>
        <cc1:ToolkitScriptManager
            runat="server"
            ID="ToolkitScriptManager1"
            ScriptMode="Release" />

        <script type="text/javascript">
            function openModal() {
                $('#myModal').modal('show');
            }
            function closemodal() {

                debugger;
                $('#exampleModal').modal('toggle');
                $('#Close1').trigger('click');

            }
            $(document).ready(function () {

                $(".accordion2 p").eq(0).addClass("active");
                $(".accordion2 div.open").eq(0).show();

                $(".accordion2 p").click(function () {
                    $(this).next("div.open").slideToggle("slow")
                        .siblings("div.open:visible").slideUp("slow"); 250
                    $(this).toggleClass("active");
                    $(this).siblings("p").removeClass("active");
                });

            });

            function checkproduct(vl) {
                PageMethods.checkNewProduct(vl, onCompleteProduct)
            }

            function onCompleteProduct(Result) {
                if (Result == true) {
                    document.getElementById("<%=lblemail.ClientID %>").innerHTML = "Email Id Already exist.";
                       document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                       document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all_Sec";

                   }
                   else {
                       document.getElementById("<%=lblemail.ClientID %>").innerHTML = "";
                       document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                       document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all";
                }
            }
        </script>
        <!-- Pre-loader start -->
        <div class="theme-loader">
            <div class="loader-track">
                <div class="loader-bar"></div>
            </div>
        </div>
        <!-- Pre-loader end -->
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">

                <nav class="navbar header-navbar pcoded-header" id="nvh">
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
                            <div class="menu_toogle" style="display: none;">
                                <i class="ti-menu"></i>
                            </div>
                            <a href="dashboard.aspx" runat="server" id="logo">
                                <img class="img-fluid logo_img" runat="server" id="Complogo" src="../assetsfrui/images/auth/logo.png" />
                            </a>
                            <a class="mobile-options">
                                <i class="ti-more"></i>
                            </a>
                        </div>

                        <div class="navbar-container container-fluid">
                            <ul class="nav-left">
                                <%--<li>--%>
                                <%--<input type="file" id="camera" accept="image/*;capture=camera" style="display:none">--%>
                                <%--<a href="CodeCheck.aspx">Check Code</a>--%>
                                <%--</li>--%>
                                <li>
                                    <a href="Dashboard.aspx"><i class="fa fa-tachometer" aria-hidden="true"></i> Dashboard</a>
                                </li>
                                <li class="active">
                                    <a href="profile.aspx?jnj8877"><i class="fa fa-users" aria-hidden="true"></i> Profile</a>

                                </li>
                                <li>
                                    <a href="transactions.aspx"><i class="fa fa-money" aria-hidden="true"></i> Transactions</a>
                                </li>

                            </ul>
                            <ul class="nav-right">

                                <li class="user-profile header-notification">
                                    <a href="#!">
                                        <asp:Image runat="server" class="img-radius" alt="User-Profile-Image" ID="top_profile_img" crossorigin="anonymous"
                                            referrerpolicy="no-referrer" />
                                        <span>
                                            <asp:Label ID="lblusertop" runat="server" /></span>
                                        <i class="ti-angle-down"></i>
                                    </a>
                                    <ul class="show-notification profile-notification">
                                        <li>
                                            <a href="changepassword.aspx">
                                                <i class="ti-user"></i>Change Password
                                            </a>
                                        </li>
                                        <li>
                                            <i class="ti-layout-sidebar-left"></i>
                                            <asp:Button runat="server" BorderStyle="None" BackColor="Transparent" Text="Logout" OnClick="Logout" />

                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">

                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">

                                        <div class="page-body">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="cover-profile">
                                                        <div class="profile-bg-img">
                                                            <img class="profile-bg-img img-fluid profile-bgimg" src="https://dashboard.mbdefence.com/img/backgrounds/wall_4.jpg" alt="bg-img" style="height: 200px;">
                                                            <div class="card-block user-info">
                                                                <div class="col-md-12">
                                                                    <div class="media-left">
                                                                        <div class="profile-image">
                                                                            <%--<img id="imgProfile" runat="server" class="user-img img-radius" src="../assetsfrui/images/user-profile/user-img.jpg" alt="user-img">--%>
                                                                            <%--moddal start--%>
                                                                            <div class="modal fade" id="myModal" role="dialog">
                                                                                <div class="modal-dialog modal-sm">
                                                                                    <div class="modal-content">
                                                                                        <div class="modal-header">
                                                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                                            <h4 class="modal-title" style="float: left; position: absolute; color: red;">Error</h4>
                                                                                        </div>
                                                                                        <div class="modal-body" style="color: firebrick;">
                                                                                            <p>File Size must be Less than 400KB</p>
                                                                                        </div>
                                                                                        <div class="modal-footer">
                                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <%--moddal end--%>
                                                                            <input type="file" id="profile_upload" accept="image/*" runat="server" onchange="this.form.submit();" style="display: none;" />
                                                                            <%--<asp:FileUpload ID="profile_upload" onchange="this.form.submit();" style="display:none; position:absolute" CssClass="form-control" runat="server" placeholder="Select A File to Upload Upto 400KB" ViewStateMode="Enabled" EnableViewState="true" BorderStyle="None" accept=".png,.jpg,.jpeg,.gif"/>--%>
                                                                            <asp:Image ID="imgProfile" runat="server" class="user-img img-radius" Style="cursor: pointer" alt="user-img" Width="100px" Height="100px" />
                                                                            <asp:UpdatePanel ID="prfl" runat="server">
                                                                                <ContentTemplate>
                                                                                    <div class="profile-overlap profile-overlap-edit" id="profile-over">
                                                                                        <i class="ti-pencil"></i>
                                                                                        <asp:Button runat="server" ID="btnprf" Style="display: none" />
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </div>

                                                                    </div>

                                                                </div>
                                                                <div class="media-body row">
                                                                    <div class="col-lg-12">
                                                                        <div class="user-title">

                                                                            <h2>
                                                                                <asp:Label ID="lblUser_name" runat="server" /></h2>
                                                                            <span class="text-white">
                                                                                <asp:Label ID="lblUser_designation" runat="server" /></span>
                                                                            <span>
                                                                                <asp:Label ID="lblMMUser" runat="server" Style="display: none;"></asp:Label></span>
                                                                        </div>
                                                                    </div>
                                                                    <div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <div class="card-block p-0">
                                                    <div class="card tabs-card">
                                                        <ul class="nav nav-tabs md-tabs md-tabs1" role="tablist">
                                                            <li class="nav-item">
                                                                <a class="nav-link" data-toggle="tab" href="#upload_document" role="tab" id="upload_nav" runat="server"><i class="fa fa-home"></i>View Document</a>
                                                                <div class="slide"></div>
                                                            </li>
                                                            <li id="profile_tab" class="nav-item ">
                                                                <a class="nav-link active" data-toggle="tab" href="#personal" role="tab" runat="server" id="profile_nav"><i class="fa fa-key"></i>Profile details</a>
                                                                <div class="slide">
                                                                </div>
                                                            </li>
                                                        </ul>



                                                        <div class="tab-content">
                                                            <div class="tab-pane " id="upload_document" role="tabpanel" aria-expanded="true" runat="server">

                                                                <div class="card1">
                                                                    <div class="card_outer">
                                                                        <div class="card-header custom-card-header bt-0">
                                                                            <h5 class="card-header-text"><i class="ti-user mr-2"></i>View Documents</h5>

                                                                        </div>



                                                                        <div class="card-block">
                                                                            <div id="NewMsgpopupld" class="alert alert-success alert-dismissible" role="alert" runat="server" style="width: 100%">


                                                                                <%--<asp:Label ID="LblMsgUpdateupld" runat="server"></asp:Label>--%>
                                                                            </div>


                                                                            <div class="row">

                                                                                <div class="form-group col-md-6">

                                                                                    <label class="col-sm-12 col-form-label custom_label">Aadhar Card</label>
                                                                                    <div id="dvadhar" runat="server" class="file-upload-wrapper" data-text="Select your file upto 400KB!">
                                                                                        <%--<input  type="file"   id="aadharfile" onchange="this.form.submit();" accept="image/*" runat="server" />--%>
                                                                                        <asp:Image ID="imgAadharCard" runat="server" crossorigin="anonymous"
                                                                                            referrerpolicy="no-referrer" />
                                                                                        <%--<asp:FileUpload ID="aadharfile" runat="server" onchange="this.form.submit();"  accept=".png,.jpg,.jpeg,.gif"  />--%>
                                                                                    </div>
                                                                                </div>


                                                                                <div class="form-group col-md-6">

                                                                                    <label class="col-sm-12 col-form-label custom_label">Aadhar Back</label>
                                                                                    <div id="Div1" runat="server" class="file-upload-wrapper" data-text="Select your file upto 400KB!">
                                                                                        <%--<input  type="file" class="file-upload-field" id="aadharback" runat="server" accept="image/*" onchange="this.form.submit();"/>--%>
                                                                                        <asp:Image ID="image_aadharback" runat="server" crossorigin="anonymous"
                                                                                            referrerpolicy="no-referrer" />
                                                                                        <%--<asp:FileUpload ID="aadharback" runat="server" onchange="this.form.submit();"  accept=".png,.jpg,.jpeg,.gif" />--%>
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="form-group col-md-6">
                                                                                    <label class="col-sm-12 col-form-label custom_label">Cancelled Cheque/Passbook</label>
                                                                                    <div class="file-upload-wrapper" id="passupload" data-text="Select your file upto 400KB!" runat="server">
                                                                                        <%--<input  type="file" class="file-upload-field" id="Passbookfile" runat="server" accept="image/*" onchange="this.form.submit();"/>--%>
                                                                                        <asp:Image ID="Imgbank" runat="server" crossorigin="anonymous"
                                                                                            referrerpolicy="no-referrer" />
                                                                                        <%--<asp:FileUpload ID="Passbookfile" runat="server" onchange="this.form.submit();"  accept=".png,.jpg,.jpeg,.gif" />--%>
                                                                                    </div>
                                                                                </div>




                                                                            </div>

                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="tab-pane active" id="personal" runat="server" role="tabpanel" aria-expanded="true">

                                                                <div class="card1">
                                                                    <div class="card_outer">

                                                                        <div class="card-header custom-card-header bt-0">
                                                                            <h5 class="card-header-text"><i class="ti-user mr-2"></i>Profile details</h5>


                                                                            <button id="edit-btn" type="button" class="edit-action f-right">
                                                                                <i class="ti-pencil"></i>

                                                                            </button>
                                                                        </div>
                                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                            <ContentTemplate>
                                                                                <div id="NewMsgpop" class="alert alert-success" role="alert" runat="server">
                                                                                    <p>
                                                                                        <%--<asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>--%>
                                                                                    </p>
                                                                                </div>
                                                                                <div class="card-block">

                                                                                    <div class="view-info">
                                                                                        <div class="profile_form" id="profile_form" runat="server">
                                                                                            <div class="row">
                                                                                                <div class="form-group col-md-6">

                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="fullName" runat="server">Full Name</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="txtPersonName" MaxLength="50" class="form-control" runat="server" placeholder="Enter Your Full Name"></asp:TextBox>
                                                                                                        <%-- <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="txtPersonName"
                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                        </cc1:FilteredTextBoxExtender>--%>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="Name is required" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="chk94" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator5" runat="server" ErrorMessage="Enter Alphabets Only"
                                                                                                            ControlToValidate="txtPersonName" ValidationExpression="^[a-zA-Z_ ]*$" />
                                                                                                        <%--<input type="text" class="form-control" value="Rohan" placeholder="Enter Your First Name">--%>
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div class="form-group col-md-6">
                                                                                                    <label class="col-sm-4 col-form-label">Mobile No.</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="txtMob" MaxLength="15" ReadOnly="true" class="form-control" runat="server" placeholder="Enter Your Mobile No"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="txtMob" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>

                                                                                                        <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                                                                                        </cc1:ValidatorCalloutExtender>
                                                                                                        <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                                                                            ID="RegExpValMobNo" runat="server" ErrorMessage="Mobile No must be between 10 to 13 number"
                                                                                                            ControlToValidate="txtMob" ValidationExpression="^[0-9]{10,13}$" />


                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="row">

                                                                                                <div class="form-group col-md-6">
                                                                                                    <label class="col-sm-4 col-form-label">Email Address</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="txtEmail" MaxLength="100" class="form-control"
                                                                                                            runat="server" placeholder="Enter Your Email Address"></asp:TextBox>
                                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server" Display="Dynamic"
                                                                                                            ControlToValidate="txtEmail" ValidationGroup="chk94"
                                                                                                            ErrorMessage="Please enter a valid email id" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                                                                        <asp:Label ID="lblemail" runat="server" CssClass="astrics"></asp:Label>
                                                                                                        <%--<input type="Email" class="form-control" value="rohansharma@gmail.com" placeholder="Enter Your Email Address">--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Address" runat="server">Address</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="txtAddress" class="form-control" placeholder="Enter Your Addresss" MaxLength="250"
                                                                                                            runat="server"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="txtAddress" ErrorMessage="Address is required " Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <%--<input type="text" class="form-control" value="71-a mukesh colony faridabad" placeholder="Enter Your Address">--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>


                                                                                            <div class="row">


                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="City" runat="server">City</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="ddlCity" MaxLength="25" class="form-control" runat="server" placeholder="Enter Your City">
                                                                                                        </asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="ddlCity" ErrorMessage="City is required" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="chk94" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator6" runat="server" ErrorMessage="Enter Alphabet Only"
                                                                                                            ControlToValidate="ddlCity" ValidationExpression="^[a-zA-Z_ ]*$" />
                                                                                                        <%--<input type="text" class="form-control" value="Faridabad" placeholder="Enter Your City">--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Pincode" runat="server">Pin code</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="txtpincode" MaxLength="6" class="form-control" runat="server" placeholder="Enter Your Pin code"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="txtpincode" ErrorMessage="Pincode is required" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>

                                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ValidationGroup="chk94" ControlToValidate="txtpincode" ValidationExpression="^[0-9]{6,6}$" Display="Dynamic" EnableClientScript="true" ErrorMessage="Enter 6 digits pincode number" runat="server" />

                                                                                                        <%--<input type="text" class="form-control" value="121222" placeholder="Enter Your Pin code">--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="row">
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Aadharno" runat="server">Aadhar Number  </asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:TextBox ID="aadharnumber" class="form-control" runat="server" MaxLength="12" placeholder="Enter Your ID No" onkeydown="return ( event.ctrlKey || event.altKey || (47<event.keyCode && event.keyCode<58 && event.shiftKey==false) || (95<event.keyCode && event.keyCode<106)|| (event.keyCode==8) || (event.keyCode==9) || (event.keyCode>34 && event.keyCode<40) || (event.keyCode==46) )"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="chk94" ControlToValidate="aadharnumber" ErrorMessage="Aadhar number is required" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ValidationGroup="chk94" ControlToValidate="aadharnumber" ValidationExpression="^[0-9]{12,12}$" Display="Dynamic" EnableClientScript="true" ErrorMessage="Enter 12 digits aadhar number" runat="server" />
                                                                                                        <%--<input type="text" class="form-control" value="SMS121364" placeholder="Enter Your ID Number">--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Label2" runat="server"> Aadhar  Card</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:FileUpload ID="aadharfile" runat="server" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" Enabled="false" class="file-upload-field"></asp:FileUpload><asp:Image runat="server" ImageUrl="~/Content/images/generated_bill.png" ID="imgaahar" />
                                                                                                        <br />
                                                                                                        <%--<input  type="file"   id="aadharfile" onchange="this.form.submit();" accept="image/*" runat="server" disabled="disabled" /><br />--%>
                                                                                                        <asp:Label runat="server" ID="lblaadhar" ForeColor="Red" Text="Upload Aadhar File first" Visible="false" />
                                                                                                        <%-- <asp:RequiredFieldValidator ID="aadharfilevalidator" runat="server" ForeColor="Red"
                                                    ControlToValidate="aadharfile" ErrorMessage="Upload Aadhar File first" Display="Dynamic">
                                                </asp:RequiredFieldValidator>--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="row">

                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Label3" runat="server"> Aadhar card back  </asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <asp:FileUpload ID="aadharback" runat="server" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" Enabled="false" class="file-upload-field"></asp:FileUpload><asp:Image runat="server" ImageUrl="~/Content/images/generated_bill.png" ID="imgback" />
                                                                                                        <br />
                                                                                                        <%--<input  type="file"  id="aadharback" runat="server" accept="image/*" onchange="this.form.submit();" disabled="disabled"/><br />--%>
                                                                                                        <asp:Label runat="server" ID="lblaadharback" ForeColor="Red" Text="Upload Aadhar back first" Visible="false" />
                                                                                                        <%--<asp:RequiredFieldValidator ID="aadharbackvalidator" runat="server" ForeColor="Red" 
                                                     ControlToValidate="aadharback" ErrorMessage="Upload Aadhar back first" Display="Dynamic">
                                                </asp:RequiredFieldValidator>--%>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="text-center fotter_btn">
                                                                                                <%--<a href="#!" class="btn btn-primary waves-effect waves-light m-r-20">Save</a>--%>

                                                                                                <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click" ValidationGroup="chk94" class="btn btn-primary waves-effect waves-light m-r-20"
                                                                                                    runat="server" Text="Update" CausesValidation="true" />

                                                                                                <asp:Button ID="btnNextDoc" OnClick="btnNextDoc_Click" class="btn btn-default waves-effect"
                                                                                                    runat="server" Text="Cancel" />

                                                                                                <asp:HiddenField ID="mmvalue" runat="server" />

                                                                                            </div>

                                                                                        </div>
                                                                                    </div>

                                                                                </div>
                                                                            </ContentTemplate>
                                                                            <Triggers>
                                                                                <asp:PostBackTrigger ControlID="btnUpDate" />

                                                                            </Triggers>
                                                                        </asp:UpdatePanel>
                                                                    </div>


                                                                    <div class="card_outer">
                                                                        <%--   <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
        <ContentTemplate>--%>
                                                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                            <ContentTemplate>
                                                                                <div class="card-header custom-card-header">
                                                                                    <h5 class="card-header-text"><i class="ti-id-badge mr-2"></i>Bank Account details</h5>
                                                                                    <button id="editbtn2" type="button" class="edit-action f-right" runat="server">
                                                                                        <asp:HiddenField ID="hdnCompID" runat="server" />
                                                                                        <i class="ti-pencil"></i>
                                                                                    </button>

                                                                                </div>
                                                                                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>


                                                                                <div id="DivNewMsg" class="alert alert-success" runat="server">
                                                                                    <p>
                                                                                        <%--<asp:Label ID="lblpopmsg" class="lblmsg" runat="server"></asp:Label>--%>
                                                                                    </p>
                                                                                </div>
                                                                                <asp:HiddenField ID="HiddenField1" runat="server" />

                                                                                <div class="card-block">


                                                                                    <div class="view-info">
                                                                                        <div class="account_form" id="Account_form" runat="server">



                                                                                            <div class="row">
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-5 col-form-label bnkdetails mandotary" ID="accountname" runat="server">Account Holder Name</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="text" class="form-control" value="Rohan Sharma" placeholder="Enter Your Account Holder Name">--%>
                                                                                                        <asp:TextBox ID="txtAccHolderNm" runat="server" class="form-control" MaxLength="150"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="PR" ControlToValidate="txtAccHolderNm" Display="Dynamic" ErrorMessage="Account holder name is required">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" TargetControlID="txtAccHolderNm"
                                                                                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:">
                                                                                                        </cc1:FilteredTextBoxExtender>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="PR" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator7" runat="server" ErrorMessage="Enter Alphabet Only"
                                                                                                            ControlToValidate="txtAccHolderNm" ValidationExpression="^[a-zA-Z_ ]*$" />
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-5 col-form-label bnkdetails mandotary" ID="ifsc" runat="server">IFSC code</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="text" class="form-control" value="ICICI00930" placeholder="Enter Your IFSC code">--%>
                                                                                                        <asp:TextBox ID="txtifscCode" runat="server" class="form-control" Text="" MaxLength="11" AutoCompleteType="Disabled"
                                                                                                            Style="text-transform: capitalize;" OnTextChanged="txtifscCode_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="PR" ControlToValidate="txtifscCode" Display="Dynamic" ErrorMessage="IFSC code is Required">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <asp:Label Style="color: red" ID="lblIfsc_error" runat="server" Text="Enter a valid IFSC Code !" />
                                                                                                    </div>
                                                                                                </div>

                                                                                            </div>

                                                                                            <div class="row">
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-5 col-form-label bnkdetails" ID="accountno" runat="server">Account number</asp:Label>
                                                                                                    <div class="col-sm-8">

                                                                                                        <%--<input type="Number" class="form-control" value="683233388299338" placeholder="Enter Your Account number">--%>
                                                                                                        <asp:TextBox ID="txtAccountNo" TextMode="Password" runat="server" class="form-control" Text="" MaxLength="20"
                                                                                                            OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="PR" ControlToValidate="txtAccountNo" Display="Dynamic" ErrorMessage="Account number is required">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <cc1:ValidatorCalloutExtender ID="ValCalloutAccountNo" runat="server" TargetControlID="RegExpValAccountNo">
                                                                                                        </cc1:ValidatorCalloutExtender>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="PR" SetFocusOnError="true"
                                                                                                            ID="RegExpValAccountNo" runat="server" ErrorMessage="Account No must be between 9 to 18 number"
                                                                                                            ControlToValidate="txtAccountNo" ValidationExpression="^[0-9]{9,18}$" />
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-5 col-form-label bnkdetails" ID="confirmaccount" runat="server">Confirm Account number</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="Number" class="form-control" value="683233388299338" placeholder="Confirm Account number">--%>
                                                                                                        <asp:TextBox ID="txtCnfAccountNo" runat="server" class="form-control" Text="" MaxLength="20"
                                                                                                            OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="PR" ControlToValidate="txtCnfAccountNo" Display="Dynamic" ErrorMessage="Account Number Required">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="RegExpValAccountNo">
                                                                                                        </cc1:ValidatorCalloutExtender>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="PR" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator2" runat="server" ErrorMessage="Account No must be between 9 to 18 number"
                                                                                                            ControlToValidate="txtCnfAccountNo" ValidationExpression="^[0-9]{9,18}$" />

                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="row">
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label ID="lblbankAcc" runat="server" CssClass="astrics"></asp:Label>
                                                                                                    <label class="col-sm-5 col-form-label bnkdetails">Bank Name</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="text" class="form-control" value="ICICI Bank" placeholder="Enter Your Bank Name">--%>
                                                                                                        <asp:TextBox ID="txtbankname" runat="server" class="form-control" Text="" MaxLength="150" onchange="checkAccountNm(this.value);"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" Display="Dynamic" ErrorMessage="Bank Name Required" runat="server" ForeColor="Red" ValidationGroup="PR" ControlToValidate="txtbankname"></asp:RequiredFieldValidator>
                                                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtbankname" runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890"></cc1:FilteredTextBoxExtender>
                                                                                                        <asp:RegularExpressionValidator Display="None" ValidationGroup="PR" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator8" runat="server" ErrorMessage="Enter alphabets only"
                                                                                                            ControlToValidate="txtbankname" ValidationExpression="^[a-zA-Z_ ]*$" />
                                                                                                    </div>
                                                                                                </div>

                                                                                                <div class="form-group col-md-6">
                                                                                                    <label class="col-sm-5 col-form-label bnkdetails">Branch</label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="text" class="form-control" value="71-a Mukesh colony Faridabad" placeholder="Enter Your Branch">--%>
                                                                                                        <asp:TextBox ID="txtBranch" runat="server" class="form-control" MaxLength="150"></asp:TextBox>
                                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" Display="Dynamic" ErrorMessage="Branch name is required" runat="server" ForeColor="Red"
                                                                                                            ValidationGroup="PR" ControlToValidate="txtBranch">
                                                                                                        </asp:RequiredFieldValidator>
                                                                                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" TargetControlID="txtBranch"
                                                                                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                                                                        </cc1:FilteredTextBoxExtender>
                                                                                                        <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="PR" SetFocusOnError="true"
                                                                                                            ID="RegularExpressionValidator9" runat="server" ErrorMessage="Enter alphabet only"
                                                                                                            ControlToValidate="txtBranch" ValidationExpression="^[a-zA-Z_ ]*$" />
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="row">



                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label ID="Label1" runat="server" CssClass="astrics"></asp:Label>
                                                                                                    <asp:Label class="col-sm-5 col-form-label bnkdetails" ID="accounttype" runat="server">Account Type</asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input type="text" class="form-control" value="ICICI Bank" placeholder="Enter Your Bank Name">--%>
                                                                                                        <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server"></asp:DropDownList>

                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="form-group col-md-6">
                                                                                                    <asp:Label class="col-sm-4 col-form-label" ID="Label4" runat="server"> Cancelled Cheque/Passbook.  </asp:Label>
                                                                                                    <div class="col-sm-8">
                                                                                                        <%--<input  type="file" class="file-upload-field" id="Passbookfile" runat="server" accept="image/*" /><br />--%>
                                                                                                        <asp:FileUpload ID="Passbookfile" runat="server" accept=".png,.PNG,.bmp,.BMP,.jpeg,.JPEG,.jpg,.JPG" class="file-upload-field"></asp:FileUpload>
                                                                                                        <asp:Image runat="server" ImageUrl="~/Content/images/generated_bill.png" ID="imgpass" />
                                                                                                        <br />
                                                                                                        <asp:RequiredFieldValidator ID="passbookkvalidator" runat="server" ForeColor="Red"
                                                                                                            ControlToValidate="Passbookfile" ErrorMessage="Upload Passbook file first" Display="Dynamic">
                                                                                                        </asp:RequiredFieldValidator>

                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="text-center fotter_btn">
                                                                                                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click1" ValidationGroup="PR" class="btn btn-primary waves-effect waves-light m-r-20"
                                                                                                    runat="server" Text="Save" />
                                                                                                <%--<a href="#!" class="btn btn-primary waves-effect waves-light m-r-20">Save</a>--%>
                                                                                                <%--<asp:Button ID="btnReset" OnClick="btnReset_Click1" CausesValidation="false" class="btn btn-default waves-effect" runat="server" Text="Cancel" />--%>
                                                                                                <%--<a href="#!" id="edit-cancel2" class="btn btn-default waves-effect">Cancel</a>--%>
                                                                                                <asp:Button ID="cancel" OnClick="cancel_Click" class="btn btn-default waves-effect"
                                                                                                    runat="server" Text="Cancel" />
                                                                                            </div>

                                                                                        </div>

                                                                                    </div>


                                                                                </div>
                                                                            </ContentTemplate>
                                                                            <Triggers>
                                                                                <asp:PostBackTrigger ControlID="btnSubmit" />
                                                                            </Triggers>
                                                                        </asp:UpdatePanel>
                                                                    </div>
                                                                </div>


                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>


                </div>

            </div>

        </div>

        <div id="dealerInformation" runat="server">
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>

                                <div class="modal-body">

                                    <div class="row">
                                        <div class="form-group col-md-12" id="techid">
                                            <label class="col-sm-12 col-form-label">Technician ID </label>
                                            <div class="col-sm-12">
                                                <%--<input type="text" class="form-control" placeholder="Enter Technician ID">--%>
                                                <asp:TextBox ID="employeeid" class="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>

                                        <div class="form-group col-md-12">
                                            <label class="col-sm-12 col-form-label">Dealer Code</label>
                                            <div class="col-sm-12">
                                                <%--<input type="text" class="form-control" placeholder="Enter Dealer code">--%>
                                                <asp:TextBox ID="distributorid" class="form-control" runat="server"></asp:TextBox>

                                            </div>
                                        </div>
                                        <div id="dvdealermsg" class="alert alert-success" runat="server">
                                            <p>
                                            </p>
                                        </div>
                                        <%--<asp:Label runat="server" ID="lbldealerinfomation" style="padding-left:32px"></asp:Label>--%>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" CssClass="btn btn-primary waves-effect waves-light m-r-20" ID="updateDealer" Text="Submit" OnClick="updateDealer_Click" />
                                    <%--<button type="button" class="btn btn-primary waves-effect waves-light m-r-20" data-dismiss="modal">Submit</button>--%>
                                    <%--<button type="button" class="btn btn-default" onclick="closemodal()">Close</button>--%>
                                    <input type="button" class="btn btn-default" onclick="closemodal()" value="Close" />
                                    <asp:Button runat="server" CssClass="btn btn-defaul" ID="Close1" Text="Close" Style="display: none" OnClick="Close1_Click" />
                                </div>

                            </ContentTemplate>

                        </asp:UpdatePanel>
                    </div>

                </div>
            </div>
        </div>
        <script type="text/javascript" src="../assetsfrui/js/bootstrap.min.js"></script>
        <!-- <script type="text/javascript" src="assets/js/jquery-slimscroll/jquery.slimscroll.js"></script> -->
        <script type="text/javascript" src="../assetsfrui/js/script.js"></script>
        <script src="../assetsfrui/js/pcoded.min.js"></script>
        <script src="../assetsfrui/js/vartical-demo.js"></script>
        <!-- <script src="assets/js/jquery.mCustomScrollbar.concat.min.js"></script> -->
    </form>
</body>
<script>
    debugger;
    $('#edit-btn').click(function () {
        debugger

        if ($('.profile_form ').attr("class") == 'profile_form' && $('#imgAadharCard').attr('src') == '') {
            $('#aadharfile').removeAttr('disabled');

        }
        else {
            $('#aadharfile').attr('disabled', 'disabled');

        }

        if ($('.profile_form ').attr("class") == 'profile_form' && $('#image_aadharback').attr('src') == '') {

            $('#aadharback').removeAttr('disabled');

        }
        else {

            $('#aadharback').attr('disabled', 'disabled');
        }
        $('.profile_form ').toggleClass('profile_form-edit');


        //$('#profile-over').toggleClass('profile-overlap-edit');
        debugger;
        var x = $('.profile_form ').attr('class');

        if ($('#mmvalue').val() !== '0' && x == 'profile_form profile_form-edit') {
            if ($('#employeeid').val() == '' && $('#distributorid').val() != '') {
                $('#distributorid').attr('disabled', 'disabled')
                $('#techid').hide()
            }
            else
                $('#techid').show()
            $('#exampleModal').modal();

        }
        if (x == 'profile_form profile_form-edit') {
            $('#fullName').text($('#fullName').text() + '*');
            $('#Address').text($('#Address').text() + '*');
            $('#City').text($('#City').text() + '*');
            $('#Pincode').text($('#Pincode').text() + '*');
            $('#Aadharno').text($('#Aadharno').text() + '*');
            $('#Label2').text($('#Label2').text() + '*');
            $('#Label3').text($('#Label3').text() + '*');

        }
        else {
            $('#fullName').text($('#fullName').text().replace('*', ''));
            $('#Address').text($('#Address').text().replace('*', ''));
            $('#City').text($('#City').text().replace('*', ''));
            $('#Pincode').text($('#Pincode').text().replace('*', ''));
            $('#Aadharno').text($('#Aadharno').text().replace('*', ''));
            $('#Label2').text($('#Label2').text().replace('*', ''));
            $('#Label3').text($('#Label3').text().replace('*', ''));

        }

    });
    $('#editbtn2').click(function () {

        $('.account_form ').toggleClass('account_form-edit');

        if ($('.account_form ').attr("class") == 'account_form account_form-edit' && $('#Imgbank').attr('src') == '')
            $('#Passbookfile').removeAttr('disabled');
        else
            $('#Passbookfile').attr('disabled', 'disabled');
        var clas = $('.account_form ').attr('class');
        if (clas == 'account_form account_form-edit') {
            $('#accountname').text($('#accountname').text() + '*');
            $('#ifsc').text($('#ifsc').text() + '*');
            $('#accountno').text($('#accountno').text() + '*');
            $('#confirmaccount').text($('#confirmaccount').text() + '*');
            $('#accounttype').text($('#accounttype').text() + '*');
            $('#Label4').text($('#Label4').text() + '*');
        }
        else {
            $('#accountname').text($('#accountname').text().replace('*', ''));
            $('#ifsc').text($('#ifsc').text().replace('*', ''));
            $('#accountno').text($('#accountno').text().replace('*', ''));
            $('#confirmaccount').text($('#confirmaccount').text().replace('*', ''));
            $('#accounttype').text($('#accounttype').text().replace('*', ''));
            $('#Label4').text($('#Label4').text().replace('*', ''));
        }
    });

    $('#edit-cancel').click(function () {
        debugger;
        $('.profile_form ').toggleClass('profile_form-edit');
    });
    $('#edit-cancel2').click(function () {

        $('.account_form ').toggleClass('account_form-edit');
    });

    $('.menu_toogle').click(function () {
        $('.nav-left').toggleClass('slide_show');
    });

    $(".document_upload").on("change", ".file-upload-field", function () {
        $(this).parent(".file-upload-wrapper").attr("data-text", $(this).val().replace(/.*(\/|\\)/, ''));
    });

//$('#profile_tab').click(function(){
//$('#exampleModal').modal();

//});
</script>
<script type="text/javascript">
    $(document).ready(function () {
        debugger;
        if ($('.profile_form ').attr("class") != 'profile_form' && $('#imgAadharCard').attr('src') == '') {
            $('#aadharfile').removeAttr('disabled');

        }
        else {
            $('#aadharfile').attr('disabled', 'disabled');

        }
        if ($('.profile_form ').attr("class") = 'profile_form' && $('#image_aadharback').attr('src') == '') {

            $('#aadharback').removeAttr('disabled');

        }
        else {

            $('#aadharback').attr('disabled', 'disabled');
        }
        $(".accordion2 p").eq(17).addClass("active");
        $(".accordion2 div.open").eq(11).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
                .siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });












    function CheckBankMsg() {
        $('#bnkDetail').modal();
        return false;
    }

    function bankDtls() {
        window.Location.href = "FrmBankAccount.aspx";
    }

</script>
<script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(17).addClass("active");
        $(".accordion2 div.open").eq(11).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
                .siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });

    function CheckBankMsg() {
        $('#bnkDetail').modal();
        return false;
    }

    function bankDtls() {
        window.Location.href = "FrmBankAccount.aspx";
    }
</script>

<script language="javascript" type="text/javascript">

    function checkAccountNm(vl) {
        PageMethods.checkNewAccount(vl, onCompleteAccount)
    }
    function onCompleteAccount(Result) {
        if (Result == true) {
            document.getElementById("<%=lblbankAcc.ClientID %>").innerHTML = "Bank Name Already exist.";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            else {
                document.getElementById("<%=lblbankAcc.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
        }
    }



    function checkCourior(vl) {
        var val = vl + "*" + document.getElementById("<%=hdnCompID.ClientID %>").value;
        PageMethods.checkNewLabel(val, onCompleteLaebl)
    }
    function onCompleteLaebl(Result) {
        if (Result == true) {

            document.getElementById("<%=btnSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            else {

                document.getElementById("<%=btnSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
        }
    }
</script>
<script type="text/javascript">
    $(document).ready(function () {
        setTimeout(function () {
            //debugger;
            if ($('#ctl00_ContentPlaceHolder1_lblMMUser').text() == "NA")// || $('#ctl00_ContentPlaceHolder1_lblMMUser').text()=="NA"
                $('#divCompInformation').hide();
            else
                $('#divCompInformation').show();
        }, 1000);
    });
    function UploadFile(fileUpload) {
        debugger;
        if (fileUpload.value != '') {
            $('#btnproupload').click();
        }
    };
    $('#imgProfile').click(function () {
        $('#profile_upload').click();
    });

        //function isValidMobile(number) {
        //    let regEx = /^[6-9][0-9]{9}$/i;
        //    return number && number.length === 10 && regEx.test(number);
        //}
</script>
</html>
