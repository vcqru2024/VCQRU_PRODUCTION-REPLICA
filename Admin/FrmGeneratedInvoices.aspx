<%@ Page Title="Label Bills" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmGeneratedInvoices.aspx.cs" Inherits="FrmGeneratedInvoices" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(32).addClass("active");
            $(".accordion2 div.open").eq(23).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script language="javascript" type="text/javascript">
        function postbackFromJS(sender, e) {
            var postBack = new Sys.WebForms.PostBackAction();
            postBack.set_target(sender);
            postBack.set_eventArgument(e);
            postBack.performAction();
        }
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

    <script type="text/javascript" language="javascript">

        function openpopup12(x) {
            var winpops = window.open(x, "_blank", "status=no,toolbar=no,location=no,menu=no,width=750,height=250,scrollbars=yes,screenX=0,screenY=0")
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        top: 0px; z-index: 999;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="gend_bills">
                    <table width="99%">
                        <tr>
                            <td >
                                Generated Invoice
                            </td>
                            <td width="60%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td>
                           <a style="cursor: pointer" onclick="openpopup12('RptLedger.aspx')"
                                        target="_blank">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/images/report.png" ToolTip="Click for Ledger or Transaction Report" /></a>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ImageUrl="~/Content/images/add_new.png" runat="server" ToolTip="Generate Bill"
                                    Visible="false" /><asp:ImageButton ID="ImgGrdVwRefresh" OnClick="ImgGrdVwRefresh_Click" ImageUrl="~/Content/images/vw_refresh.png"
                                    runat="server" ToolTip="Refresh" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
              <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label><asp:HiddenField ID="hdCompanyNm"   runat="server" />
                </p>
            </div>
            <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td width="21%">
                                <asp:DropDownList ID="ddlcompname" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlcompname_SelectedIndexChanged" />
                                <%--<cc1:CascadingDropDown ID="ccdcompname" Category="Comp_Reg" PromptText="--Company--"
                                    LoadingText="Loading..." TargetControlID="ddlcompname" ServiceMethod="BindCompany"
                                    ServicePath="~/WebService.asmx" runat="server">
                                </cc1:CascadingDropDown>--%>
                            </td>
                            <td width="21%">
                                <asp:DropDownList ID="ddlproname" runat="server" CssClass="reg_txt" />
                                <%-- <cc1:CascadingDropDown ID="ccdproname" Category="Pro_Reg" PromptText="--Product--"
                                    LoadingText="Loading..." TargetControlID="ddlproname" ParentControlID="ddlcompname"
                                    ServiceMethod="BindProduct" ServicePath="~/WebService.asmx" runat="server">
                                </cc1:CascadingDropDown>--%>
                            </td>
                            <td width="15%">
                                <asp:TextBox ID="txtinvoice" runat="server" CssClass="reg_txt" MaxLength="10"></asp:TextBox>
                            </td>
                            <td width="15%">
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td width="15%">
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="justify">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        CausesValidation="false" OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        CausesValidation="false" ToolTip="Refresh" />
                                </div>
                            </td>
                            <td width="1%" style="display: none;">
                                <asp:TextBox ID="txtCompanyName" runat="server" Text="" CssClass="reg_txt" MaxLength="30"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" TargetControlID="txtCompanyName"
                                    runat="server" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="1000" ServiceMethod="GetCountries" CompletionListCssClass="AutoExtender"
                                    CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                </cc1:AutoCompleteExtender>
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
                                    TargetControlID="txtDateFrom" WatermarkText="Date From">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                    WatermarkText="Date To">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtCompanyName"
                                    WatermarkText="Company Name">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8522" runat="server" TargetControlID="txtinvoice"
                                    WatermarkText="Invoice No.">
                                </cc1:TextBoxWatermarkExtender>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>
            <div class="grid_container">
                <h4 class="visit_head">
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <input type="hidden" runat="server" id="hidden1" />
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                <asp:Label ID="lblGridHeaderTextLicence" runat="server" Text="Record(s) found"></asp:Label>
                                <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right">
                                <span class="small_font">
                                    <asp:Label ID="lbltotalLicence" runat="server"></asp:Label></span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowsShow" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GrdCodeAllote" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    ShowFooter="true" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" OnRowCommand="GrdCodeAllote_RowCommand" Width="100%"
                    BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                    PageSize="15" OnPageIndexChanging="GrdCodeAllote_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceDate" runat="server" Text='<%# Bind("Invoice_Date","{0:MMM dd, yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="11%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Invoice_No">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceID" runat="server" Text='<%# Bind("Invoice_ID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Head" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceHeadName" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceCompNm" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="profooterpladueAmt" runat="server" Text="Total"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="G_Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceG_Amt" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("G_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P1" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Tax">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceSTax" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Service_Tax") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P2" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VAT">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceVat" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("VAT") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P22" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="N_Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceN_Amt" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("N_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P3" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Adjustment" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceBalance" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Balance") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P4" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Visible="false"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pay Amt." Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoicePay_Amt" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Net_Pay") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P5" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Visible="false"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate> <%--'<%#Bind("Invoice_ID") %>' --%>
                                <asp:ImageButton ID="ImgSendMail" runat="server" CausesValidation="false" CommandArgument='<%# Eval("Invoice_ID") + "*" + string.Format("{0:dd-MM-yyyy}", Eval("Invoice_Date")) + "*" +  Eval("Comp_Email") %>'
                                    CommandName="SendMail" Width="12px" Height="13px" ImageUrl="../Content/images/mail.png"
                                    ToolTip="Send Bill Report" />
                                <%-- <asp:ImageButton ID="ImageButtonview1" runat="server" Style="padding-top: 5px;" CausesValidation="false"
                       Height="13px" Width="13px" CommandArgument='<%#Bind("Invoice_No") %>' CommandName="Viewbill"
                       ImageUrl="~/Content/images/vwnm.png" ToolTip="View Bill Report" />--%>
                               <%-- <a href='<%# Eval("filepth") %>' target="_blank">
                                    <img src="../Content/images/vwnm.png" title="Show Report" alt="n" />
                                </a>--%>
                                 <a href='<%# ProjectSession.absoluteSiteBrowseUrl+"/Admin/Bill/Invoice/"+ string.Format("{0:dd-MM-yyyy}", Eval("Invoice_Date")) + "/" + Eval("Invoice_ID") + ".pdf" %>' target="_blank">
                                    <img src="../Content/images/vwnm.png" title="Show Report" alt="n" />
                                </a>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                    <FooterStyle CssClass="tr_haed" />
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
