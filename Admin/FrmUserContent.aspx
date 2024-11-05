<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" Title="Content Master"
    CodeFile="FrmUserContent.aspx.cs" Inherits="FrmUserContent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(51).addClass("active");
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.... </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="user_content">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Content Master
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="divmsg" runat="server">
                <p>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </p>
            </div>
            <table cellspacing="2" cellpadding="0" class="tab">
                <tr>
                    <td>
                        <strong>Menu Heading : </strong>
                    </td>
                    <td width="88%">
                        <asp:DropDownList ID="ddlMenuHeading" runat="server" OnSelectedIndexChanged="ddlMenuHeading_SelectedIndexChanged"
                            AutoPostBack="true">
                            <asp:ListItem Value="1">About Us</asp:ListItem>
                            <asp:ListItem Value="2">Concept of 9420</asp:ListItem>
                            <asp:ListItem Value="3">Manufacturer</asp:ListItem>
                            <asp:ListItem Value="4">Consumer</asp:ListItem>
                            <asp:ListItem Value="5">Advantages</asp:ListItem>
                            <asp:ListItem Value="6">Contact Us</asp:ListItem>
                        </asp:DropDownList>
                        </br>
                    </td>
                </tr>
                <tr>
                    <td valign="top" align="left">
                        <strong>Content : </strong>
                    </td>
                    <td>
                        <cc2:Editor ID="Editor1" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Editor1"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblid" runat="server" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="left">
                        <asp:Button ID="btnsave" Text="Update" runat="server" CssClass="button_all" OnClick="btnsave_Click" />
                        <asp:Button ID="btncancel" Text="Reset" runat="server" CssClass="button_all" CausesValidation="False"
                            OnClick="btncancel_Click" />
                        <asp:Label ID="lblmdg" runat="server" ForeColor="#FF3300"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
