<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Service Price Master" CodeFile="ServicePriceMaster.aspx.cs" Inherits="ServicePriceMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(14).addClass("active");
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
                        top: 0px; z-index: 100001;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="amc_plan_master">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Service Price Master
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" ToolTip="Add New Service Price" />
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
            <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="right" width="15%">
                                <strong>Service Name :</strong>
                            </td>
                            <td width="25%">
                                <asp:DropDownList ID="ddlsearchservice" runat="server">
                                </asp:DropDownList>
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
                <asp:GridView ID="GrdServicePrice" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    DataKeyNames="IsActive" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdServicePrice_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdServicePrice_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Plan ID">
                            <ItemTemplate>
                                <asp:Label ID="lblplnidforuse" runat="server" Text='<%# Bind("Plan_ID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Plan Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Plan Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvtitle" runat="server" Text='<%# Bind("PlanName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Time (In months)">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvtime" runat="server" Text='<%# Bind("PlanPeriod") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    runat="server" Text='<%# Bind("PlanPrice") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Entry Date">
                            <ItemTemplate>
                                <asp:Label ID="lblentrydateser" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="16%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png"
                                    CommandArgument='<%# Bind("Plan_ID") %>' CommandName="EditServicePrice" ToolTip="Edit Plan" />&nbsp;
                                <%
                                    try
                                    {
                                        lflag = Convert.ToInt32(GrdServicePrice.DataKeys[index].Values["IsActive"].ToString());
                                    }
                                    catch { }
                                    if (lflag == 1)
                                    {  %>
                                <asp:ImageButton ID="imgshowlbl123" runat="server" ImageUrl="~/Content/images/check_gr.png"
                                    ToolTip='<%# Bind("TooTipMsg") %>' CommandArgument='<%# Bind("Plan_ID") %>' CommandName="ShowHideServicePrice"
                                    Height="11px" Width="11px" />&nbsp;
                                <%}
                                    else
                                    {%>
                                <asp:ImageButton ID="imgshowlbl" runat="server" ImageUrl="~/Content/images/check_act.png"
                                    ToolTip='<%# Bind("TooTipMsg") %>' CommandArgument='<%# Bind("Plan_ID") %>' CommandName="ShowHideServicePrice"
                                    Height="11px" Width="11px" />&nbsp;
                                <%} %>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Content/images/delete.png"
                                    ToolTip="Delete Price Details" CommandArgument='<%# Bind("Plan_ID") %>' CommandName="DeletePriceTrans" />&nbsp;
                                <asp:ImageButton ID="Imggrddelete" runat="server" ImageUrl="~/Content/images/lence.png"
                                    ToolTip="View Update Price Details" CommandArgument='<%# Bind("Plan_ID") %>'
                                    CommandName="ViewSRVPriceDetails" />&nbsp;
                                <%index++; %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:HiddenField ID="hdntransid" runat="server" />
                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
                <!-- ******************* Popup Start *********************-->
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <%-- <img style="position:absolute; z-index:auto; top:100px; left:50px;" />--%>
                        <asp:UpdateProgress ID="UpdateProgress2" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                                    top: 0px;" class="">
                                    <%--NewmodalBackground--%>
                                    <div style="margin-top: 300px;" align="center">
                                        <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                        <span style="color: White;">Please Wait.....<br />
                                        </span>
                                    </div>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:Panel ID="PanelLabelCreate" runat="server" Width="32%">
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
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                                ValidationGroup="LCR" ControlToValidate="txtplanname"></asp:RequiredFieldValidator>
                                                            <strong><span class="star_red">*</span>Service Title :&nbsp;</strong>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtplanname" CssClass="textbox_pop" onchange="checkplan(this.value);"
                                                                runat="server"></asp:TextBox>
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
                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                                ValidationGroup="LCR" ControlToValidate="txtlabelname"></asp:RequiredFieldValidator>--%>
                                                            <strong><span class="star_red">*</span>Service Time :&nbsp;</strong>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlyear" CssClass="textbox_pop" runat="server" Width="75px" />
                                                            &nbsp;
                                                            <asp:DropDownList ID="ddlmonths" CssClass="textbox_pop" runat="server" Width="75px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 36%;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                                ValidationGroup="LCR" ControlToValidate="txtlabelprise"></asp:RequiredFieldValidator>
                                                            <strong><span class="star_red">*</span>Service Amount :&nbsp;</strong>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtlabelprise" runat="server" Width="120px" MaxLength="10" Style="padding-left: 10px;
                                                                border: solid 1px #e6e6e6; height: 11px;" CssClass="txt_rupees rupees" OnKeyPress="return isNumberKey(this, event);"
                                                                onchange="mathRoundForTaxes(this.id);"></asp:TextBox>
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
                                                            runat="server" Text="Save" />
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
                    </ContentTemplate>
                </asp:UpdatePanel>
                <cc1:ModalPopupExtender ID="ModalPopupCreateLabel" runat="server" PopupControlID="PanelLabelCreate"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelCreate" CancelControlID="btnClosePop">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelCreate" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelPrise" runat="server" Width="32%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="PanelLabelPriseDetails" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left"><strong><b>
                                        <asp:Label ID="Label4" runat="server" Text="" Font-Size="12px"></asp:Label></b>&nbsp;&nbsp;<asp:Label
                                            ID="Label1" runat="server" Text="Label Price Details" Visible="false"></asp:Label>&nbsp;&nbsp;&nbsp;</strong>
                                    </span>
                                </p>
                            </div>
                            <asp:Panel ID="Panel2" runat="server">
                                <div class="regis_popup" style="overflow: auto; height: 350px;">
                                    <asp:GridView ID="GrdViewServiceDetails" runat="server" AutoGenerateColumns="False"
                                        CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                        BorderColor="transparent">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Change Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblentrydatedet" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="35%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Plan Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprisedet12" runat="server" Text='<%# Bind("PlanName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="35%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprisedet12" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                        runat="server" Text='<%# Bind("PlanPrice") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="30%" />
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
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblPassPnlHead" runat="server" Text="Password" Font-Size="14pt"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                <asp:Label ID="lblPopMsgText" runat="server" Text="" Font-Size="12px"></asp:Label><br />
                                <br />
                                <div id="infobtn" runat="server">
                                    <asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label5" runat="server"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                    OkControlID="btnNoActivation" CancelControlID="btnPasswordPnlClose" PopupControlID="PanelShowPassword"
                    TargetControlID="Label3">
                </cc1:ModalPopupExtender>
            </div>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
