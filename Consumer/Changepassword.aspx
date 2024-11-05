<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="Consumer_dashboard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>VCQRU | We secure you</title>
      <meta charset="utf-8"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="description" content="" />
      <meta name="keywords" content="" />
      <meta name="author" content="codedthemes"/>
      <link rel="icon" href="../img-1/favicon.png" type="image/x-icon"/>
     <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet"/>
	 <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/icofont/css/icofont.css"/>
      <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css"/>
      <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css"/>
      <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css"/>
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet" />
   <script type="text/javascript">
       $(document).ready(function () {

           $(".accordion2 p").eq(1).addClass("active");
           $(".accordion2 div.open").eq(1).show();

           $(".accordion2 p").click(function () {
               $(this).next("div.open").slideToggle("slow")
                   .siblings("div.open:visible").slideUp("slow");
               $(this).toggleClass("active");
               $(this).siblings("p").removeClass("active");
           });

       });
    </script>
    <style>
        .class_green{
            color:green;
        }
        .class_red{
            color:green;
        }
    </style>
   </head>
<body>
    <form id="form1" runat="server" >
     <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
        <!-- Container-fluid starts -->
        
         <cc1:ToolkitScriptManager ID="toolscriptmanager" runat="server" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    <div class="signup-card card-block auth-body mr-auto ml-auto">
                        <div class="md-float-material">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="auth-box">
                                     <a href="dashboard.aspx">   <img src="../image/test/close.png"/ style="width:20px; height:20px; float:right">
                              </a>
                                         <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">Change Password.</h3>
                                    </div>
                                </div>
                                <hr/>
                                                              <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                <p>
                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label></p>
            </div> <asp:Label ID="LblMsg" runat="server" CssClass="astrics"  Font-Bold="false"
                                Text=""></asp:Label><br />
                               <div class="input-group">
                                   
                                   <asp:TextBox ID="txtoldpass" MaxLength="50" TextMode="Password" class="form-control"
                                 runat="server" placeholder="Old Password"></asp:TextBox><br />
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidatorNew3" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PRO" ControlToValidate="txtoldpass" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <span class="md-line"></span>
                                </div>
                                <div class="input-group">
                                  
                                      <asp:TextBox ID="txtnewpass" MaxLength="20" TextMode="Password" class="form-control"
                                runat="server" placeholder="Choose Password"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PRO" ControlToValidate="txtnewpass" Display="Dynamic"></asp:RequiredFieldValidator>
                            <cc1:ValidatorCalloutExtender ID="ValCalloutNewPass" runat="server" TargetControlID="RegExpValNewPass">
                            </cc1:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator Display="None" ValidationGroup="PRO" SetFocusOnError="true"
                                ID="RegExpValNewPass" runat="server" ErrorMessage="Password must be between 4 to 20 character"
                                ControlToValidate="txtnewpass" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{4,20}$" />
                                    <span class="md-line"></span>
                                </div>
                                <div class="input-group">
                                    <asp:TextBox ID="txtreenterpass" MaxLength="50"  class="form-control form-control-sm" TextMode="Password"
                                runat="server" placeholder="Confirm Password"></asp:TextBox>
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PRO" ControlToValidate="txtreenterpass"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                ControlToCompare="txtnewpass" ControlToValidate="txtreenterpass" Display="Dynamic" ForeColor="Red"
                                Type="String" Operator="Equal" Text="Password not matched"></asp:CompareValidator>
                                    <span class="md-line"></span>
                                </div>
                       
                                <div class="text-center fotter_btn">
                                    <%--<div class="col-md-12">
                                        <button type="button" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">Sign up now.</button>
                                    </div>--%>
                                        <asp:Button ID="btnChangePass" OnClick="btnChangePassword_Click" ValidationGroup="PRO"  class="btn btn-primary waves-effect waves-light m-r-20" runat="server" Text="Save" />
                                <asp:Button ID="btnReset" OnClick="btnReset_Click" class="btn btn-default waves-effect waves-light m-r-20" runat="server" Text="Reset" />             
                                </div>
                                <hr/>
                                        <div class="text-center fotter_btn">
                                             <a href="../login.aspx">Login</a>
                                        </div>
                                       
                            </div>
                                </ContentTemplate>

                            </asp:UpdatePanel>
                                                       
                        </div>
                        <!-- end of form -->
                    </div>
                    <!-- Authentication card end -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>
    
        </form>
<script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>

<script type="text/javascript" src="../assetsfrui/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="assets/js/jquery-slimscroll/jquery.slimscroll.js"></script> -->
<script type="text/javascript" src="../assetsfrui/js/script.js"></script>
<script src="../assetsfrui/js/pcoded.min.js"></script>
<script src="../assetsfrui/js/vartical-demo.js"></script>
<!-- <script src="assets/js/jquery.mCustomScrollbar.concat.min.js"></script> -->
        
</body>
    <script>

$('.menu_toogle').click(function(){
$('.nav-left').toggleClass('slide_show');
});
        debugger;
        function gotosummary() {
            debugger;
            window.location.href = '../consumer/transactions.aspx?summary=1'
        }
</script>
</html>
