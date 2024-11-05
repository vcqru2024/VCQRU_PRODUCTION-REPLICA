<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Messages.aspx.cs" Inherits="MessagesHello"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="head_cont">
        <h2 class="msg_info">
            <table width="99%">
                <tr>
                    <td width="85%">
                        &nbsp;&nbsp;&nbsp;Message
                    </td>
                    <td align="right">
                    </td>
                </tr>
            </table>
        </h2>
    </div>
    <div style="width: 100%; text-align: center; color: Red;">
        <strong>Your account has been registered as demo user.</strong>
    </div>
</asp:Content>
