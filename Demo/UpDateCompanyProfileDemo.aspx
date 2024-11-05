<%@ Page Language="C#" MasterPageFile="~/Demo/MasterPage.master" AutoEventWireup="true"
    Title="Update Profile" CodeFile="UpDateCompanyProfileDemo.aspx.cs" Inherits="UpDateCompanyProfileDemo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(0).addClass("active");
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
        function fileTypeCheckengDemo(mm) {
            PageMethods.checkFile(mm, onengcheckDD)
        }
        function onengcheckDD(Result) {
            if (Result == true) {
                document.getElementById("<%=Label6.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = true;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=Label6.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = false;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all";

            }
        }
        function fileTypeCheckengH(mm) {
            PageMethods.checkFile(mm, onengcheckH)
        }
        function onengcheckH(Result) {
            if (Result == true) {
                document.getElementById("<%=L2.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = true;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=L2.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = false;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all";

            }
        }

        function fileTypeCheckengE(mm) {
            PageMethods.checkFile(mm, onengcheckE)
        }
        function onengcheckE(Result) {
            if (Result == true) {
                document.getElementById("<%=L1.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = true;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=L1.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = false;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all";

            }
        }
        function fileTypeCheckpro(mm) {
            PageMethods.checkFile(mm, onengcheckpro)
        }
        function onengcheckpro(Result) {
            if (Result == true) {
                document.getElementById("<%=Label11.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSaveDemo.ClientID %>").disabled = true;
                document.getElementById("<%=btnSaveDemo.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=Label11.ClientID %>").innerHTML = "";
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
                            <td width="42%">
                                &nbsp;Company &amp; Product related information
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
            <asp:Panel ID="DefaultButton" runat="server" DefaultButton="btnSaveDemo">
                <div class="tab_cont" id="billing">
                    <div class="pin">
                        <div id="DivNewMsg" runat="server">
                            <p>
                                <asp:Label ID="LblMsgCodes" runat="server"></asp:Label>
                            </p>
                        </div>
                        <div id="DemoDivCodeInfo" runat="server" visible="false">
                            <fieldset id="Fieldset5" runat="server" class="Newfield">
                                <legend>Packet Info</legend>
                                <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis" style="margin-top: 0px;
                                    margin-bottom: 0px;">
                                    <tr>
                                        <td align="right" style="width: 30%;">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDemopackeageCode" ValidationGroup="PacSec"
                                                ControlToValidate="txtDemoPackeageCode" runat="server"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Packet secret code:</strong>
                                        </td>
                                        <td colspan="3" style="width: 70%;">
                                            <asp:TextBox ID="txtDemoPackeageCode" MaxLength="50" AutoPostBack="false" CssClass="textbox_pop"
                                                runat="server" Width="80px"></asp:TextBox>
                                            <asp:TextBox ID="TextBox1" MaxLength="50" AutoPostBack="false" CssClass="textbox_pop"
                                                runat="server" Width="80px" Visible="false"></asp:TextBox>
                                            &nbsp; &nbsp;&nbsp;<asp:Button ID="btnContinueDemo" ValidationGroup="PacSec" CssClass="button_all"
                                                OnClick="btnContinueDemo_Click" runat="server" Text="Continue" />
                                            <asp:Button ID="btnpacketInfoReset" CssClass="button_all" OnClick="btnpacketInfoReset_Click"
                                                runat="server" Text="Reset" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div id="DemoDiv" runat="server">
                            <fieldset id="Fieldset6" runat="server" class="Newfield">
                                <legend>Company Info&nbsp;(<asp:Label ID="txtNoOfCodes" Style="font-family: Arial;
                                    font-size: 11px; color: Red;" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblcodedetail"
                                        Text="Code available" Style="font-family: Arial; font-size: 11px; color: Red;"
                                        runat="server"></asp:Label>)</legend>
                                <table width="100%" cellpadding="0" cellspacing="0" class="tab_regis" style="margin-top: 0px;
                                    margin-bottom: 0px;">
                                    <tr>
                                        <td align="right" style="width: 20%;">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9DHello" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtCompNameD"></asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="txtCompNameD"
                                                runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                            <strong><span class="astrics">*</span>Company Name :</strong>
                                        </td>
                                        <td style="width: 30%;">
                                            <asp:TextBox ID="txtCompNameD" MaxLength="20" TabIndex="1" CssClass="textbox_pop"
                                                runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right" style="width: 20%;">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtPersonNameD">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender900989" TargetControlID="txtPersonNameD"
                                                FilterMode="InvalidChars" InvalidChars=".:;',?<>~`!@#$%^&*()_+|\/{}[]-0123456789">
                                            </cc1:FilteredTextBoxExtender>
                                            <strong><span class="astrics">*</span>Contact Person :</strong>
                                        </td>
                                        <td style="width: 30%;">
                                            <asp:TextBox ID="txtPersonNameD" MaxLength="50" CssClass="textbox_pop" runat="server"
                                                TabIndex="7"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr visible="false" id="Tr1" runat="server">
                                        <td align="right" colspan="4">
                                            <asp:TextBox ID="txtCategoryDemo" AutoPostBack="true" CssClass="textbox_pop" runat="server"
                                                Width="125px"></asp:TextBox>
                                            <span>
                                                <asp:ImageButton ID="ImageButtonCloseDemo" runat="server" ImageUrl="~/images/cross-icon.gif"
                                                    Height="20px" Width="17px" ToolTip="Close" /></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtEmailD">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEmailD"
                                                ValidationGroup="chk9420" ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                            <strong><span class="astrics">*</span>Email Id :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmailD" MaxLength="50" onchange="checkproductDemo(this.value);"
                                                CssClass="textbox_pop" runat="server" TabIndex="3"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtMobD">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender4" TargetControlID="txtMobD"
                                                FilterType="Numbers" InvalidChars=".">
                                            </cc1:FilteredTextBoxExtender>
                                            <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo1" runat="server" TargetControlID="RegExpValContactNo">
                                            </cc1:ValidatorCalloutExtender>
                                            <asp:RegularExpressionValidator Display="None" ValidationGroup="chk9420" SetFocusOnError="true"
                                                ID="RegExpValContactNo" runat="server" ErrorMessage="Contact No must be between 10 to 13 number"
                                                ControlToValidate="txtMobD" ValidationExpression="^[0-9]{10,13}$" />
                                            <strong><span class="astrics">*</span>Contact No. :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMobD" MaxLength="15" CssClass="textbox_pop" runat="server" TabIndex="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="3">
                                            <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr height="20">
                                        <td colspan="4">
                                            <div class="bord_hr">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10D" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" InitialValue="--Select--" ControlToValidate="ddlCategoryD">
                                            </asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Category :</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCategoryD" CssClass="drp" runat="server" TabIndex="2" Style="text-transform: capitalize;">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                            <strong><span class="astrics">*</span>State :</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlStateD" OnSelectedIndexChanged="ddlStateD_SelectedIndexChanged"
                                                AutoPostBack="true" CssClass="drp" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" InitialValue="--Select--" ControlToValidate="ddlCityID">
                                            </asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>City :</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCityID" CssClass="drp" runat="server" TabIndex="6" Style="text-transform: capitalize;">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="right">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" cellpadding="0" cellspacing="0" class="tab_regis" style="margin-top: 0px;
                                    margin-bottom: 0px;">
                                    <tr>
                                        <td align="right" style="width: 20%;">
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtWebSiteD"
                                                ValidationGroup="chk9420" ErrorMessage="Invalid" ValidationExpression="^(http\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$"></asp:RegularExpressionValidator>
                                            <strong>Website :</strong>
                                        </td>
                                        <td style="width: 30%;">
                                            <asp:TextBox ID="txtWebSiteD" MaxLength="50" CssClass="textbox_pop" runat="server"
                                                TabIndex="4"></asp:TextBox>
                                        </td>
                                        <td align="right" style="width: 20%;">
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender6" TargetControlID="txtFaxD0"
                                                FilterType="Numbers" InvalidChars=".">
                                            </cc1:FilteredTextBoxExtender>
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender2" TargetControlID="txtFaxD1"
                                                FilterType="Numbers" InvalidChars=".">
                                            </cc1:FilteredTextBoxExtender>
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender3" TargetControlID="txtFaxD"
                                                FilterType="Numbers" InvalidChars=".">
                                            </cc1:FilteredTextBoxExtender>
                                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="RegExpValFaxNo0">
                                            </cc1:ValidatorCalloutExtender>
                                            <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                ID="RegExpValFaxNo0" runat="server" ErrorMessage="Country Code must be between 2 to 4 number"
                                                ControlToValidate="txtFaxD0" ValidationExpression="^[0-9]{2,4}$" />
                                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" TargetControlID="RegExpValFaxNo1">
                                            </cc1:ValidatorCalloutExtender>
                                            <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                ID="RegExpValFaxNo1" runat="server" ErrorMessage="City Code must be between 2 to 4 number"
                                                ControlToValidate="txtFaxD1" ValidationExpression="^[0-9]{2,4}$" />
                                            <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" TargetControlID="RegExpValFaxNo">
                                            </cc1:ValidatorCalloutExtender>
                                            <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                ID="RegExpValFaxNo" runat="server" ErrorMessage="Phone No must be between 6 to 8 number"
                                                ControlToValidate="txtFaxD" ValidationExpression="^[0-9]{6,8}$" />
                                            <strong>Fax :&nbsp;<b>+</b>&nbsp;</strong>
                                        </td>
                                        <td style="width: 30%;">
                                            <asp:TextBox ID="txtFaxD0" MaxLength="5" CssClass="textbox_pop" Width="35" Text="91"
                                                runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                            <asp:TextBox ID="txtFaxD1" MaxLength="5" CssClass="textbox_pop" Width="35" placeholder="STD"
                                                runat="server"></asp:TextBox>&nbsp;<b>-</b>&nbsp;
                                            <asp:TextBox ID="txtFaxD" MaxLength="8" CssClass="textbox_pop" Width="70" placeholder="Fax No."
                                                runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong>Address :</strong>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtAddressD" Style="height: 35px; width: 94.4%;" TabIndex="5" CssClass="textarea_pop"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'250');" TextMode="MultiLine"
                                                runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table style="padding-top:8px;" >
                                                <tr>
                                                    <td align="right" style="width: 47%;">
                                                        <strong>Company Name Sound File (*.wav) :</strong>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ForeColor="Red"
                                                            ValidationGroup="chk9420" ControlToValidate="flSoundD">
                                                        </asp:RequiredFieldValidator>
                                                        <strong style="color: Red;">*</strong>
                                                        <asp:FileUpload ID="flSoundD" Width="80%" onchange="fileTypeCheckengDemo(this.value);"
                                                            runat="server" />
                                                    </td>
                                                    <td align="left">
                                                        <ul class="graphic">
                                                            <li><a id="FileDown" runat="server" title="Play" class="sm2_link"></a></li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" TabIndex="11" Style="color: Red; font-family: Arial;
                                                font-size: 12px;"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <%-------------------------Company Reg-----------------%>
                            <fieldset id="Fieldset9" runat="server" class="Newfield">
                                <legend>Product Info</legend>
                                <table width="100%" cellpadding="0" class="tab_regis" cellspacing="0" style="margin-top: 0px;
                                    margin-bottom: 0px;">
                                    <tr>
                                        <td align="right" style="width: 25%">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="--Select--"
                                                ForeColor="Red" ValidationGroup="chk9420" ControlToValidate="txtProductName"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span> Name :</strong>
                                        </td>
                                        <td style="width: 30%;">
                                            <asp:TextBox ID="txtProductName" MaxLength="50" CssClass="textbox_pop" runat="server"></asp:TextBox>
                                        </td>
                                        <td >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%;" align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19produ" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="flSoundProduct">
                                            </asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Product Name Audio (*.wav) :</strong>
                                        </td>
                                        <td style="padding-top:5px;">
                                            <asp:FileUpload ID="flSoundProduct" onchange="fileTypeCheckpro(this.value);" runat="server"
                                                ToolTip="Product Name Audio (*.wav)" Width="64%" />
                                        </td>
                                        <td>
                                            <ul class="graphic">
                                                <li><a id="A1" runat="server" title="Play" class="sm2_link"></a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset id="Fieldset1" runat="server" class="Newfield">
                                <legend>Batch Info</legend>
                                <table width="100%" cellpadding="0" class="tab_regis" cellspacing="0" style="margin-top: 0px;
                                    margin-bottom: 0px;">
                                    <tr>
                                        <td align="right">
                                        </td>
                                        <td>
                                        </td>
                                        <td colspan="2" align="center">
                                            <asp:Label ID="Label11" runat="server" TabIndex="11" CssClass="astrics"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtBatchNo"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span> Batch No :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtBatchNo" MaxLength="50" CssClass="textbox_pop" runat="server"
                                                onchange="CheckBatch_NoVal(this.value)"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtMRP"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span> MRP :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMRP" MaxLength="7" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="txtMfd_Date"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span> Mfd Date :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMfd_Date" MaxLength="50" CssClass="textbox_pop" runat="server"></asp:TextBox>
                                        </td>
                                        <td align="right">
                                            <strong>Exp Date :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtExp_Date" MaxLength="50" onchange="checkproduct(this.value);"
                                                CssClass="textbox_pop" runat="server"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="chk9420"
                                                ForeColor="Red" ControlToCompare="txtMfd_Date" ControlToValidate="txtExp_Date"
                                                Operator="GreaterThan" Type="Date" Text="*"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong>Message :</strong>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtcomment" Style="width: 94%;" TextMode="MultiLine" Height="30px" MaxLength="25" CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="astrics">
                                            Message should be in 25 character
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset class="Newfield">
                                <legend>Message Audio Files(*.wav)</legend>
                                <table width="100%" cellpadding="0" class="tab_regis" cellspacing="2">
                                    <tr>
                                        <td width="22%">
                                        </td>
                                        <td width="28%">
                                        </td>
                                        <td width="22%">
                                        </td>
                                        <td width="28%">
                                            <asp:Label ID="lblname" runat="server" CssClass="astrics"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator522PH" runat="server" ForeColor="Red"
                                                ValidationGroup="chk9420" ControlToValidate="flSoundPH"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Hindi (*.wav) :</strong>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td width="80%">
                                                        <asp:FileUpload ID="flSoundPH" onchange="fileTypeCheckengH(this.value);" runat="server"
                                                            Style="width: 80%;" />
                                                    </td>
                                                    <td>
                                                        <ul class="graphic">
                                                            <li><a id="A2" runat="server" title="Play" class="sm2_link"></a></li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6EnglishPE" runat="server"
                                                ForeColor="Red" ValidationGroup="chk9420" ControlToValidate="flSoundPE"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>English (*.wav):</strong>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td width="80%">
                                                        <asp:FileUpload ID="flSoundPE" onchange="fileTypeCheckengE(this.value);" runat="server"
                                                            Style="width: 80%;" />
                                                    </td>
                                                    <td>
                                                        <ul class="graphic">
                                                            <li><a id="A3" runat="server" title="Play" class="sm2_link"></a></li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                        </td>
                                        <td>
                                            <asp:Label ID="L2" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td align="right">
                                        </td>
                                        <td>
                                            <asp:Label ID="L1" runat="server" Text="" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <%-------------------------Save Reset Button-----------------%>
                            <table width="100%" cellpadding="0" cellspacing="0" class="tab_regis" style="margin-top: 0px;
                                margin-bottom: 0px;">
                                <tr>
                                    <td style="padding-right: 10px; padding-top: 15px;" align="right">
                                        <asp:Button ID="btnSaveDemo" OnClick="btnSaveDemo_Click" ValidationGroup="chk9420"
                                            CssClass="button_all" runat="server" Text="Save" />
                                        <asp:Button ID="btnResetDemo" OnClick="btnResetDemo_Click" CssClass="button_all"
                                            runat="server" Text="Reset" Visible="false" />
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" class="tab_regis" style="margin-top: 0px;
                                margin-bottom: 0px; margin: 0px 0px 0px 15px;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblnotefile" Style="font-family: Arial; font-size: 12px; color: red;"
                                            runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblformatfile" Style="font-family: Arial; font-size: 12px; color: red;"
                                            runat="server" Text="Type -- *.wav, Format -- 8KHz, 16bit mono, Bit Rate -- 128 kbps"></asp:Label>
                                        <br />
                                        <asp:Label ID="Label1" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                            runat="server" Text="For record the audio file, Please click the link "></asp:Label>
                                        &nbsp; <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                            color: Blue;" target="_blank">Click</a><br />
                                        <asp:Label ID="Label2" Style="font-family: Arial; font-size: 12px; color: red;" runat="server"
                                            Text="Company Audio -- Please kindly upload your company name sound file as you would
                                                    like to play to consumers"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <cc1:MaskedEditExtender ID="MaskedEdbdfitddExtenderdatefrom" runat="server" TargetControlID="txtMfd_Date"
                        Mask="99/99/9999" MaskType="Date">
                    </cc1:MaskedEditExtender>
                    <cc1:MaskedEditExtender ID="MaskedEditExtenderforexpdate1" runat="server" TargetControlID="txtExp_Date"
                        Mask="99/99/9999" MaskType="Date">
                    </cc1:MaskedEditExtender>
                    <cc1:CalendarExtender ID="cldmfddate" TargetControlID="txtMfd_Date" runat="server"
                        Format="dd/MM/yyyy">
                    </cc1:CalendarExtender>
                    <cc1:CalendarExtender ID="cldexpdate" TargetControlID="txtExp_Date" runat="server"
                        Format="dd/MM/yyyy">
                    </cc1:CalendarExtender>
                </div>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Panel ID="PanelUploadDoc" runat="server" Width="35%">
                                <div class="popupContent" style="width: 100%;">
                                    <div class="pop_log_bg">
                                        <div>
                                            <asp:Button ID="Btnuploadclose" CssClass="popupClose" runat="server" /></div>
                                        <div class="service_head_p">
                                            <p>
                                                <strong style="font-size: 14px; font-weight: bold;"><span class="left">
                                                    <asp:Label ID="Labeluploadhead" runat="server" Text="Upload Document"></asp:Label>
                                                </span></strong>
                                            </p>
                                        </div>
                                        <div class="regis_popup">
                                            <fieldset class="Newfield Newfield_width2">
                                                <legend>Document Info.</legend>
                                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                    <tr style="height: 27px;">
                                                        <td align="right" style="width: 35%;">
                                                            <span style="font-family: @Arial Unicode MS; font-size: 12px; color: Black; font-weight: normal;">
                                                                <strong><span class="astrics">*</span> Company Info. : &nbsp;&nbsp;</strong>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                                    ValidationGroup="chkup" ControlToValidate="txtcompinfo"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                        <td align="left" style="width: 64%;">
                                                            <asp:TextBox ID="txtcompinfo" runat="server" CssClass="textbox_pop"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 27px;">
                                                        <td align="right">
                                                            <span style="font-family: @Arial Unicode MS; font-size: 12px; color: Black; font-weight: normal;">
                                                                <strong><span class="astrics">*</span> PAN /TAN No. : &nbsp;&nbsp;</strong>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                                    ValidationGroup="chkup" ControlToValidate="txtpantanno"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ValidationGroup="chkup" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}"
                                                                    ControlToValidate="txtpantanno" ID="RegularExpressionValidator4" runat="server"
                                                                    ErrorMessage="Invalid ex:ABCDE1234F" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtenderPan" runat="server" TargetControlID="RegularExpressionValidator4">
                                                                </cc1:ValidatorCalloutExtender>
                                                            </span>
                                                        </td>
                                                        <td align="left" style="width: 59%;">
                                                            <asp:TextBox ID="txtpantanno" runat="server" CssClass="textbox_pop"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 27px;">
                                                        <td align="right">
                                                            <span style="font-family: @Arial Unicode MS; font-size: 12px; color: Black; font-weight: normal;">
                                                                <strong><span class="astrics">*</span> VAT No. : &nbsp;&nbsp;</strong>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                                    ValidationGroup="chkup" ControlToValidate="txtvat"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                        <td align="left" style="width: 59%;">
                                                            <asp:TextBox ID="txtvat" runat="server" CssClass="textbox_pop"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 27px;">
                                                        <td align="right">
                                                            <span style="font-family: @Arial Unicode MS; font-size: 12px; color: Black; font-weight: normal;">
                                                                <strong><span class="astrics">*</span> Address Pfroof : &nbsp;&nbsp;</strong>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                                    ValidationGroup="chkup" ControlToValidate="FileUploadaddpfrrof"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                        <td align="left">
                                                            <asp:FileUpload ID="FileUploadaddpfrrof" runat="server" CssClass="textbox_pop" onchange="fileTypeCheckFiles(this.value);">
                                                            </asp:FileUpload>
                                                            <asp:Label ID="llvl" runat="server" CssClass="astrics"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 27px;">
                                                        <td align="right">
                                                            <span style="font-family: @Arial Unicode MS; font-size: 12px; color: Black; font-weight: normal;">
                                                                <strong><span class="astrics">*</span> Owner/Director Pfroof : &nbsp;&nbsp;</strong>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                                    ValidationGroup="chkup" ControlToValidate="FileUploadowner"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </td>
                                                        <td align="left">
                                                            <asp:FileUpload ID="FileUploadowner" runat="server" CssClass="textbox_pop" onchange="fileTypeCheckFiles0(this.value);">
                                                            </asp:FileUpload>
                                                            <asp:Label ID="llvl0" runat="server" CssClass="astrics"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 27px;">
                                                        <td align="right">
                                                            <strong><span class="astrics">*</span> Signature : &nbsp;&nbsp;</strong>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                                ValidationGroup="chkup" ControlToValidate="FileUploadsignature"></asp:RequiredFieldValidator>
                                                        </td>
                                                        <td align="left">
                                                            <asp:FileUpload ID="FileUploadsignature" runat="server" CssClass="textbox_pop" onchange="fileTypeCheckFiles1(this.value);">
                                                            </asp:FileUpload>
                                                            <asp:Label ID="llvl1" runat="server" CssClass="astrics"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="height: 35px;">
                                                        <td align="right">
                                                        </td>
                                                        <td align="right" style="padding-right: 40px;">
                                                            <asp:Button ID="btnUploadDoc" runat="server" CssClass="button_all" Text="Upload Document"
                                                                OnClick="btnUploadDoc_Click" ValidationGroup="chkup"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                            <cc1:ModalPopupExtender ID="ModalPopupExtenderUpload" runat="server" PopupControlID="PanelUploadDoc"
                                TargetControlID="LabelUpload" CancelControlID="Btnuploadclose" BackgroundCssClass="NewmodalBackground">
                            </cc1:ModalPopupExtender>
                            <asp:Label ID="LabelUpload" runat="server"></asp:Label>
                            <!--===============================PopUp Alert Starts===============================-->
                            <asp:Panel ID="PanelAlert" runat="server" Width="20%">
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
                                            <div id="infobtn" runat="server" visible="false">
                                                <%--<asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                            <!--===============================Popup Close================================-->
                            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="Label13" runat="server"
                                Visible="false"></asp:Label>
                            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
                            </cc1:ModalPopupExtender>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSaveDemo" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
