<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="ClaimReport_BankPayments.aspx.cs" Inherits="Manufacturer_ClaimReport_BankPayments" %>

<%@ Register Src="~/UserControl/ClaimReportBankPayment.ascx" TagPrefix="uc1" TagName="ClaimReportBankPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <uc1:ClaimReportBankPayment runat="server" ID="ClaimReport1" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

