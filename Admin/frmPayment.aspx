<%@ Page Title="Payments" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmPayment.aspx.cs" Inherits="frmPayment" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(58).addClass("active");
            $(".accordion2 div.open").eq(58).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .boldcls
        {
            font-weight: bold;
            font-size: 14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        z-index: 10000001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="make_payment">
                    <table width="99%">
                        <tr>
                            <td width="30%">
                                &nbsp;&nbsp;Make / View Payments
                            </td>
                            <td width="55%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Payment" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearchDemo">
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 13%;">
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="justify" style="width: 13%;">
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="justify" width="23%" id="tdddlComp" runat="server">
                                <asp:DropDownList ID="ddlComp" AutoPostBack="true" OnSelectedIndexChanged="ddlComp_SelectedIndexChanged"
                                    runat="server" CssClass="reg_txt">
                                </asp:DropDownList>
                            </td>
                            <td align="justify" width="22%">
                                <asp:DropDownList ID="ddlPro" runat="server" CssClass="reg_txt">
                                </asp:DropDownList>
                            </td>
                            <td align="justify" width="21%">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="reg_txt">
                                </asp:DropDownList>
                            </td>
                            <td align="left" width="15%">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="BtnSearchDemo" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="BtnSearchDemo_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="BtnSearchDemoRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="BtnSearchDemoRefesh_Click" ToolTip="Refresh" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                    TargetControlID="txtDateFrom" WatermarkText="From..">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                    WatermarkText="To..">
                                </cc1:TextBoxWatermarkExtender>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>
            <fieldset class="Newfield" style="width: 98%;display:none;">
                <legend>Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td colspan="12" style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/check_act.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 16%;">
                                        Received Payment
                                    </td>
                                    <td style="width: 2%;">
                                        <img alt="" src="../Content/images/Erase.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 15%;">
                                        Rejected Request
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </fieldset>
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
                                        Text="Pending Payment Requested: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </h4>
                    <asp:GridView ID="GrdCodePrintDemo" runat="server" AutoGenerateColumns="False" CssClass="grid"
                        ShowFooter="true" DataKeyNames="ReqSt" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdCodePrintDemo_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblAllotDateDemodate" runat="server" Text='<%# Bind("Req_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                    <asp:Label ID="lblreqesttransno" runat="server" Text='<%# Bind("Request_No") %>'
                                        Visible="false"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Company Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCompName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblPayMode" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="16%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Details" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblPayDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="22%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Req. Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblPayRequestedAmount123" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                        runat="server" Text='<%# Bind("Req_Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="P1" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" CssClass="grd_pad" Width="13%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rec. Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblPayAmount" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                        runat="server" Text='<%# Bind("Rec_Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="P2" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                                </FooterTemplate>
                                <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Right" />
                                <ItemStyle HorizontalAlign="Right" CssClass="grd_pad" Width="13%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:Label ID="lblpayremarks" runat="server" Text='<%# Bind("Remark") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="33%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatusl" runat="server" Text='<%# Bind("ReqSt") %>'></asp:Label>
                                    <%--<%
                                        try
                                        {
                                            Status = GrdCodePrintDemo.DataKeys[index].Values["ReqSt"].ToString();
                                        }
                                        catch
                                        {
                                        }
                                        if (Status == "Pending")
                                        {
                                    %>
                                    <img alt="" src="../Content/images/loader.gif" height="12px" width="12px" title="Pending Request" />
                                    <%}
                                        else if (Status == "Rejected")
                                        {%>
                                    <img alt="" src="../Content/images/Erase.png" height="12px" width="12px" title="Rejected Request" />
                                    <%}
                                        else
                                        { %>
                                    <img alt="" src="../Content/images/check_act.png" height="12px" width="12px" title="Received Payment" />
                                    <%} %>
                                    <%index++; %>--%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>                                
                                <asp:ImageButton ID="ImgSendMail" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Request_No") %>'
                                    CommandName="SendMail" Width="12px" Height="13px" ImageUrl="../Content/images/mail.png"
                                    ToolTip="Send Bill Report" />                               
                                <a href='<%# Eval("filepath") %>' target="_blank">
                                    <img src="../Content/images/vwnm.png" title="Show Report" alt="n" />
                                </a>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField> 
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                        <FooterStyle CssClass="tr_haed" />
                    </asp:GridView>
                </div>
            </asp:Panel>
            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtendernoofcode" runat="server"
                TargetControlID="txtNoofCode" ValidChars="1234567890." FilterMode="ValidChars">
            </cc1:FilteredTextBoxExtender>
            <asp:Panel ID="PanelNewDesign" runat="server" Width="45%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewDesign" CssClass="popupClose" runat="server" /></div>
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>Payment</strong> </span><span class="right"><span class="astrics">
                                    <strong>*</strong></span> <em>indicates mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="DivNewMsg" runat="server">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div style="text-align: center; width: 100%; display: none;">
                                    <span><strong>Total Pending Amount : </strong></span>
                                    <asp:Label ID="lblTotalAmt" runat="server" ForeColor="Green"></asp:Label>
                                    (in Rs.)</div>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Payment Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr id="RowComp" runat="server">
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorComp3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="ddlCompId" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Company Name :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCompId" runat="server" CssClass="drp" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlCompId_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="DDLProductPayments" InitialValue="--Select Product--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Product Name :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDLProductPayments" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLProductPayments_SelectedIndexChanged"
                                                    CssClass="drp" />
                                            </td>
                                        </tr>
                                        <tr id="RowTAmt" runat="server">
                                            <td align="right" width="35%">
                                                <strong>Total Due Amount :</strong>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp; <span style="font-size: 10pt;">[</span><asp:Label ID="lblAvlCodeDemo"
                                                    runat="server" ForeColor="Red" Font-Size="10pt" Style="padding-left: 12px;" CssClass="txt_rupees rupees"></asp:Label><span
                                                        style="font-size: 10pt;">]</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="ddlComp_Id" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Bank Name :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlComp_Id" runat="server" CssClass="drp" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlComp_Id_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="RowDet" runat="server">
                                            <td colspan="2">
                                                <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                    <tr>
                                                        <td style="width: 35%" align="right">
                                                            <strong>Account No :</strong>
                                                        </td>
                                                        <td style="width: 65%">
                                                            <asp:Label CssClass="boldcls" ID="lblAccNo" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <strong>Account Holder Name :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:Label CssClass="boldcls" ID="lblAccHolderNm" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <strong>IFSC Code :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:Label CssClass="boldcls" ID="lblIfsccode" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="ddlPaymentMode" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Pay Mode :</strong>
                                            </td>
                                            <td align="left" width="65%">
                                                <asp:DropDownList ID="ddlPaymentMode" Width="180px" runat="server" CssClass="drp"
                                                    AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMode_SelectedIndexChanged">
                                                    <asp:ListItem>--Select--</asp:ListItem>
                                                    <asp:ListItem>Cheque</asp:ListItem>
                                                    <asp:ListItem>DD</asp:ListItem>
                                                    <asp:ListItem>Cash</asp:ListItem>
                                                    <asp:ListItem>NEFT</asp:ListItem>
                                                    <asp:ListItem>RTGS</asp:ListItem>
                                                </asp:DropDownList>
                                                <span id="trmode" runat="server">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ErrorMessage="*" InitialValue="--Mode of Payment--" ValidationGroup="PR" ControlToValidate="ddlmodeofpayment">
                                                    </asp:RequiredFieldValidator>
                                                    <asp:DropDownList ID="ddlmodeofpayment" Width="180px" runat="server" CssClass="drp">
                                                        <asp:ListItem>--Mode of Payment--</asp:ListItem>
                                                        <asp:ListItem>Courier</asp:ListItem>
                                                        <asp:ListItem>Deposit In Bank</asp:ListItem>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr id="Fieldset3Child" runat="server">
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="ReqValtxtAmount" runat="server" ForeColor="Red" ValidationGroup="PR"
                                                    ControlToValidate="txtNoofCode">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Amount :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtNoofCode" runat="server" CssClass="textbox_pop" Text="" MaxLength="7"
                                                    OnKeyPress="return isNumberKey(this, event);" onchange="mathRoundForTaxes(this.id);"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset id="Fieldset3" runat="server" class="Newfield Newfield_width2">
                                    <legend>Other Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" width="35%" valign="top">
                                                <asp:RequiredFieldValidator ID="ReqValtxtDetails" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtDetails">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Details/Transaction No./Instrument No. :</strong>
                                            </td>
                                            <td style="padding-bottom: 3px;">
                                                <asp:TextBox ID="txtDetails" runat="server" CssClass="textarea_pop" Text="" TextMode="MultiLine"
                                                    Height="35px" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top">
                                                <b>Remarks :</b>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" CssClass="textarea_pop"
                                                    Height="35px" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnPrintDemo" OnClick="btnPrintDemo_Click" ValidationGroup="PR" CssClass="button_all"
                                                runat="server" Text="Save" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewDesign"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewDesign">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
