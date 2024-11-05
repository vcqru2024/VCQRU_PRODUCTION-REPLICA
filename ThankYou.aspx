<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNew.master" AutoEventWireup="true" CodeFile="ThankYou.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="jumbotron text-center">
  <h1 class="display-3">Thank You!</h1>
  <p class="lead"><strong>Our Team</strong> will get back to you with next steps!</p>
  <hr>
  <%--<p>
    Having trouble? <a href="ContactNew.aspx">Contact us</a>
  </p>--%>
  <p class="lead">
    <a class="btn btn-primary btn-sm" href="/" role="button">Continue to homepage</a>
  </p>
</div>
</asp:Content>

