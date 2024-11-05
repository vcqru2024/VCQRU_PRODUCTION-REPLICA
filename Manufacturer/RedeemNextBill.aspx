<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="RedeemNextBill.aspx.cs" Inherits="Manufacturer_RedeemNextBill" %>

<%@ Register Src="~/UserControl/RedeemHistoryBill.ascx" TagPrefix="uc1" TagName="RedeemHistoryBill" %>





<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <%-- <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(3).addClass("active");
            $(".accordion2 div.open").eq(3).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:RedeemHistoryBill runat="server" ID="RedeemHistoryBill" />
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                <h2 class="brand_transaction">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Cash Details
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" ToolTip="Create New Label" Visible="false" />
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
                               
                                <td align="center" width="20%">
                                 <asp:DropDownList ID="ddlCompany" runat="server" CssClass="textbox_pop" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Visible="true">
                                    </asp:DropDownList>
                                </td>
                                <td width="20%">
                                       <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                        CssClass="textbox_pop">
                                    </asp:DropDownList>
                                   
                                </td>
                                
                              
                                <td align="justify" style="width: 23%;">
                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td align="justify" style="width: 23%;">
                                    <asp:TextBox ID="txtDateto" runat="server" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="20%">
                                   <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                                </td>                             
                            </tr>
                            <tr>
                              
                                <td align="right" width="10%">
                                </td>
                                <td width="15%">
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
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>
            </asp:Panel>
            <fieldset class="field_profile" style="display:none;">
                <legend style="background: url(../images/doc.png) no-repeat 3px center;">Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td width="40%" align="left">
                             <span class="WebRupee" style="font-size: 12px; font-weight: bold;"> </span></td>
                        <td width="23%">
                           
                        </td>
                      
                    </tr>
                    <tr>
                        <td><asp:Label Text="" runat="server"  ID="lblAvailablePoints" style="font-size: 13px; font-weight: bold;" /></td> <td>
                            <asp:Button Text="Give bank details to transfer cash" ID="btnRedem" CssClass="button_all"  runat="server" OnClick="btnRedem_Click"  /></td>
                    </tr>
                </table>
            </fieldset>
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
                                <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    DataKeyNames="IsCashConvert" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdLabel_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdLabel_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblentrydate" runat="server" Text='<%# Bind("Updt") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Earned Cash">
                            <ItemTemplate>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Bind("Cash") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblsize2" runat="server" Text='<%# Bind("EarnedStatus") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Consumer">
                            <ItemTemplate>
                                <asp:Label ID="lblsize3" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label><br />
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                           <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton Text="Transfer Cash" runat="server"   CommandName="TransferCash" CommandArgument='<%# Eval("M_Consumerid") %>'  />
                              
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                     
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelCreate" runat="server" Width="32%" Style="display: none;">
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
                            <asp:Panel ID="PnlCreateLavel" runat="server">
                                <div class="regis_popup">
                                    <div id="Div1" runat="server">
                                        <p>
                                            <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                    </div>
                                    <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                        <legend>Check Code Info</legend>
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr id="MytrNew" runat="server">
                                                <td colspan="2" align="center">
                                                    <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                        ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtMobileNo"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Mobile No. :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMobileNo" CssClass="textbox_pop" runat="server" Width="150px"
                                                        MaxLength="10" OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(10
                                                    digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtCode1"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Code1 :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCode1" CssClass="textbox_pop" runat="server" Width="150px" MaxLength="5"
                                                        OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(5 digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtCode2"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Code2 :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCode2" CssClass="textbox_pop" runat="server" Width="150px" MaxLength="8"
                                                        OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(8 digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2" style="padding-right: 5px;">
                                                    <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                    <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="LCR" CssClass="button_all"
                                                        UseSubmitBehavior="false" runat="server" Text="Save" />
                                                    <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                                        Text="Reset" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupCreateLabel" runat="server" PopupControlID="PanelLabelCreate"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelCreate" CancelControlID="btnClosePop">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelCreate" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelPrise" runat="server" Width="32%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="PanelLabelPriseDetails" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left"><strong><b>
                                        <asp:Label ID="Label4" runat="server" Text="" ForeColor="Green" Font-Size="12pt"></asp:Label></b>&nbsp;&nbsp;<asp:Label
                                            ID="Label1" runat="server" Text="Label Price Details"></asp:Label>&nbsp;&nbsp;&nbsp;</strong>
                                    </span>
                                </p>
                            </div>
                            <asp:Panel ID="Panel2" runat="server">
                                <div class="regis_popup" style="overflow: auto; hieght: 350px;">
                                    <asp:GridView ID="GrdViewLabelDetails" runat="server" AutoGenerateColumns="False"
                                        CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                        BorderColor="transparent">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Price Change Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblentrydatedet" runat="server" Text='<%# Bind("Entry_Date") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Price (In Rs.)">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprisedet12" runat="server" Text='<%# Bind("Label_Prise") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                        <RowStyle CssClass="tr_line1" />
                                        <AlternatingRowStyle CssClass="tr_line2" />
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupLabelPriseDetails" runat="server" PopupControlID="PanelLabelPrise"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelPriseDet" CancelControlID="PanelLabelPriseDetails">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelPriseDet" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!--===============================PopUp Password Starts===============================-->
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%" Style="display: none;">
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
                                <div id="infobtn" runat="server">
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
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>

