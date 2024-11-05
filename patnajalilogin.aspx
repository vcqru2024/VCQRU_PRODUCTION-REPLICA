<%@ Page Title="" Language="C#" MasterPageFile="~/LoginMaster.master" AutoEventWireup="true" CodeFile="patnajalilogin.aspx.cs" Inherits="patnajalilogin" %>

<%@ Register Src="~/UserControl/PFLlogin.ascx" TagPrefix="uc1" TagName="PFLlogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <uc1:PFLlogin runat="server" ID="PFLlogin" />
</asp:Content>

