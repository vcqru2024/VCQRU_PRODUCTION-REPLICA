<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Claim Report" CodeFile="ClaimReportVendor.aspx.cs" Inherits="BrandLoyaltyAwards" %>

<%@ Register Src="~/UserControl/ClaimReportVendor.ascx" TagPrefix="uc1" TagName="ClaimReportVen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <uc1:ClaimReportVen runat="server" ID="ClaimReport1" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
