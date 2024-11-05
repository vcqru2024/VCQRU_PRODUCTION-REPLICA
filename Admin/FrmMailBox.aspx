<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="FrmMailBox.aspx.cs" Inherits="Admin_FrmMailBox" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function checkAll(frm, mode) {
            var i = 0;
            for (; i < frm.elements.length; i++)
                if (frm.elements[i].type == "checkbox")
                    frm.elements[i].checked = mode;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;z-index:1000" class="modalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../images/icons/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div id="content" style="width: 98%">
                <div class="pin" style="width: 90%;">
                    <div class="detail_heading" style="width: 100%">
                        <p>
                            Mail Box
                            <asp:Label ID="lblMailMsg" runat="server" Text="" ForeColor="Red"></asp:Label></p>
                    </div>
                    <cc1:TabContainer ID="TabContainer1" runat="server">
                        <cc1:TabPanel ID="TabPanel1" runat="server">
                            <HeaderTemplate>
                                Compose Mail
                            </HeaderTemplate>
                            <ContentTemplate>
                                <table cellspacing="2" cellpadding="0" class="tab">
                                    <tr>
                                        <td align="right">
                                            To :
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlSendTo" CssClass="txt_box" runat="server" Width="260px">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="--Select--" ValidationGroup="MailB" ControlToValidate="ddlSendTo"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Subject :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSubject" runat="server" CssClass="txt_box" Width="260px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                ValidationGroup="MailB" ControlToValidate="txtSubject"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" valign="top" width="10%">
                                            Message :
                                        </td>
                                        <td colspan="3" width="80%">
                                            <cc2:Editor ID="Editor1" runat="server" Width="90%" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                ValidationGroup="MailB" ControlToValidate="Editor1"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:ImageButton ID="imgbtnSendMail" runat="server" ValidationGroup="MailB" ImageUrl="~/images/send.png"
                                                OnClick="imgbtnSendMail_Click" />
                                            <asp:ImageButton ID="imgBtnReset" runat="server" CausesValidation="false" ImageUrl="~/images/Button/reset.png"
                                                OnClick="imgBtnReset_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </cc1:TabPanel>
                        <cc1:TabPanel ID="TabPanel2" runat="server">
                            <HeaderTemplate>
                                Inbox
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div style="margin-left: 90px;">
                                    <asp:ImageButton ID="ImgBtnDeleteInMail" runat="server" ImageUrl="~/images/Button/delete.png" OnClick="ImgBtnDeleteInMail_Click" /></div>
                                <div class="member11">
                                    <asp:GridView ID="GridViewInbox" runat="server" CssClass="table" EnableModelValidation="True"
                                        DataKeyNames="Read_flg" CellPadding="0" AutoGenerateColumns="False" BorderStyle="None"
                                        AllowPaging="True" PageSize="20" Width="80%" OnRowCommand="GridViewInbox_RowCommand" OnPageIndexChanging="GridViewInbox_PageIndexChanging">
                                        <PagerStyle HorizontalAlign="Center" />
                                        <AlternatingRowStyle CssClass="tr2" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                <HeaderTemplate>
                                                    <input id="chkselecth1" name="chkselecth1" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <input id="chkInselect" name="chkInselect" type="checkbox" value='<%# Eval("tbl_id") %>' />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle CssClass="tt_lft" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Subject" HeaderText="Subject" ItemStyle-HorizontalAlign="Left">
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle CssClass="tt_lft" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Send_date" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Date">
                                                <HeaderStyle CssClass="tr" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:ImageButton ToolTip="View/Reply" ID="imgbtnedit" runat="server" CausesValidation="false"
                                                        ImageUrl="~/images/mail_reply.png" CommandArgument='<%# Bind("tbl_id") %>' CommandName="Reply" />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="tr1" />
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                        </cc1:TabPanel>
                        <cc1:TabPanel ID="TabPanel3" runat="server">
                            <HeaderTemplate>
                                OutBox
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div style="margin-left: 90px;">
                                    <asp:ImageButton ID="ImgBtnDeleteOutMail" runat="server" ImageUrl="~/images/Button/delete.png" OnClick="ImgBtnDeleteOutMail_Click" /></div>
                                <div class="member11">
                                    <asp:GridView ID="GridViewOutBox" runat="server" CssClass="table" EnableModelValidation="True"
                                        DataKeyNames="Read_flg" CellPadding="0" AutoGenerateColumns="False" BorderStyle="None"
                                        AllowPaging="True" PageSize="20" Width="80%" OnRowCommand="GridViewOutBox_RowCommand" OnPageIndexChanging="GridViewOutBox_PageIndexChanging">
                                        <PagerStyle HorizontalAlign="Center" />
                                        <AlternatingRowStyle CssClass="tr2" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                <HeaderTemplate>
                                                    <input id="chkselecth2" name="chkselecth2" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <input id="chkOutselect" name="chkOutselect" type="checkbox" value='<%# Eval("tbl_id") %>' />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle CssClass="tt_lft" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Subject" HeaderText="Subject" ItemStyle-HorizontalAlign="Left">
                                                <HeaderStyle CssClass="tr" />
                                                <ItemStyle CssClass="tt_lft" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Send_date" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Date">
                                                <HeaderStyle CssClass="tr" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:ImageButton ToolTip="View" ID="imgbtnedit" runat="server" CausesValidation="false"
                                                        ImageUrl="~/images/mail_reply.png" CommandArgument='<%# Bind("tbl_id") %>' CommandName="Reply" />
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="tr1" />
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                        </cc1:TabPanel>
                    </cc1:TabContainer>
                </div>
            </div>
            <asp:Panel ID="Panel1" runat="server" BackColor="#FFFFFF" Width="400px">
                <div class="registration" style="width:400px">
                    <div class="close">
                        <asp:ImageButton ID="ImageButton2" CausesValidation="false" ImageUrl="~/images/Button/close.png"
                            runat="server" />
                    </div>
                    <div class="detail_heading">
                        <p>
                            View/Reply</p>
                    </div>
                    <fieldset class="field">
                        <legend>Message</legend>
                        <table cellspacing="2" cellpadding="0" class="tab">
                            <tr>
                                <td align="justify" colspan="4">
                                    <asp:Label ID="lblViewMsg" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <fieldset class="field">
                        <legend>Reply</legend>
                        <table cellspacing="2" cellpadding="0" class="tab">
                            <tr>
                                <td align="justify" colspan="4">
                                    <asp:TextBox ID="txtMsgReply" runat="server" TextMode="MultiLine" Height="80px" CssClass="txt_box" Width="98%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtMsgReply" ValidationGroup="RepMail"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <div style="text-align:center">
                        <asp:ImageButton ID="ImgBtnReply" runat="server" ValidationGroup="RepMail" ImageUrl="~/images/send.png" OnClick="ImgBtnReply_Click" />
                        <asp:ImageButton ID="ImgBtnRepReset" runat="server" CausesValidation="false" ImageUrl="~/images/Button/reset.png" OnClick="ImgBtnRepReset_Click" />
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="Panel2" runat="server" BackColor="#FFFFFF" Width="400px">
                <div class="registration" style="width:400px">
                    <div class="close">
                        <asp:ImageButton ID="ImageButton1" CausesValidation="false" ImageUrl="~/images/Button/close.png"
                            runat="server" />
                    </div>
                    <div class="detail_heading">
                        <p>
                            View</p>
                    </div>
                    <fieldset class="field">
                        <legend>Message</legend>
                        <table cellspacing="2" cellpadding="0" class="tab">
                            <tr>
                                <td align="justify" colspan="4">
                                    <asp:Label ID="lblMsgVeiw" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </fieldset>                   
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Label1"
                PopupControlID="Panel1" CancelControlID="ImageButton2"
                BackgroundCssClass="modalBackground">
            </cc1:ModalPopupExtender>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
              <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="Label3"
                PopupControlID="Panel2" CancelControlID="ImageButton1"
                BackgroundCssClass="modalBackground">
            </cc1:ModalPopupExtender>
            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblTblId" runat="server" Text="" Visible="false"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
