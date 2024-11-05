<%@ Page Title="" Language="C#" MasterPageFile="~/Dealer/DealerMaster.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Dealer_Default" %>

<%@ Register Src="~/UserControl/LoginSignUpDealer.ascx" TagPrefix="uc1" TagName="LoginSignUpDealer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div id="logsign">
                <br />
                <uc1:LoginSignUpDealer runat="server" ID="LoginSignUp" />

            </div>
</asp:Content>

