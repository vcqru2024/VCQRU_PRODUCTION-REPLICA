<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="PointsDetails.aspx.cs" Inherits="Admin_PointsDetails" %>

<%@ Register Src="~/UserControl/UC_PointsDetailsVendor.ascx" TagPrefix="uc1" TagName="UC_PointsDetailsVendor" %>





<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:UC_PointsDetailsVendor runat="server" ID="UC_PointsDetailsVendor" />
</asp:Content>

