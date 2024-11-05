<%@ Page Title="Retailer Details" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
    AutoEventWireup="true" CodeFile="FrmRetailers.aspx.cs" Inherits="Retailer_RetailerDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(10).addClass("active");
            $(".accordion2 div.open").eq(2).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script language="javascript" type="text/javascript">
        function checkproduct(vl) {
            PageMethods.checkNewProduct(vl, onCompleteProduct)
        }
        function onCompleteProduct(Result) {
            if (Result == true) {

                //                document.getElementById("NewMsg").style.visibility = "visible";
                //                document.getElementById("NewMsg").className = "alert_boxes_red";
                document.getElementById("<%=lblmsgmail.ClientID %>").innerHTML = "Email Id Already exist.";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = true;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all_Sec";

            }
            else {
                //                document.getElementById("NewMsg").style.visibility = "hidden";
                document.getElementById("<%=lblmsgmail.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = false;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all";

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
                <h2 class="demo_code">
                    <table width="99%">
                        <tr>
                            <td width="30%">
                                Retailer Master
                            </td>
                            <td width="55%">
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Retailer" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="NewMsgpop" runat="server">
                <p>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label></p>
            </div>
            <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td width="18%">
                                <asp:TextBox placeholder="Company Name" ID="txtCompanyName" ToolTip="Company Name"
                                    runat="server" Text="" CssClass="reg_txt" MaxLength="30"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" TargetControlID="txtCompanyName"
                                    runat="server" MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1"
                                    CompletionInterval="1000" ServiceMethod="GetCountries" CompletionListCssClass="AutoExtender"
                                    CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                </cc1:AutoCompleteExtender>
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtContactPerson" placeholder="Contact Person" ToolTip="Contact Person"
                                    runat="server" Text="" CssClass="reg_txt" MaxLength="30"></asp:TextBox>
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt" ToolTip="Date From"></asp:TextBox>
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt" ToolTip="Date From"></asp:TextBox>
                            </td>
                            <td>
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        ToolTip="Refresh" OnClick="ImgRefresh_Click" />
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
                                <%--<cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                            TargetControlID="txtDateFrom" WatermarkText="Print From">
                                        </cc1:TextBoxWatermarkExtender>--%>
                                <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <%--<cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                            WatermarkText="Print To">
                                        </cc1:TextBoxWatermarkExtender>--%>
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
                <asp:GridView ID="GrdDemoCodeAllote" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True" OnRowCommand="GrdDemoCodeAllote_RowCommand"
                    PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="Register Date">
                            <ItemTemplate>
                                <asp:Label ID="lblRefno" runat="server" Text='<%# Bind("SendDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblAllotDateNew" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="22%" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact Person">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("Contact_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact No.">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("Contact_No") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="14%" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email ID">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes" runat="server" Text='<%# Bind("Email_ID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgAddCodes" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Comp_ID") %>'
                                    CommandName="CodeAllocation" ImageUrl="../Content/images/add_new.png" ToolTip="Allocate New Codes" />&nbsp;
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" CssClass="grd_pad" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:HiddenField ID="hdnnewcmp" runat="server" />
            </div>
            <asp:Panel ID="PanelNewDesign" runat="server" Width="32%">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewDesign" CssClass="popupClose" runat="server" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>Packet Allocation<asp:Label ID="Label2" runat="server"></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="LicencePanalAllcation" runat="server">
                            <div class="regis_popup">
                                <div id="NewMsg" runat="server" class="alert_boxes_green">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                    <legend>Personal Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" style="width: 36%;">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" ControlToValidate="txtEmailDemo"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                                    ControlToValidate="txtEmailDemo" ValidationGroup="Demo" ErrorMessage="a@a.com"
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                <strong><span class="astrics">*</span>Email :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtEmailDemo" CssClass="textbox_pop" runat="server" onchange="checkproduct(this.value);"
                                                    MaxLength="30"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblmsgmail" runat="server" Style="color: Red; font-family: Verdana;
                                                    font-size: 10px;"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" ControlToValidate="txtCompantNameDemo"></asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtCompantNameDemo"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span> Company Name :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCompantNameDemo" CssClass="textbox_pop" runat="server" MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" ControlToValidate="txtContactNoDemo"></asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="txtContactPersonNameDemo"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span> Contact Person :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactPersonNameDemo" CssClass="textbox_pop" runat="server"
                                                    MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" ControlToValidate="txtContactNoDemo"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="Demo" SetFocusOnError="true"
                                                    ID="RegExpValMobNo" runat="server" ErrorMessage="Contact No must be between 10 to 13 number"
                                                    ControlToValidate="txtContactNoDemo" ValidationExpression="^[0-9]{10,13}$" />
                                                <strong><span class="astrics">*</span> Contact No : </strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtContactNoDemo" CssClass="textbox_pop" runat="server" MaxLength="13"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="txtMobFilteredTextBoxExtender" ValidChars="-+0123456789"
                                                    FilterMode="ValidChars" TargetControlID="txtContactNoDemo">
                                                </cc1:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset id="Fieldset1" runat="server" class="Newfield Newfield_width2">
                                    <legend>Packet Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" width="36%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" InitialValue="--Select--" ControlToValidate="ddlPackage"></asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span> Packet Type: </strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPackage" OnSelectedIndexChanged="ddlPackage_SelectedIndexChanged"
                                                    CssClass="drp" AutoPostBack="true" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="avapac" runat="server">
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="Demo" InitialValue="--Select Packet--" ControlToValidate="ddlPackageName"></asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span> Available Packet : </strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPackageName" CssClass="drp" runat="server">
                                                </asp:DropDownList>
                                                <asp:Label ID="lblAvlPacket" runat="server" Text="" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnSaveDemo" OnClick="btnSaveDemo_Click" ValidationGroup="Demo" CssClass="button_all"
                                                runat="server" Text="Register" />
                                            <asp:Button ID="btnResetDemo" OnClick="btnResetDemo_Click" CssClass="button_all"
                                                runat="server" Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <!--</fieldset>-->
                        <!-- END List Wrap -->
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewDesign"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewDesign">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
            <asp:Panel ID="PanelAllocation" runat="server" Width="32%">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="Button1Allot" CssClass="popupClose" runat="server" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>Packet Allocation<asp:Label ID="Label1" runat="server"></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel2" runat="server">
                            <div class="regis_popup">
                                <div id="Div1" runat="server" class="alert_boxes_green">
                                    <p>
                                        <asp:Label ID="Label3" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <fieldset id="Fieldset3" runat="server" class="Newfield Newfield_width2">
                                    <legend>Packet Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" width="36%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                                    ValidationGroup="ALLCODE" InitialValue="--Select--" ControlToValidate="ddlPackageNew"></asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span> Packet Type: </strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPackageNew" OnSelectedIndexChanged="ddlPackageNew_SelectedIndexChanged"
                                                    CssClass="drp" AutoPostBack="true" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="Tr1" runat="server">
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red"
                                                    ValidationGroup="ALLCODE" InitialValue="--Select Packet--" ControlToValidate="ddlPackageNameNew"></asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span> Available Packet : </strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPackageNameNew" CssClass="drp" runat="server">
                                                </asp:DropDownList>
                                                <asp:Label ID="Label5" runat="server" Text="" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnSaveNew" OnClick="btnSaveNew_Click" ValidationGroup="ALLCODE" CssClass="button_all"
                                                runat="server" Text="Allocate" />
                                            <asp:Button ID="btnResetNew" OnClick="btnResetNew_Click" CssClass="button_all" runat="server"
                                                Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <!--</fieldset>-->
                        <!-- END List Wrap -->
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNew" runat="server" PopupControlID="PanelAllocation"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelAllo6" CancelControlID="Button1Allot">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelAllo6" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
