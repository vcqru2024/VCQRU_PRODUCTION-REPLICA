<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNew.master" AutoEventWireup="true" CodeFile="demo-registration.aspx.cs" Inherits="demo_registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
	<!-- START ABOUT US -->
	<section class="login-section theme-bg-default" style="position: relative; background-position: center; background-size: cover; z-index: 1;">
      <div class="container position_index">
      <div class="row"> 
        <div class="col-md-12 col-xs-12" data-aos="zoom-in" data-aos-delay="200">
         <div class="demo-registration">
  <div class="signup-connect">
    <h1>Create An Account</h1><i class="mdi mdi-account-search user-icon"></i>
    <a href="#" class="btn btn-social btn-facebook">
      <i class="mdi mdi-facebook" aria-hidden="true"></i>
      Sign in with Facebook
    </a>
    <a href="#" class="btn btn-social btn-twitter">
      <i class="mdi mdi-twitter" aria-hidden="true"></i>
      Sign in with Twitter
    </a>
    <a href="#" class="btn btn-social btn-google">
      <i class="mdi mdi-google-plus" aria-hidden="true"></i>
      Sign in with Google
    </a>
   
  </div>
  <div class="signup-classic">
    <h2>Modern Website Form</h2>
      
    <div class="form">
      <fieldset class="username">
        <input type="text" placeholder="username">
      </fieldset>
      <fieldset class="email">
        <input type="email" placeholder="email">
      </fieldset>
      <fieldset class="password">
        <input type="password" placeholder="password">
      </fieldset>
      <button type="submit" class="btn">Sign up</button>
    </div>
  </div>
</div>
    </div>
  </div>
  </div>
        </section>
	<!-- END ABOUT US -->
</asp:Content>

