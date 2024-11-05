<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" Title="Mail Box"
    CodeFile="FrmSendMailaspx.aspx.cs" Inherits="FrmSendMailaspx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(59).addClass("active");
        $(".accordion2 div.open").eq(59).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });
     function SelectAllCheckboxes(ConName, mode) {
            var arr = document.getElementsByName(ConName);
            for (var i = 0; i < arr.length; i++) {
                arr[i].checked = mode;
            }
        }
    </script>

    <script type="text/javascript">
        function GetDetails() {
            // Get id of dropdownlist
            var parm = document.getElementById('<%=ddlToWhome.ClientID%>');
            // Get Dropdownlist selected value item
            var ddlValue = parm.options[parm.selectedIndex].value;

            if (ddlValue == 1) {

                document.getElementById("Tr1").style.display = "";
                document.getElementById("Tr2").style.display = "none";
                document.getElementById("Tr3").style.display = "none";
                document.getElementById("list").style.display = "none";

            }
            else if (ddlValue == 2) {
                document.getElementById("Tr2").style.display = "";
                document.getElementById("Tr1").style.display = "none";
                document.getElementById("Tr3").style.display = "none";
                document.getElementById("list").style.display = "none";

            }
            else if (ddlValue == 3) {
                document.getElementById("Tr3").style.display = "";
                document.getElementById("Tr2").style.display = "none";
                document.getElementById("Tr1").style.display = "none";
                document.getElementById("list").style.display = "none";

            }
            else {
                document.getElementById("Tr2").style.display = "none";
                document.getElementById("Tr1").style.display = "none";
                document.getElementById("Tr3").style.display = "none";
                document.getElementById("list").style.display = "none";

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
                        z-index: 10000; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="make_mail">
                    <table width="99%">
                        <tr>
                            <td width="20%">
                                Send Mail
                            </td>
                            <td width="65%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgBtnSentMail" ToolTip="Compose Mail" OnClick="imgBtnSentMail_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" />
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
                            <td align="justify" style="width: 23%;">
                                <asp:TextBox ID="txtdtFrom" runat="server" CssClass="textbox_pop"></asp:TextBox>
                            </td>
                            <td align="justify" style="width: 23%;">
                                <asp:TextBox ID="txtdtto" runat="server" CssClass="textbox_pop"></asp:TextBox>
                            </td>
                            <td align="left" width="12%">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="BtnSearchDemo" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="BtnSearchDemo_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="BtnSearchDemoRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        ToolTip="Refresh" OnClick="BtnSearchDemoRefesh_Click" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtdtFrom"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtdtFrom"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtdtFrom"
                                    WatermarkText="Date From">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtdtto"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtdtto"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtdtto"
                                    WatermarkText="Date To">
                                </cc1:TextBoxWatermarkExtender>
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
                                    <span class="small_font">(<asp:Label ID="lblCount" runat="server"></asp:Label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </h4>
                    <asp:GridView ID="GrdEmailDetail" runat="server" AutoGenerateColumns="False" CssClass="grid"
                        EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                        Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" OnRowCommand="GrdEmailDetail_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No.">
                                <ItemTemplate>
                                    <%=++sr %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblShoConC" Text='<%#Bind("Entry_Date","{0:dd MMM yyyy HH:mm:ss tt}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <ItemTemplate>
                                    <asp:Label ID="lblcompnameDemo" runat="server" Text='<%# Bind("Mail_From") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject">
                                <ItemTemplate>
                                    <asp:Label ID="lblcompnameDemort" runat="server" Text='<%# Bind("Mail_Subject") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reciepient(s)">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lblNoOfRes" Text='<%#Bind("MailCount") %>' CausesValidation="false"
                                        CommandArgument='<%#Bind("Mail_id") %>' CommandName="MailTo"></asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgBtnEditConV" runat="server" Style="padding-top: 5px;" CausesValidation="false"
                                        CommandArgument='<%#Bind("Mail_id") %>' CommandName="ResendMail" ImageUrl="~/Content/images/mail.png"
                                        ToolTip="Resend" />
                                    <asp:ImageButton ID="imgBtnSecDeleteConv" runat="server" CausesValidation="false"
                                        CommandArgument='<%#Bind("Mail_id") %>' CommandName="DeleteRow" ImageUrl="~/Content/images/delete.png"
                                        ToolTip="Delete" OnClientClick="return confirm('Are You Sure You Want To Delete?')" />
                                    <asp:ImageButton ID="imgBtnMailShow" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Mail_id") %>'
                                        CommandName="ShowMessage" ImageUrl="~/Content/images/vwnm1.png" ToolTip="Detail" />
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelEmail" runat="server" Width="52%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ImageButtonPrd" CssClass="popupClose" runat="server" CausesValidation="false" /></div>                        
                        <div class="service_head_p">
                            <p>
                                <span class="left"><b>Compose Mail
                                    <asp:Label ID="lblchmsg" runat="server" Style="font-size: 13px; color: Red;" Font-Bold="true"></asp:Label></b>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span><em> indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="DemoPanalAllcation" runat="server">
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right" width="80px">
                                            <strong>From :</strong>
                                        </td>
                                        <td width="300px">
                                            <asp:DropDownList ID="ddlFrom" runat="server" CssClass="drp" Width="250px">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="ddlFrom"
                                                ErrorMessage="*" ValidationGroup="Mail1" InitialValue="--Select--"></asp:RequiredFieldValidator>
                                        </td>
                                        <td width="300px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="80px">
                                            <strong>To Whome :</strong>
                                        </td>
                                        <td width="250px">
                                            <asp:DropDownList ID="ddlToWhome" runat="server" CssClass="drp" Width="250px" onchange="GetDetails()">
                                                <asp:ListItem>--Select--</asp:ListItem>
                                                <asp:ListItem Value="1">Textbox</asp:ListItem>
                                                <asp:ListItem Value="2">Excel</asp:ListItem>
                                                <asp:ListItem Value="3">Vcqru</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlToWhome"
                                                ErrorMessage="*" ValidationGroup="Mail1" InitialValue="--Slect--"></asp:RequiredFieldValidator>
                                        </td>
                                        <td id="Tr1" style="display: <%=str1%>" align="left">
                                            <asp:TextBox ID="txtUserEmail" Style="height: 17px;" CssClass="textarea_pop" runat="server"
                                                placeholder="E-mail"></asp:TextBox>
                                        </td>
                                        <td id="Tr2" style="display: <%=str2%>" align="left">
                                            <asp:FileUpload ID="FileExcel" runat="server" />
                                        </td>
                                        <td id="Tr3" style="display: <%=str3%>" align="left">
                                            <asp:LinkButton ID="lnkEmployee" runat="server" OnClick="lnkEmployee_Click" Visible="false">Employee</asp:LinkButton>
                                            &nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkClient" runat="server" OnClick="lnkClient_Click">Company</asp:LinkButton>&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr id="list" style="display: <%=str4%>">
                                        <td align="right" valign="top">
                                            <strong>Email :</strong>
                                        </td>
                                        <td style="line-height: 17px;">
                                            <asp:Label ID="lblAllEmail3" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="middle" width="80px">
                                            <strong>CC :</strong>
                                        </td>
                                        <td width="300px">
                                            <asp:TextBox ID="txtCC" Style="height: 17px;" CssClass="textarea_pop" runat="server" Text="Rakesh@vcqru.com" 
                                                Width="245px"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="middle">
                                            <strong>Subject :</strong>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtSubject" CssClass="textarea_pop" runat="server" Width="97%"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSubject"
                                                ErrorMessage="*" ValidationGroup="Mail1"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top">
                                            <strong>Message :</strong>
                                        </td>
                                        <td colspan="2">
                                            <Custom:CustomEditor runat="server" ID="Editor2" Height="300px" Width="98%" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Editor2"
                                                ErrorMessage="*" ValidationGroup="Mail1"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="middle">
                                            <strong>Attachment :</strong>
                                        </td>
                                        <td colspan="2">
                                            <asp:FileUpload ID="FileAttachment" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <asp:Button ID="ImageButton2" OnClick="ImageButton2_Click" ValidationGroup="Mail1"
                                                CssClass="button_all" runat="server" Text="Send" />
                                            <asp:Button ID="ImageButton3" OnClick="ImageButton3_Click" CausesValidation="false"
                                                CssClass="button_all" runat="server" Text="Reset" />
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
            <cc1:ModalPopupExtender ID="ModalPopupExtenderPrint" runat="server" PopupControlID="PanelEmail"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelPrint" CancelControlID="ImageButtonPrd">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelPrint" runat="server"></asp:Label>
            <asp:Panel ID="PanelReciepient" runat="server" Width="42%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ImageButtonReciepient1" CssClass="popupClose" runat="server" CausesValidation="false" /></div>                        
                        <div class="service_head_p">
                            <p>
                                <span class="left"><b>Reciepient Mail</b> </span><span class="right"><span class="astrics">
                                    <strong></strong></span><em></em></span>
                            </p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Label ID="lblReciepientID1" runat="server"></asp:Label>
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
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="ImageButtonReciepient1" PopupControlID="PanelReciepient" TargetControlID="Label2">
            </cc1:ModalPopupExtender>
            <asp:Label ID="Label2" runat="server"></asp:Label>
            <asp:Panel ID="PanelMessage" runat="server" Width="52%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ImageButtonMessage1" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><b>Message</b> </span><span class="right"><span class="astrics"><strong>
                                </strong></span><em></em></span>
                            </p>
                        </div>
                        <asp:Panel ID="Panel3" runat="server">
                            <div class="regis_popup" style="height:500px; overflow:auto;">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Label ID="lblMailMessage1" runat="server"></asp:Label>
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
            <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="ImageButtonMessage1" PopupControlID="PanelMessage" TargetControlID="Label1">
            </cc1:ModalPopupExtender>
            <asp:Label ID="Label1" runat="server"></asp:Label>
            <asp:Panel ID="PnlEmployee" runat="server" Width="32%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ImageButtonEmpCl1" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><b>
                                    <asp:Label ID="lblPopupHeading" runat="server"></asp:Label></b> </span><span class="right">
                                        <span class="astrics"><strong></strong></span><em></em></span>
                            </p>
                        </div>
                        <asp:Panel ID="Panel4" runat="server">
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center" colspan="4">
                                            <div style="max-height: 200px; overflow: auto;">
                                                <asp:GridView ID="GrdPopEmailSSend" runat="server" AutoGenerateColumns="False" BorderColor="#BEC2CB"
                                                    CellPadding="0" CssClass="grid" EmptyDataText="Record Not Found" AllowPaging="false"
                                                    EmptyDataRowStyle-HorizontalAlign="Center" GridLines="None" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <input id="chkAllotEmpsel" name="chkEMpsel" type="checkbox" title="Click For Select"
                                                                    value='<%#Eval("Email") %>' />
                                                            </ItemTemplate>
                                                            <HeaderTemplate>
                                                                <input id="chkforall" name="chkforall" title="For All Selection" onclick="SelectAllCheckboxes('chkEMpsel',this.checked)"
                                                                    type="checkbox" />
                                                            </HeaderTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="LabelPopEmailEmpname" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="E-mail" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="LabelpopAloteml" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="LabelpopAlotemltpy" runat="server" Text='<%# Bind("Comp_Type") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EmptyDataRowStyle HorizontalAlign="Center" />
                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                    <RowStyle CssClass="tr_line1" />
                                                    <AlternatingRowStyle CssClass="tr_line2" />
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="imgBtnPopupContinue" OnClick="imgBtnPopupContinue_Click" CausesValidation="false"
                                                CssClass="button_all" runat="server" Text="Continue" />
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
            <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="ImageButtonEmpCl1" PopupControlID="PnlEmployee" TargetControlID="Label4">
            </cc1:ModalPopupExtender>
            <asp:Label ID="Label4" runat="server"></asp:Label>
            <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="lblEmpClEmail" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="lblEmpClEMPName" runat="server" Visible="false"></asp:Label>
        </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="ImageButton2" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
