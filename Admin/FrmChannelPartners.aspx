<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Pending Print Lables Receipt" CodeFile="FrmChannelPartners.aspx.cs" Inherits="FrmChannelPartners" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(42).addClass("active");
            $(".accordion2 div.open").eq(40).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
        .pad
        {
            text-align: left;
            padding: 0px 4px 0 4px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "Images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "Images/plus.gif";
            }
        }        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="make_partner">
                    <table width="99%">
                        <tr>
                            <td width="40%">
                                &nbsp;Become Channel Partner
                            </td>
                            <td width="45%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label><asp:HiddenField ID="hdCompanyNm"
                        runat="server" />
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearch">
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 13%;">
                                <asp:TextBox ID="txtPartnerName" runat="server" CssClass="reg_txt" placeholder="Partner Name" />
                            </td>
                            <td align="justify" style="width: 10%;">
                                <asp:TextBox ID="txtDateFrom" runat="server" onkeydown="return checkShortcut();"
                                    CssClass="reg_txt" placeholder="Date From"></asp:TextBox>
                            </td>
                            <td align="justify" style="width: 10%;">
                                <asp:TextBox ID="txtDateTo" runat="server" onkeydown="return checkShortcut();" CssClass="reg_txt"
                                    placeholder="Date To"></asp:TextBox>
                            </td>
                            <td align="left" width="12%">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="BtnSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="BtnSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="BtnRefesh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="BtnRefesh_Click"
                                        ToolTip="Refresh" />
                                </div>
                            </td>
                            <td>
                                <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateTo"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>
            <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                    <h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 20px; display: none;">
                                    <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                        Text="Payment Received: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </h4>
                    <asp:GridView ID="GrdCourierDispatch" runat="server" AutoGenerateColumns="False"
                        CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdCourierDispatch_PageIndexChanging"
                        OnRowCommand="GrdCourierDispatch_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Entry Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("Entry_Date","{0:dd-MMM-yyyy hh:mm:ss tt}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="14%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Partner Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblpartnernm" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="27%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblpartnermobno" runat="server" Text='<%# Bind("Mobile_No") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="E-mail">
                                <ItemTemplate>
                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PAN No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblpartnerPAN" runat="server" Text='<%# Bind("PANNo") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Quantity">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Staus">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatusReceived" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="16%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                   <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/24x24.png"
                                        Height="16px" Width="16px" CommandName="LabelReceipt" CommandArgument='<%# Bind("PartnerID") %>'
                                        ToolTip="Receipt Courier" CausesValidation="false" />&nbsp;
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Content/images/Erase.png" Height="12px"
                                        Width="12px" CommandName="DenyLabels" CommandArgument='<%# Bind("PartnerID") %>'
                                        ToolTip="Deny Courier" CausesValidation="false" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>--%>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    <asp:Label ID="lblCourierId" runat="server" Text="" Visible="false"></asp:Label>
                </div>
            </asp:Panel>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelAlert" runat="server" Width="20%">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <br />
                            <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label>
                            <span id="MyRadio" runat="server" visible="false">
                                <asp:RadioButton ID="rdReceipt" runat="server" Text="Receipt" Checked="true" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceipts" runat="server" Text="Receive with scrap" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceiptd" runat="server" Text="Deny" GroupName="REC" />&nbsp;&nbsp;
                            </span>
                            <br />
                            <br />
                            <asp:Button ID="btnYesReceipt" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYesReceipt_Click" />&nbsp;&nbsp;<asp:Button
                                ID="btnNoReceipt" runat="server" Text="No" CssClass="button_all" OnClick="btnNoReceipt_Click" />
                            <br />
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
