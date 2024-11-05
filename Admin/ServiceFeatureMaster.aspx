<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Service Feature Master" CodeFile="ServiceFeatureMaster.aspx.cs" Inherits="ServiceFeatureMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(13).addClass("active");
            $(".accordion2 div.open").eq(11).show();

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
                                Service Feature Master
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" ToolTip="Add New Service Feature" />
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
                                    <strong>Service Name :</strong>
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txtsearchlblname" runat="server" CssClass="textbox_pop" placeholder="Service Name"></asp:TextBox>
                                </td>
                                <td align="justify">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            OnClick="ImgSearch_Click" ToolTip="Search" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png"
                                            OnClick="ImgRefresh_Click" ToolTip="Reset" />
                                    </div>
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
                <asp:GridView ID="GrdServiceFeatureMaster" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdServiceFeatureMaster_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdServiceFeatureMaster_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="3%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Points">
                            <ItemTemplate>
                                <asp:Label ID="lblispoints" runat="server" Text='<%# Convert.ToInt32(Eval("IsPoints")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cash">
                            <ItemTemplate>
                                <asp:Label ID="lbliscash" runat="server" Text='<%# Convert.ToInt32(Eval("IsCash")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lbldaterange" runat="server" Text='<%# Convert.ToInt32(Eval("IsDateRange")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sound/Comments">
                            <ItemTemplate>
                                <asp:Label ID="lblisSound" runat="server" Text='<%# Convert.ToInt32(Eval("IsSound")) == 0 ? "Yes" : "No"  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Frequency">
                            <ItemTemplate>
                                <asp:Label ID="lblFequency" runat="server" Text='<%# Convert.ToInt32(Eval("IsFrequency")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gift">
                            <ItemTemplate>
                                <asp:Label ID="lblAddGift" runat="server" Text='<%# Convert.ToInt32(Eval("IsAdditionalGift")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Coupons">
                            <ItemTemplate>
                                <asp:Label ID="lblCoupons" runat="server" Text='<%# Convert.ToInt32(Eval("IsCoupons")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Message">
                            <ItemTemplate>
                                <asp:Label ID="lblIsMsg" runat="server" Text='<%# Convert.ToInt32(Eval("IsMessageTemplete")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Notify">
                            <ItemTemplate>
                                <asp:Label ID="lblIsNotify" runat="server" Text='<%# Convert.ToInt32(Eval("IsNotify")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="No_Msg">
                            <ItemTemplate>
                                <asp:Label ID="lblIsNoMsg" runat="server" Text='<%# Convert.ToInt32(Eval("IsNoMessage")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>  
                        <asp:TemplateField HeaderText="Referral">
                            <ItemTemplate>
                                <asp:Label ID="lblIsReferral" runat="server" Text='<%# Convert.ToInt32(Eval("IsReferral")) == 0 ? "Yes" : "No" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                                        
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png"
                                    CommandArgument='<%# Bind("ServiceFeaure_ID") %>' CausesValidation="false" CommandName="EditServiceFeaure"
                                    ToolTip="Edit Service Details" />&nbsp;                                
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Content/images/delete.png"
                                    ToolTip="Delete Service Details" CausesValidation="false" CommandArgument='<%# Bind("ServiceFeaure_ID") %>'
                                    CommandName="DeleteServiceFeature" />&nbsp;                                
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
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
                                        <legend>Service Info</legend>
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
                                                        ValidationGroup="LCR" ControlToValidate="ddlService" InitialValue="--Select--"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Service Name :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlService" runat="server" onchange="javascript:checkExist();">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLabelChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                                                </td>
                                            </tr>                                            
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Points :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkispoints" runat="server" ToolTip="Check for give points"
                                                        Text="  Can be Points" />
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Cash :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkcashamt" runat="server" ToolTip="Check for give Cash in Rs."
                                                        Text="  Can be Cash in Rs." />
                                                </td>
                                            </tr>                                              
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Date Range :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkdtrange" runat="server" ToolTip="Check for give date range (Date From & Date To)"
                                                        Text="  Can be Date Range" />
                                                </td>
                                            </tr>                                                
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Sound File / Comments :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chksfileorcomm" runat="server" ToolTip="Check for give sound file and comments"
                                                        Text="  Can be Sound File & Comments" />
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Frequency :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkfrequency" runat="server" ToolTip="Check for give Set Fequency"
                                                        Text="  Can be Frequency" />
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Additional Gift :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkisgift" runat="server" ToolTip="Check for give Additional Gift"
                                                        Text="  Can be Additional Gift" />
                                                </td>
                                            </tr>   
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Coupons :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkCoupons" runat="server" ToolTip="Check for give Additional Gift"
                                                        Text="  Can be Coupons" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Message :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkmsg" runat="server" ToolTip="Check for give Message Templete"
                                                        Text="  Can be Message Templete" />
                                                </td>
                                            </tr> 
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Notify :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chknotify" runat="server" ToolTip="Check for give Additional Gift"
                                                        Text="  Can be Sent Notify Message" />
                                                </td>
                                            </tr>   
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is No Message :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chknomessage" runat="server" ToolTip="Check for give Message Templete"
                                                        Text="  Can be Sent No Message" />
                                                </td>
                                            </tr>   
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Referral :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkReferral" runat="server" ToolTip="Check for give Message Templete"
                                                        Text=" Can be Referral" />
                                                </td>
                                            </tr> 
                                              <tr>
                                                <td align="right" style="width: 36%;">
                                                    <strong>Is Warranty :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkWarranty" runat="server" ToolTip="Check for give Message Templete"
                                                        Text="  Can be Warranty" />
                                                </td>
                                            </tr>                                           
                                        </table>
                                    </fieldset>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
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
                                <asp:HiddenField ID="hdntype" runat="server" />
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
    </asp:UpdatePanel>
</asp:Content>
