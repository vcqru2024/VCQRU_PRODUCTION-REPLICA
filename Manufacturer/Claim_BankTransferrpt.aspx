<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Claim_BankTransferrpt.aspx.cs" Inherits="Manufacturer_Claim_BankTransferrpt" %>

<%@ Register Src="~/UserControl/Claim_BankTransactionrpt.ascx" TagPrefix="uc1" TagName="ClaimBankTransactionrpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <uc1:ClaimBankTransactionrpt runat="server" ID="UC_BankReport" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

