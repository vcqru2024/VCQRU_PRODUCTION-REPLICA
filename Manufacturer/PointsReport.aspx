<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="PointsReport.aspx.cs" Inherits="Manufacturer_PointsReport" %>

<%@ Register Src="~/UserControl/UC_PointReport.ascx" TagPrefix="uc1" TagName="UC_PointReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <uc1:UC_PointReport runat="server" ID="UC_PointReport" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
