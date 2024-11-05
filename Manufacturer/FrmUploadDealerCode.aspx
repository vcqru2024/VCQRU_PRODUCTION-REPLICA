<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="FrmUploadDealerCode.aspx.cs" Inherits="Manufacturer_FrmUploadDealerCode" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

    </script>

    <script type="text/javascript">

        function Confirm(msg) {
            debugger;

            if (confirm(msg)) {
                document.getElementById("<%= hdncon.ClientID %>").value = "Yes";
                document.getElementById("<%= UpdateProgress1.ClientID %>").style.display = "block";
                document.getElementById("<%= btnsubmit.ClientID %>").click();
            } else {
                document.getElementById("<%= hdncon.ClientID %>").value = "No";
                document.getElementById("<%= btnsubmit.ClientID %>").click();
            }
        }

        function hideprogress() {
            document.getElementById("<%= UpdateProgress1.ClientID %>").style.display = "none";
        }

        function btnsave() {
            document.getElementById("<%= UpdateProgress1.ClientID %>").style.display = "block";
            document.getElementById("<%= btnsv.ClientID %>").click();
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>


    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; top: 0px; z-index: 100001;"
                class="NewmodalBackground">
                <div style="margin-top: 300px;" align="center">
                    <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                    <span style="color: White;">Please Wait.....<br />
                    </span>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="sort-destination-loader sort-destination-loader-showing">
                        <div class="portfolio-list sort-destination" data-sort-id="portfolio">
                            <div class="card card-admin form-wizard profile box_card">
                                <header class="card-header">
                                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Upload Dealer File</h4>
                                </header>


                                <div class="card-body card-body-nopadding">

                                    <div class="form-row">
                                        <div class="col-lg-12" style="margin-top: 5px;">
                                            <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                        </div>

                                        <div class="col-lg-12" style="margin-top: 15px;">
                                            Please Upload Dealer File
                                <asp:LinkButton ID="lnkDownload" runat="server" Style="float: right;" OnClick="lnkDownload_Click">Download Sample Dealer Code File</asp:LinkButton>
                                        </div>

                                        <input type="file" id="codesupload" onchange="this.form.submit();" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" runat="server" />
                                        <%--<asp:FileUpload ID="codesupload" runat="server" CssClass="form-control form-control-sm" />--%>
                                        <asp:Button ID="btnsubmit" runat="server" Style="display: none;" CssClass="form-control form-control-sm" OnClick="btnsubmit_Click" Text="Submit" />
                                        <asp:Button ID="btnsv" runat="server" Text="Button" OnClick="btnsv_Click" Style="display: none;" />
                                    </div>

                                    <div class="form-row">
                                        <div class="col-lg-4 card card-admin form-wizard medias" style="margin-top: 20px;">

                                            <%--<asp:Label ID="LabelAlertNewText" runat="server" Text="" Font-Size="11px"></asp:Label><br />--%>
                                            <asp:Button ID="LinkButton1" runat="server" CssClass="btn btn-primary" Text="Download Employee Master File" OnClick="LinkButton1_Click" />
                                            <asp:HiddenField ID="hdncon" runat="server" />
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

