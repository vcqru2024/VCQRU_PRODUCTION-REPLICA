<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Tax Setting" CodeFile="FrmSettingTaxMaster.aspx.cs" Inherits="FrmSettingTaxMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(22).addClass("active");
            $(".accordion2 div.open").eq(22).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="pro_price_code">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Tax Setting
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" ToolTip="Create New Label" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server" style="width: 91%;">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="ImgSearch">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                            <tr>
                                <td align="right" width="15%">
                                    <strong>Company Name :</strong>
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txtsearchlblname" runat="server" CssClass="textbox_pop" placeholder="Company Name"></asp:TextBox>
                                </td>
                                <td align="justify">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            OnClick="ImgSearch_Click" ToolTip="Search" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                                    </div>
                                </td>
                                <td align="right" width="13%" style="visibility: hidden;">
                                    <strong>Product Name :</strong>
                                </td>
                                <td width="20%" style="visibility: hidden;">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>
            </asp:Panel>
            <div class="grid_container">
                <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right" style="padding-right: 20px;">
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GrdVwTaxMaster" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdVwTaxMaster_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdVwTaxMaster_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText=" Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" Width="15%" />
                        </asp:TemplateField>                                            
                        <asp:TemplateField HeaderText="Label S.Tax">
                            <ItemTemplate>
                                <asp:Label ID="lblLservicetax" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server" Text='<%# Bind("Label_ServiceTax") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Label Vat">
                            <ItemTemplate>
                                <asp:Label ID="lblLvattax" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server" Text='<%# Bind("Label_Vat") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AMC S.Tax">
                            <ItemTemplate>
                                <asp:Label ID="lblAmcservicetax" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server" Text='<%# Bind("AMC_ServiceTax") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AMC Vat">
                            <ItemTemplate>
                                <asp:Label ID="lblamcvat" runat="server" Text='<%# Bind("AMC_Vat") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Offer S.Tax">
                            <ItemTemplate>
                                <asp:Label ID="lblOfferservicetax" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server" Text='<%# Bind("Offer_ServiceTax") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Offer Vat">
                            <ItemTemplate>
                                <asp:Label ID="lbloffervatprise" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server" Text='<%# Bind("Offer_Vat") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("TaxSet_ID") %>'
                                    CausesValidation="false" CommandName="EditTax" ToolTip="Edit Tax Setting" />&nbsp;                                
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:Label ID="lblproid" runat="server" Text="" Visible="false"></asp:Label>
                <!-- ******************* Popup Tax Setting Master Start *********************-->
                <asp:Panel ID="PnlTaxMasterSetting" runat="server" Width="32%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnClosePop" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left"><strong>
                                        <asp:Label ID="lblheading" runat="server"></asp:Label></strong> </span><span class="right">
                                            <span class="astrics"><strong>*</strong></span> <em>indicates mandatory fields</em></span></p>
                            </div>
                            <asp:Panel ID="PnlTaxMasterSetting_" runat="server">
                                <div class="regis_popup">
                                    <div id="Div3" runat="server">
                                        <p>
                                            <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                    </div>
                                    <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                        <legend>(<asp:Label ID="lblpronametax" runat="server" ForeColor="Blue"></asp:Label>)Tax
                                            Setting Info</legend>
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr id="MytrNew" runat="server">
                                                <td colspan="3" align="center">
                                                    <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                        ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"  InitialValue="--Select--"
                                                        ValidationGroup="TMS" ControlToValidate="ddlCompID"></asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Company Name :&nbsp;</strong>
                                                </td>
                                                <td colspan="2">
                                                    <asp:DropDownList ID="ddlCompID" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCompID_SelectedIndexChanged" Width="90%"></asp:DropDownList>                                                    
                                                </td>
                                            </tr>
                                             <tr>
                                                <td align="right" style="width: 36%;">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" InitialValue="--Select--"
                                                        ValidationGroup="TMS" ControlToValidate="ddlProID"></asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Product Name :&nbsp;</strong>
                                                </td>
                                                <td colspan="2">
                                                    <asp:DropDownList ID="ddlProID" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProID_SelectedIndexChanged"  Width="90%"></asp:DropDownList>                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Category Name :&nbsp;</strong>
                                                </td>
                                                <td colspan="2">
                                                    <asp:Label ID="lblcompcat" CssClass="textbox_pop" Enabled="false" runat="server" />
                                                    
                                                </td>                                                
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Address :&nbsp;</strong>
                                                </td>
                                                <td colspan="2" >
                                                   <asp:Label ID="lblAddress" CssClass="textbox_pop" Enabled="false" runat="server" />                                                    
                                                </td>                                                
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                </td>
                                                <td>
                                                    <strong>Service Tax &nbsp;</strong>
                                                </td>
                                                <td>
                                                    <strong>VAT &nbsp;</strong>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtLabelServiceTax"></asp:RequiredFieldValidator>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtLabelVAT"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Label :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLabelServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLabelVAT" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtAmcServiceTax"></asp:RequiredFieldValidator>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtAMCServiceTax"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>AMC :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAmcServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAMCVATx" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtOfferServiceTax"></asp:RequiredFieldValidator>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                        ValidationGroup="TMS" ControlToValidate="txtOfferServiceTax"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Offer :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOfferServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtOfferVAT" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                        onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" colspan="2" style="padding-right: 5px;">
                                                <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                <asp:Button ID="btnTaxSetting" OnClick="btnTaxSetting_Click" ValidationGroup="TMS"
                                                    CssClass="button_all" UseSubmitBehavior="false" runat="server" Text="Save" />
                                                <asp:Button ID="btnResetTax" OnClick="btnResetTax_Click" CssClass="button_all" runat="server"
                                                    Text="Reset" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalTaxMaster" runat="server" PopupControlID="PnlTaxMasterSetting"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelTaxSetting" CancelControlID="btnClosePop">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelTaxSetting" runat="server"></asp:Label>
                <!-- ******************* Popup Tax Setting Master End *********************-->
                
                
                <!--===============================PopUp Password Starts===============================-->
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblPassPnlHead" runat="server" Text="Password" Font-Size="10pt"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                <asp:Label ID="lblPopMsgText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                <br />
                                <div id="infobtn" style="display:none;" runat="server">
                                    <asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" Visible="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label5" runat="server"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                    CancelControlID="btnPasswordPnlClose" PopupControlID="PanelShowPassword" TargetControlID="Label3">
                </cc1:ModalPopupExtender>
            </div>
        </ContentTemplate>
        <Triggers>
            
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
