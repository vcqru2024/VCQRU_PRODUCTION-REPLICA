<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" Title="Courier Master"
    CodeFile="FrmCourierMaster.aspx.cs" Inherits="FrmCourierMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(36).addClass("active");
            $(".accordion2 div.open").eq(34).show();

            $(".accordion2 p").click(function () {
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

    <script language="javascript" type="text/javascript">
         function checkCourior(vl) {
             PageMethods.checkNewLabel(vl, onCompleteLaebl)
         }
         function onCompleteLaebl(Result) {
             if (Result == true) {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "Courior Name Already exist.";
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = true;
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all_Sec";
             }
             else {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "";
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = false;
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all";
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
                <h2 class="add_Courior">
                    <table width="99%">
                        <tr>
                            <td width="20%">
                                &nbsp;Courier Master
                            </td>
                            <td width="65%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Courier" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" CausesValidation="false" />
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
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearchCourier" >
            <fieldset class="field_profile">
                <legend>
                    <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td align="justify" style="width: 9%;">
                            <asp:TextBox ID="txtSearchName" runat="server" CssClass="reg_txt" placeholder="Courier Name"></asp:TextBox>
                        </td>
                        <td align="left" width="12%">
                            <div class="merg_btn">
                                <asp:ImageButton ID="BtnSearchCourier" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                    OnClick="BtnSearchCourier_Click" ToolTip="Search" />
                                <asp:ImageButton ID="BtnSearchCourierRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                    OnClick="BtnSearchCourierRefesh_Click" ToolTip="Refresh" />
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
                            </tr>
                        </table>
                    </h4>
                    <asp:GridView ID="GrdCourier" runat="server" AutoGenerateColumns="False" CssClass="grid" DataKeyNames="Flag"
                        EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                        Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                        PageSize="15" OnPageIndexChanging="GrdCourier_PageIndexChanging" OnRowCommand="GrdCourier_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Courier Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Courier_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Courier Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Bind("Courier_Email") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contact No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblContact" runat="server" Text='<%# Bind("Courier_Mobile") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressCode" runat="server" Text='<%# Bind("Courier_Address") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="250px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                        CommandName="CourierEdit" CommandArgument='<%# Bind("Courier_ID") %>' ToolTip="Edit Courier"
                                        CausesValidation="false" />&nbsp;
                                        <%try {
                                              Flag = Convert.ToInt32(GrdCourier.DataKeys[index].Values["Flag"]);
                                          }
                                          catch { } if (Flag == 0)
                                          {%>
                                    <asp:ImageButton ID="ImgbtnDeleteCourier" runat="server" ImageUrl="~/Content/images/delete.png"
                                        CommandName="CourierDelete" CommandArgument='<%# Bind("Courier_ID") %>' ToolTip="Delete Courier"
                                        CausesValidation="false" />
                                        <%} %>
                                        <%index++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="35%" style="display:none;">
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
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtCourierName">
                                                </asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtCourierName"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span>Courier Name :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCourierName" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"
                                                    onchange="checkCourior(this.value)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCouriorChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                                    ControlToValidate="txtCourierEmail" ValidationGroup="PR1" ErrorMessage="a@a.com"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtCourierEmail">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Courier Email :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCourierEmail" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtContactNo">
                                                </asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="PR1" SetFocusOnError="true"
                                                    ID="RegExpValMobNo" runat="server" ErrorMessage="Contact No must be between 10 to 13 number"
                                                    ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10,13}$" />
                                                <strong><span class="astrics">*</span>Contact No. :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactNo" runat="server" CssClass="textbox_pop" Text="" MaxLength="13"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderNo1" runat="server" FilterMode="ValidChars"
                                                    FilterType="Numbers" ValidChars="0123456789" TargetControlID="txtContactNo">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtAddress">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Address :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox_pop" Text="" TextMode="MultiLine" onkeyDown="return checkTextAreaMaxLength(this,event,'200');"
                                                    Height="40px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnCourierSubmit" OnClick="btnCourierSubmit_Click" ValidationGroup="PR1"
                                                CssClass="button_all" runat="server" Text="Save" />&nbsp;&nbsp;<asp:Button ID="btnCourierReset"
                                                    OnClick="btnCourierReset_Click" CausesValidation="false" CssClass="button_all"
                                                    runat="server" Text="Reset" />
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
            <asp:Panel ID="PanelAlert" runat="server" Width="20%" style="display:none;">
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
                            <asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
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
