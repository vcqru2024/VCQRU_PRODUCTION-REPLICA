<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="UserContent.aspx.cs" Inherits="Admin_UserContent" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="modalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../images/icons/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.... </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div id="content" style="width: 100%">
                <div class="pin" style="width: 100%;">
                    <div class="detail_heading" style="width: 100%">
                        <p>
                            Content Master</p> &nbsp;
                                
                    </div>
                    <table cellspacing="2" cellpadding="0" class="tab">
                        <tr>
                            <td width="15%">
                                <strong>Menu Heading : </strong>
                            </td>
                            <td width="85%">
                                <asp:DropDownList ID="ddlMenuHeading" runat="server" OnSelectedIndexChanged="ddlMenuHeading_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="1">About Us</asp:ListItem>
                                    <asp:ListItem Value="2">Concept of 9420</asp:ListItem>
                                    <asp:ListItem Value="3">Manufacturer</asp:ListItem>
                                    <asp:ListItem Value="4">Consumer</asp:ListItem>
                                    <asp:ListItem Value="5">Advantages</asp:ListItem>
                                    <asp:ListItem Value="6">Contact Us</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
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
                                <asp:ImageButton ID="btnsave" ImageUrl="~/images/Button/update.png" runat="server"
                                   OnClick="btnsave_Click" />
                                <asp:ImageButton ID="btncancel" ImageUrl="~/images/Button/cancel.png" runat="server"
                                    CausesValidation="False" OnClick="btncancel_Click" />
                                <asp:Label ID="lblmdg" runat="server" ForeColor="#FF3300"></asp:Label>    
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
