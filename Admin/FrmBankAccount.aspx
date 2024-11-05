<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" Title="Bank Master"
    CodeFile="FrmBankAccount.aspx.cs" Inherits="FrmBankAccount" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(35).addClass("active");
            $(".accordion2 div.open").eq(34).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>    

    <script language="javascript" type="text/javascript">
        function checkAccountNm(vl) {
            PageMethods.checkNewAccount(vl, onCompleteAccount)
        }
        function onCompleteAccount(Result) {
            if (Result == true) {
                document.getElementById("<%=lblbankAcc.ClientID %>").innerHTML = "Bank Name Already exist.";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblbankAcc.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "button_all";
            }
        } 
               
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
                <h2 class="add_account">
                    <table width="99%">
                        <tr>
                            <td width="20%">
                                &nbsp;Add Bank Account
                            </td>
                            <td width="65%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Bank Account" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" />
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
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearchDemo" >
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style=" display:none;"><%--width: 23%;--%>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="justify" style=" display:none;"><%--width: 23%;--%>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="justify" width="7%">
                            <asp:TextBox ID="txtCompName" runat="server" CssClass="reg_txt" placeholder ="Bank Name" />
                                
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="reg_txt" Visible="false" >
                                </asp:DropDownList>
                            </td>
                            <td align="left" width="12%">
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
                    <asp:GridView ID="GrdBankAccount" runat="server" AutoGenerateColumns="False" CssClass="grid"
                        DataKeyNames="Flag" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdCodePrintDemo_PageIndexChanging"
                        OnRowCommand="GrdBankAccount_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Bank Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblBankName" runat="server" Text='<%# Bind("Bank_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Bind("Account_No") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Branch">
                                <ItemTemplate>
                                    <asp:Label ID="lblBranch" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IFSC">
                                <ItemTemplate>
                                    <asp:Label ID="lblifscCode" runat="server" Text='<%# Bind("IFSC_Code") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RTGS">
                                <ItemTemplate>
                                    <asp:Label ID="lblRTGSCode" runat="server" Text='<%# Bind("RTGS_Code") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                    <asp:Label ID="lblAccAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblAccType" runat="server" Text='<%# Bind("Account_Type") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImgbtnEditAcc" runat="server" ImageUrl="~/Content/images/edit.png" CommandName="AccountEdit"
                                        CommandArgument='<%# Bind("Bank_ID") %>' ToolTip="Edit Account" />&nbsp;
                                    <%try
                                      {
                                          AFlag = Convert.ToInt32(GrdBankAccount.DataKeys[index].Values["Flag"].ToString());

                                      }
                                      catch { }
                                      if (AFlag == 1)
                                      {%>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Content/images/check_act.png"
                                        OnClientClick="return confirm('Are you sure to De-Activate this account')" CommandName="ActCommand"
                                        CommandArgument='<%# Bind("Bank_ID") %>' ToolTip="De-Activate" />
                                    <%}
                                      else
                                      {%>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Content/images/check_gr.png"
                                        OnClientClick="return confirm('Are you sure to Activate this account')" CommandName="ActCommand"
                                        CommandArgument='<%# Bind("Bank_ID") %>' ToolTip="Activate" />
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
            <asp:Panel ID="PanelNewDesign" runat="server" Width="35%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewDesign" CssClass="popupClose" runat="server" /></div>
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblAddAccountHeader" runat="server" Text=""></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="DivNewMsg" runat="server">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Bank Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtbankname">
                                                </asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtbankname"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span>Bank Name :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtbankname" runat="server" CssClass="textbox_pop" Text="" MaxLength="150"
                                                    onchange="checkAccountNm(this.value);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                            </td>
                                            <td>
                                                <asp:Label ID="lblbankAcc" runat="server" CssClass="astrics"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtAccHolderNm">
                                                </asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="txtAccHolderNm"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span>Account Holder Name :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAccHolderNm" runat="server" CssClass="textbox_pop" Text="" MaxLength="150"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtAccountNo">
                                                </asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValCalloutAccountNo" runat="server" TargetControlID="RegExpValAccountNo">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="PR" SetFocusOnError="true"
                                                    ID="RegExpValAccountNo" runat="server" ErrorMessage="Account No must be between 10 to 20 number"
                                                    ControlToValidate="txtAccountNo" ValidationExpression="^[0-9]{10,20}$" />
                                                <strong><span class="astrics">*</span>Account No. :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAccountNo" runat="server" CssClass="textbox_pop" Text="" MaxLength="20"
                                                    OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtBranch">
                                                </asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" TargetControlID="txtBranch"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span>Branch. :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtBranch" runat="server" CssClass="textbox_pop" Text="" MaxLength="150"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtifscCode">
                                                </asp:RequiredFieldValidator>
                                                <%--<asp:RegularExpressionValidator ValidationGroup="PR" ValidationExpression="[A-Z|a-z]{4}[0][\d]{6}$"
                                                    Display="None" SetFocusOnError="true" ControlToValidate="txtifscCode" ID="RegularExpressionValidator3"
                                                    runat="server" ErrorMessage="Invalid IFSC Code"></asp:RegularExpressionValidator>--%>
                                                <strong><span class="astrics">*</span>IFSC Code :</strong>
                                            </td>
                                            <td>
                                               <%-- <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtenderPan" runat="server" TargetControlID="RegularExpressionValidator3">
                                                </cc1:ValidatorCalloutExtender>--%>
                                                <asp:TextBox ID="txtifscCode" runat="server" CssClass="textbox_pop" Text="" MaxLength="11"
                                                    onchange="UpperVal(this.value,this.id)" Style="text-transform: capitalize;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtCity">
                                                </asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" TargetControlID="txtCity"
                                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-.,/',./';<>?:1234567890">
                                                </cc1:FilteredTextBoxExtender>
                                                <strong><span class="astrics">*</span>City :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCity" runat="server" CssClass="textbox_pop" Text="" MaxLength="50"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtrtgsCode">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>RTGS Code :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtrtgsCode" runat="server" CssClass="textbox_pop" Text="" MaxLength="20"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR" ControlToValidate="txtaddress">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Address :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" Height="50px" CssClass="textbox_pop" MaxLength="250" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td align="right">
                                                <strong><span class="astrics">*</span>Account type :</strong>
                                            </td>
                                            <td>
                                                <div class="myrd">
                                                    <asp:RadioButton ID="rdcurrent" Checked="true" GroupName="BNK" runat="server" Text="Current" /><asp:RadioButton
                                                        ID="rdsaving" GroupName="BNK" runat="server" Text="Saving" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" ValidationGroup="PR" CssClass="button_all"
                                                runat="server" Text="Save" />&nbsp;&nbsp;<asp:Button ID="btnReset" OnClick="btnReset_Click"
                                                    CausesValidation="false" CssClass="button_all" runat="server" Text="Reset" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
