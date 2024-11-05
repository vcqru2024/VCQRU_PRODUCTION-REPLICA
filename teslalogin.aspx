<%@ Page Title="" Language="C#" MasterPageFile="~/LoginMaster.master" AutoEventWireup="true" CodeFile="teslalogin.aspx.cs" Inherits="teslalogin" %>
<%@ Register Src="~/UserControl/Teslaloginup.ascx" TagPrefix="uc1" TagName="TeslaLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <uc1:TeslaLogin runat="server" ID="TeslaLogin" />
</asp:Content>
