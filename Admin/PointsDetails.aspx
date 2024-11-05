<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="PointsDetails.aspx.cs" Inherits="Admin_PointsDetails" %>

<%@ Register Src="~/UserControl/UC_PointsDetails.ascx" TagPrefix="uc1" TagName="UC_PointsDetails" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:UC_PointsDetails runat="server" ID="UC_PointsDetails" />
</asp:Content>

