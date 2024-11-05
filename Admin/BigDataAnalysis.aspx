<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="BigDataAnalysis.aspx.cs" Inherits="Admin_BigDataAnalysis" %>

<%@ Register Src="~/UserControl/UC_BigDataAnalysis.ascx" TagPrefix="uc1" TagName="UC_BigDataAnalysis" %>








<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <uc1:UC_BigDataAnalysis runat="server" ID="UC_BigDataAnalysis" />
</asp:Content>
