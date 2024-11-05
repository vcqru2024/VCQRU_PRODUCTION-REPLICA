<%@ Page Title="" Language="C#" MasterPageFile="~/LoginMaster.master" AutoEventWireup="true" CodeFile="HPLlogin.aspx.cs" Inherits="Default2" %>

<%@ Register Src="~/UserControl/LoginSignUp.ascx" TagPrefix="uc1" TagName="LoginSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:LoginSignUp runat="server" ID="LoginSignUp" />
</asp:Content>

