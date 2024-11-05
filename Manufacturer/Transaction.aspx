<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Transaction.aspx.cs" Inherits="Manufacturer_Transaction" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 500px;
            height: 300px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }

        .ajax__calendar_today {
            padding: 0px 0px 0px 0px;
        }

        .ajax__calendar_dayname {
            padding: 0px 0px 0px 0px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(3).addClass("active");
            $(".accordion2 div.open").eq(3).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-161741227-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag() { dataLayer.push(arguments); }
        gtag('js', new Date());

        gtag('config', 'UA-161741227-1');
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; z-index: 100001; top: 0px;"
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
                                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Transaction</h4>
                                </header>
                                <div class="card-body card-body-nopadding">
                                    <div class="form-row">
                                        <div class="col-lg-12" style="margin-top: 5px;">
                                            <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                        </div>

                                        <div class="form-group col-lg-6">
                                            <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                                ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                        </div>
                                        <div class="form-group col-lg-6">
                                            <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                                ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group col-lg-8">
                                            <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                    ToolTip="Search" OnClick="ImgSearch_Click" />
                                            <asp:ImageButton ID="ImgRefresh" runat="server" OnClick="ImgRefresh_Click" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset" />

                                            <asp:Button ID="btnappr" runat="server" Text="Approved" CssClass="btn btn-primary" Style="margin-left: 5px;" OnClick="btnappr_Click" OnClientClick="return confirm('Are you sure you want to Approved it.?');" />
                                            <asp:Button ID="btndisappr" runat="server" Text="Dis_Approved" CssClass="btn btn-primary" Style="margin-left: 5px;" />

                                            <asp:Button ID="btnDownloadExcel" runat="server" Text="Download" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" Width="150" CssClass="btn btn-primary" Style="margin-left: 5px;" />
                                            <asp:Label Text="" runat="server" Visible="false" ID="Label7" Style="font-size: 13px; font-weight: bold;"></asp:Label>
                                        </div>
                                        <div class="form-group col-lg-4">


                                            <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                                Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                                TargetControlID="txtDateFrom" WatermarkText="Date From....">
                                            </cc1:TextBoxWatermarkExtender>
                                            <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                                Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                                WatermarkText="Date To....">
                                            </cc1:TextBoxWatermarkExtender>

                                            <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="btndisappr"
                                                CancelControlID="btncls" BackgroundCssClass="Background">
                                            </cc1:ModalPopupExtender>
                                        </div>
                                    </div>


                                </div>

                                <div class="form-group col-lg-12" style="overflow: scroll; max-height: 500px;">
                                    <asp:Label ID="lblcount" runat="server" Text=""></asp:Label>
                                    <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                        EmptyDataText="Record Not Found" BorderColor="transparent" AllowPaging="True" OnPageIndexChanging="GrdLabel_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="#">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsl" runat="server" Text='<%# Bind("slno") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle HorizontalAlign="Center" Width="2%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mobile Number" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmob" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Amount Transffered" HeaderStyle-Wrap="true" ItemStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblamount" runat="server" Text='<%# Bind("Amount_Transfer") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="3%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Technician ID" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbltechnicianId" runat="server" Text='<%# Bind("TechnicianId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dealer Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldealerCode" runat="server" Text='<%# Bind("DealerCode") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="State">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblstate" runat="server" Text='<%# Bind("State") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Designation">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Customer Name" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblConsumerName" runat="server" Text='<%# Bind("Custommer_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Account Holder Name" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAHName" runat="server" Text='<%# Bind("Account_HolderNm") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Account Number" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Bind("Account_No") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Branch">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBranch" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="IFSC Code" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIFSCCode" runat="server" Text='<%# Bind("IFSC_Code") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="City">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcity" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbladdr" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Aadhar Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbladhnum" runat="server" Text='<%# Bind("aadharNumber") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblstatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblrem" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="5%" />
                                            </asp:TemplateField>

                                        </Columns>

                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
        <div class="form-row">
            <div class="form-group col-lg-12">
                <div class="form-group col-lg-3">
                    Fill Remark
                </div>
                <div class="form-group col-lg-9">
                    <asp:TextBox ID="txtrem" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-sm"></asp:TextBox>

                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-lg-12">
                <asp:Button ID="btnsmt" runat="server" Text="Submit" CssClass="btn btn-primary" Style="margin-left: 5px;" OnClick="btnsmt_Click" />
                <asp:Button ID="btncls" runat="server" Text="Close" CssClass="btn btn-primary" Style="margin-left: 5px;" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>

