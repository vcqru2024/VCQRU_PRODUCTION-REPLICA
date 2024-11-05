<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="UpdateCompanyProfile.aspx.cs" Inherits="Admin_UpdateCompanyProfile" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1025px; width: 100%;
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
                <h2 class="up_comp">
                    <table width="99%">
                        <tr>
                            <td width="30%">
                                &nbsp;Update Company Profile
                            </td>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                <p>
                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label></p>
            </div>
            <asp:Panel ID="DefaultButton" runat="server" DefaultButton="btnUpDate">
                <fieldset class="Newfield Newfield_width">
                    <legend>
                        <asp:Label ID="Labeldd" runat="server" Text="General Info"></asp:Label>
                    </legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr style="height: 27px;">
                            <td align="right" width="20%">
                                <strong><span class="astrics">*</span>Company Name :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" ControlToValidate="txtCompName" ErrorMessage="its required"></asp:RequiredFieldValidator>
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtCompName"
                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                </cc1:FilteredTextBoxExtender>
                                
                            </td>
                            <td width="32%">
                                <asp:TextBox ID="txtCompName" MaxLength="20" CssClass="textbox_pop" runat="server"
                                    placeholder="Company Name (Max 20 char)"></asp:TextBox>
                            </td>
                            <td align="right">
                                <strong><span class="astrics">*</span>Category :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" InitialValue="--Select--" ControlToValidate="ddlCategory" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                
                            </td>
                            <td width="32%">
                                <asp:DropDownList ID="ddlCategory" CssClass="drp" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="height: 27px;">
                            <td align="right">
                                <strong><span class="astrics">*</span>Email :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" ControlToValidate="txtEmail" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                    ControlToValidate="txtEmail" ValidationGroup="1" ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" MaxLength="50" onchange="checkproduct(this.value);" CssClass="textbox_pop"
                                    runat="server"></asp:TextBox>
                            </td>
                            <td align="right">
                                 <strong>Website :</strong>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtWebSite"
                                    ValidationGroup="chk94" ErrorMessage="Invalid" ValidationExpression="([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
                               
                            </td>
                            <td>
                                <asp:TextBox ID="txtWebSite" MaxLength="50" CssClass="textbox_pop" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lblemail" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr style="height: 27px;">
                            <td align="right">
                                 <strong><span class="astrics">*</span>State :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" InitialValue="--Select--" ControlToValidate="ddlState" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                               
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlState" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                                    AutoPostBack="true" CssClass="drp" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                <strong><span class="astrics">*</span>City :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" InitialValue="--Select--" ControlToValidate="ddlCity" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCity" CssClass="drp" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset class="Newfield Newfield_width">
                    <legend>
                        <asp:Label ID="Label782" runat="server" Text="Contact Info"></asp:Label>
                    </legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr style="height: 27px;">
                            <td align="right" width="20%">
                                 <strong><span class="astrics">*</span>Person :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="txtPersonName"
                                    runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                </cc1:FilteredTextBoxExtender>
                               
                            </td>
                            <td width="32%">
                                <asp:TextBox ID="txtPersonName" MaxLength="50" CssClass="textbox_pop" runat="server"></asp:TextBox>
                            </td>
                            <td align="right">
                                 <strong><span class="astrics">*</span>Mobile No. :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" ControlToValidate="txtMob" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtMob"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValMobNo" runat="server" ErrorMessage="Mobile No must be between 10 to 13 number"
                                    ControlToValidate="txtMob" ValidationExpression="^[0-9]{10,13}$" />
                               
                            </td>
                            <td width="32%">
                                <asp:TextBox ID="txtMob" MaxLength="15" CssClass="textbox_pop" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender2" TargetControlID="txtPhone"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender8" TargetControlID="txtPhone1"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender9" TargetControlID="txtPhone0"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:ValidatorCalloutExtender ID="ValCalloutPhoneNo" runat="server" TargetControlID="RegExpValPhoneNo0">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValPhoneNo0" runat="server" ErrorMessage="Country Code must be between 2 to 4 number"
                                    ControlToValidate="txtPhone0" ValidationExpression="^[0-9]{2,4}$" />
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="RegExpValPhoneNo1">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValPhoneNo1" runat="server" ErrorMessage="City Code must be between 2 to 4 number"
                                    ControlToValidate="txtPhone1" ValidationExpression="^[0-9]{2,4}$" />
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="RegExpValPhoneNo">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValPhoneNo" runat="server" ErrorMessage="Phone No must be between 6 to 8 number"
                                    ControlToValidate="txtPhone" ValidationExpression="^[0-9]{6,8}$" />
                                <strong>Phone No. :&nbsp;<b>+</b>&nbsp;</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPhone0" MaxLength="4" CssClass="textbox_pop" Width="35" Text="91"
                                    runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                <asp:TextBox ID="txtPhone1" MaxLength="4" CssClass="textbox_pop" Width="47" placeholder="STD Code"
                                    runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                <asp:TextBox ID="txtPhone" MaxLength="8" CssClass="textbox_pop" Width="70" placeholder="Phone No."
                                    runat="server"></asp:TextBox>
                            </td>
                            <td align="right">
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender3" TargetControlID="txtFax"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender6" TargetControlID="txtFax0"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender7" TargetControlID="txtFax1"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="RegExpValFaxNo0">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValFaxNo0" runat="server" ErrorMessage="Country Code must be between 2 to 4 number"
                                    ControlToValidate="txtFax0" ValidationExpression="^[0-9]{2,4}$" />
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" TargetControlID="RegExpValFaxNo1">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValFaxNo1" runat="server" ErrorMessage="City Code must be between 2 to 4 number"
                                    ControlToValidate="txtFax1" ValidationExpression="^[0-9]{2,4}$" />
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" TargetControlID="RegExpValFaxNo">
                                </cc1:ValidatorCalloutExtender>
                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                    ID="RegExpValFaxNo" runat="server" ErrorMessage="Phone No must be between 6 to 8 number"
                                    ControlToValidate="txtFax" ValidationExpression="^[0-9]{6,8}$" />
                                <strong>Fax :&nbsp;<b>+</b>&nbsp;</strong>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFax0" MaxLength="5" CssClass="textbox_pop" Width="35" Text="91"
                                    runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                <asp:TextBox ID="txtFax1" MaxLength="5" CssClass="textbox_pop" Width="47" placeholder="STD Code"
                                    runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                <asp:TextBox ID="txtFax" MaxLength="8" CssClass="textbox_pop" Width="70" placeholder="Fax No."
                                    runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">
                                <strong><span class="astrics">*</span>Address :</strong>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                    ValidationGroup="chk94" ControlToValidate="txtAddress" ErrorMessage="its required">
                                </asp:RequiredFieldValidator>
                                
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="txtAddress" Height="45" CssClass="textarea_pop" TextMode="MultiLine"
                                    MaxLength="250" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                    runat="server" Width="94%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">
                            </td>
                            <td colspan="3">
                                <asp:Label Text="250 characters." ForeColor="Red" Font-Size="10px" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset class="Newfield Newfield_width">
                    <legend>
                        <asp:Label ID="Label89652" runat="server" Text="Company Name Sound File (*.wav)"></asp:Label>
                    </legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr style="height: 27px;">
                            <td>
                                <table>
                                    <tr>
                                        <td style="width: 20%;">
                                            <asp:RequiredFieldValidator ID="rfvsound" runat="server" ValidationGroup="chk94"
                                                ControlToValidate="flSound" ErrorMessage="its required"></asp:RequiredFieldValidator>
                                            <asp:FileUpload ID="flSound" onchange="fileTypeCheckeng(this.value);" runat="server" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblfile" runat="server" CssClass="astrics"></asp:Label>
                                            <ul class="graphic">
                                                <li><a id="FileDown" runat="server" title="Play" class="sm2_link"></a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click" ValidationGroup="chk94" CssClass="button_all"
                                runat="server" Text="Update" />
                            <%--<asp:Button ID="btnNextDoc" OnClick="btnNextDoc_Click" CssClass="button_all" Visible="false"
                                runat="server" Text="Next" />--%>
                            <%--<asp:Button ID="btnReset" OnClick = "btnReset_Click" CssClass = "button_all" runat="server" Text="Reset" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3 style="color:#024F9F"><u>General Instructions :-</u></h3>
                            <asp:Label ID="lblfiletype" Style="font-family: Arial; font-size: 12px; color: red;"
                                runat="server" Text="File Type ---- .wav, Company Name Max 20 character"></asp:Label>
                            <br />
                            <asp:Label ID="lblrecord" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                runat="server" Text="For record the audio file, Please click the link "></asp:Label>
                            &nbsp; <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                color: Blue;" target="_blank">Click</a>
                            <br />
                            <asp:Label ID="lblformatfile" Style="font-family: Arial; font-size: 12px; color: red;"
                                runat="server" Text="Please kindly upload your company name sound file as you would
                                                    like to play to consumers"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnUpDate" />
        </Triggers>
    </asp:UpdatePanel>
    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(1).addClass("active");
            $(".accordion2 div.open").eq(0).show();

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
                document.getElementById("<%=lblemail.ClientID %>").innerHTML = "Email Id Already exist.";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblemail.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all";

            }
        }
        function fileTypeCheckeng(mm) {
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all";

            }
        }        
    </script>
</asp:Content>

