<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Coupon Request Master" CodeFile="FrmCouponRequest.aspx.cs" Inherits="FrmCouponRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(21).addClass("active");
            $(".accordion2 div.open").eq(18).show();

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
    </style>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1583px; width: 100%; z-index: 100000;
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
                <h2 class="add_Courior">
                    <table width="99%">
                        <tr>
                            <td width="40%">
                                &nbsp;Coupon Request Master
                            </td>
                            <td width="45%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Coupon Request" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="btnSearch">
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 9%;">
                                <asp:DropDownList ID="ddlCompany" runat="server" CssClass="reg_txt" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" ></asp:DropDownList>
                            </td>
                            <td align="justify" style="width: 9%;">
                                <asp:TextBox ID="txtSearchName" runat="server" CssClass="reg_txt" placeholder="Coupon Name"></asp:TextBox>
                            </td>
                            <td align="left" width="12%">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="btnSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="btnRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="btnRefesh_Click" ToolTip="Refresh" />
                                </div>
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
                                <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
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
                    <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="grid"
                        DataKeyNames="IsActive,IsAdminVerify" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdVw_PageIndexChanging"
                        OnRowCommand="GrdVw_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <%=sno++%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Coupon Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("CouponName") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qunatity">
                                <ItemTemplate>
                                    <asp:Label ID="lblcouqty" runat="server" Text='<%# Bind("CouponCount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DateFrom">
                                <ItemTemplate>
                                    <asp:Label ID="lbldtdtfrm" runat="server" Text='<%# Bind("DateFrom","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DateTo">
                                <ItemTemplate>
                                    <asp:Label ID="lbldttto" runat="server" Text='<%# Bind("DateTo","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>                                    
                                    <asp:Label ID="lblreqstatn" runat="server" Text='<%# Convert.ToInt32(Eval("IsAdminVerify")) == 0 ? "Pending" : Convert.ToInt32(Eval("IsAdminVerify")) == 1 ? "Verified" : "Canceled" %>' Font-Size="9pt"></asp:Label>                                  
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>                                   
                                    <%try
                                      {
                                          IsAdminVerify = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsAdminVerify"]);
                                          Flag = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsActive"]);
                                      }
                                      catch { }
                                    if (IsAdminVerify == 1)
                                           {%>
                                           <img alt="" src="../Content/images/check_act.png" title="Already verified" />                                    
                                    <%}
                                                 else
                                                 { %>
                                    <asp:ImageButton ID="ImgbtnActN" runat="server" ImageUrl="~/Content/images/check_gr.png"
                                        CommandName="VerifyRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="Click For Verify Request"
                                        CausesValidation="false" />
                                    <%} if (IsAdminVerify == 0)
                                    {%>
                                    <asp:ImageButton ID="ImgbtnDel" runat="server" ImageUrl="~/Content/images/delete.png"
                                        CommandName="CancelledRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="Cancel Coupon Request"
                                        CausesValidation="false" />
                                        <%} %>
                                    <%index++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:HiddenField ID="dhnactiontype" runat="server" />
                    <asp:HiddenField ID="dhncompid" runat="server" />
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="35%" Style="display: none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewCourier" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblAddCourierHeader" runat="server" Text=""></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="DivNewMsg" runat="server" style="width: 88%;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <asp:UpdateProgress ID="UpdateProgressForPay2New" AssociatedUpdatePanelID="UpdatePanel1"
                                    runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="position: absolute; left: -330px; height: 907px; width: 1024px; top: -170px;
                                            text-align: center;" class="NewmodalBackground">
                                            <div style="margin-top: 300px;" align="center">
                                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                                <span style="color: White;">Please Wait.....<br />
                                                </span>
                                            </div>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Courier Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="ddlCoupon" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Coupon Name :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCoupon" runat="server" CssClass="drp">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtQty">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Coupon Qunatity :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQty" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"
                                                    onchange="checkCourior(this.value)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtdtfrom">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>DateFrom :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdtfrom" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"></asp:TextBox>
                                                <b>To</b>
                                                <asp:TextBox ID="txtdtto" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="LOY"
                                                    ControlToCompare="txtdtfrom" ControlToValidate="txtdtto" ForeColor="Red" Type="Date"
                                                    Operator="GreaterThan" Text="Date To is Less Than Date From"></asp:CompareValidator>
                                                <cc1:CalendarExtender ID="CalendarExtender7" runat="server" TargetControlID="txtdtfrom"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtdtfrom"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server" TargetControlID="txtdtfrom"
                                                    WatermarkText="Date From..">
                                                </cc1:TextBoxWatermarkExtender>
                                                <cc1:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtdtto"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtdtto"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server" TargetControlID="txtdtto"
                                                    WatermarkText="Date To..">
                                                </cc1:TextBoxWatermarkExtender>
                                            </td>
                                        </tr>                                        
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" ValidationGroup="PR1" CssClass="button_all"
                                                runat="server" Text="Save" />&nbsp;&nbsp;<asp:Button ID="btnReset" OnClick="btnReset_Click"
                                                    CausesValidation="false" CssClass="button_all" runat="server" Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewCourier"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewCourier">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
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
                            <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                            <br />
                            <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYes_Click" />&nbsp;&nbsp;<asp:Button
                                ID="btnNo" runat="server" Text="No" CssClass="button_all" OnClick="btnNo_Click" />
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
