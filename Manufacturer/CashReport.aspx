<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="CashReport.aspx.cs" Inherits="Manufacturer_CashReport" %>
<%@ Register Src="~/UserControl/UC_CashReport.ascx" TagPrefix="uc1" TagName="UC_CashReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <uc1:UC_CashReport runat="server" ID="UC_CashReport" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

