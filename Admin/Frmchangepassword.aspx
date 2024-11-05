<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
    AutoEventWireup="true" CodeFile="Frmchangepassword.aspx.cs" Inherits="Frmchangepassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(57).addClass("active");
            $(".accordion2 div.open").eq(45).show();

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
                <h2 class="change_pass">
                    <table width="99%">
                        <tr>
                            <td width="20%">
                                Change Password
                            </td>
                            <td align="justify" width="65%">
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="btnChangePass">
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td align="right">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorNew3" runat="server" ForeColor="Red"
                                ValidationGroup="PRO" ControlToValidate="txtoldpass"></asp:RequiredFieldValidator>
                            <span class="astrics">*</span> Old Password :
                        </td>
                        <td>
                            <asp:TextBox ID="txtoldpass" MaxLength="50" TextMode="Password" CssClass="reg_txt"
                                Height="17px" runat="server"></asp:TextBox>
                        </td>
                        <td width="30%">
                            <asp:Label ID="LblMsg" runat="server" CssClass="astrics" Font-Size="8pt" Font-Bold="false"
                                Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                ValidationGroup="PRO" ControlToValidate="txtnewpass"></asp:RequiredFieldValidator>
                            <cc1:ValidatorCalloutExtender ID="ValCalloutNewPass" runat="server" TargetControlID="RegExpValNewPass">
                            </cc1:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator Display="None" ValidationGroup="PRO" SetFocusOnError="true"
                                ID="RegExpValNewPass" runat="server" ErrorMessage="Password must be between 4 to 20 character"
                                ControlToValidate="txtnewpass" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{4,20}$" />
                            <span class="astrics">*</span> New Password :
                        </td>
                        <td>
                            <asp:TextBox ID="txtnewpass" MaxLength="20" TextMode="Password" CssClass="reg_txt"
                                runat="server"></asp:TextBox>
                        </td>
                        <td width="50%">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                ValidationGroup="PRO" ControlToValidate="txtreenterpass"></asp:RequiredFieldValidator>
                            <span class="astrics">*</span> Re-enter Password :
                        </td>
                        <td>
                            <asp:TextBox ID="txtreenterpass" MaxLength="50" CssClass="reg_txt" TextMode="Password"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="justify">
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                ControlToCompare="txtnewpass" ControlToValidate="txtreenterpass" ForeColor="Red"
                                Type="String" Operator="Equal" Text="Password not matched"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Button ID="btnChangePass" OnClick="btnChangePassword_Click" ValidationGroup="PRO"
                                CssClass="button_all" runat="server" Text="Save" />
                            <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                Text="Reset" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
