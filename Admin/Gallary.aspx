<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="Gallary.aspx.cs" Inherits="Admin_ProductMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="Stylesheet" type="text/css" href="../Upload/uploader.css" />
    <script language="javascript" type="text/javascript" src="../Upload/uplodare.js"></script>
    <script language="javascript" type="text/javascript"></script> 
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
                            <span style="color: White">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="admin_cont">
                <div class="detail_heading33">
                    <table width="100%">
                        <tr>
                            <td>
                                <p>
                                    Album Master <span><%--(<asp:Label ID="lblcnt" runat="server" Text=""></asp:Label>
                                        Album Found)--%></span></p>
                            </td>
                            <td align="center">
                                <p>
                                    <span>
                                        <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                                    </span>
                                </p>
                            </td>
                            <td style="text-align: right;">
                                <%--<asp:ImageButton ID="ImageButton1" ImageUrl="../images/Button/document-new.png" runat="server"
                                    OnClick="ImageButton1_Click" ToolTip="Add New" />
                                &nbsp;
                                <asp:DropDownList CssClass="ddlpaging" Width="70px" AutoPostBack="true" ID="ddlpagesize"
                                    runat="server" OnSelectedIndexChanged="ddlpagesize_SelectedIndexChanged">
                                    <asp:ListItem Value="30"> 30 Rows</asp:ListItem>
                                    <asp:ListItem Value="50"> 50 Rows</asp:ListItem>
                                    <asp:ListItem Value="100"> 100 Rows</asp:ListItem>
                                    <asp:ListItem Value="500"> 500 Rows</asp:ListItem>
                                    <asp:ListItem Value="1000"> 1000 Rows</asp:ListItem>
                                </asp:DropDownList>--%>
                            </td>
                        </tr>
                    </table>
                </div>
               <%-- <fieldset class="field">
                    <legend><strong>Search Criteria</strong></legend>
                    <asp:Panel ID="pnlse" runat="server" DefaultButton="imgbtnsearch">
                        <table width="100%" style="margin-bottom: 8px;">
                            <tr>
                                <td valign="top" width="36%" align="right">
                                    &nbsp;
                                    <asp:TextBox ID="txtSearchProName" runat="server" placeholder="Album Name" CssClass="txt_box"></asp:TextBox>&nbsp;
                                </td>
                                <td align="left">
                                    <asp:ImageButton ID="imgBtnSearch" runat="server" ImageUrl="~/images/Button/go.png"
                                        OnClick="imgBtnSearch_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>--%>
                <center>
                    <%--<div style="height: 5px; width: 100%;">
        </div>--%>
                  <%--  <div style="width: 100%;">
                        <asp:Label ID="lblrow_id" runat="server" Visible="false" Text=""></asp:Label>
                        <center>
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" Width="40%" CssClass="table"
                                AutoGenerateColumns="False" EmptyDataText="Record Not Found" BorderStyle="None"
                                EmptyDataRowStyle-HorizontalAlign="Center" OnPageIndexChanging="GridView1_PageIndexChanging"
                                OnRowCommand="GridView1_RowCommand">
                                <PagerSettings Mode="Numeric" />
                                <PagerStyle CssClass="tr" HorizontalAlign="Center" ForeColor="white" />
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%=++sr %>
                                        </ItemTemplate>
                                        <ItemStyle Width="30px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="&nbsp;&nbsp;Album Name" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Album_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" />
                                        <ItemStyle CssClass="tt_lft" HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Image">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btimg" ImageUrl='<%#Bind("image_name") %>' Width="30px" Height="30px"
                                                runat="server" /></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImgEdit" runat="server" ImageUrl="../images/Button/019.png"
                                                CommandArgument='<%# Bind("Album_Id")%>' CommandName="RegEdit" />
                                            &nbsp;<asp:ImageButton ID="ImgDelete" runat="server" ImageUrl="../images/Button/101.png"
                                                CommandArgument='<%# Bind("Album_Id")%>' CommandName="RegDelete" OnClientClick="return confirm('Are you sure you want to Delete?')" />
                                        </ItemTemplate>
                                        <ItemStyle Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle CssClass="tr2" />
                                <HeaderStyle CssClass="tr" />
                                <RowStyle CssClass="tr1" />
                                <FooterStyle />
                            </asp:GridView>
                        </center>
                    </div>--%>
                </center>
                <asp:Panel ID="Panel1" runat="server" BackColor="#FFFFFF">
                    <div class="registration">
                      <%--  <div class="close">
                            <asp:ImageButton ID="ImageButton2" CausesValidation="false" ImageUrl="../images/Button/close.png"
                                runat="server" />
                        </div>--%>
                        <div class="detail_heading">
                            <p>
                               
                                <asp:Label ID="LblmsgHead" ForeColor="Red" Font-Size="11px" runat="server"></asp:Label></p>
                        </div>
                        <table width="100%">
                            <tr>
                               
                                <td align="right" width="15%">
                                    <b>Image : </b>
                                </td>
                                <td width="35%">
                                    <p id="upload-area">
                                        <asp:FileUpload ID="files" runat="server" Width="160" CssClass="txt_box " onchange="handleFileSelect(event)" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                            CssClass="ErrorMsg" ControlToValidate="files" ValidationGroup="Reg_Img"></asp:RequiredFieldValidator></p>
                                </td>
                                 <td align="right" width="15%">
                                    <b></b>
                                </td>
                                <td width="35%">
                                  <asp:TextBox ID="txtprdname" Visible = "false" runat="server" CssClass="txt_box " MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtprdname"
                                        CssClass="ErrorMsg" ErrorMessage="*" ValidationGroup="Reg_Img"></asp:RequiredFieldValidator>
                                </td>
                                
                                
                                
                                
                            </tr>
                        
                            <tr>                                
                                <td colspan="4">
                                    <div id="list" runat="server" style="margin-top: 5px; width: 99%; height: 70px; overflow-x: hidden; overflow-y: visible">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-right: 25px; text-align: right;" colspan="4">
                                    <asp:ImageButton ID="imgBtnSubmit" runat="server" ImageUrl="../images/Button/save.png"
                                        ValidationGroup="Reg_Img" OnClick="imgBtnSubmit_Click" />
                                    &nbsp;&nbsp;<asp:ImageButton ID="imgBtnReset" runat="server" CausesValidation="false"
                                        ImageUrl="../images/Button/reset.png" OnClick="imgBtnReset_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <asp:Label ID="lblprdid" runat="server" Text="" Visible="false"></asp:Label>
               <%-- <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" CancelControlID="ImageButton2"
                    TargetControlID="Label4" PopupControlID="Panel1" BackgroundCssClass="modalBackground">
                </cc1:ModalPopupExtender>--%>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="imgBtnSubmit" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
