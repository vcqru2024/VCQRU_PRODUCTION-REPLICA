<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNew_090421.master"  AutoEventWireup="true" CodeFile="AppLogin.aspx.cs" Inherits="AppLogin" %>



<%@ Register Src="~/UserControl/LoginSignUp.ascx" TagPrefix="uc1" TagName="LoginSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:LoginSignUp runat="server" ID="LoginSignUp" />
</asp:Content>
