<%@ Page Title="Gallary" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmGallary.aspx.cs" Inherits="FrmGallary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(50).addClass("active");
            $(".accordion2 div.open").eq(45).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

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
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="user_album">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Album Master
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
            <fieldset class="Newfield Newfield_width2">
                <legend>Image Info</legend>
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
                            <asp:TextBox ID="txtprdname" Visible="false" runat="server" CssClass="txt_box " MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtprdname"
                                CssClass="ErrorMsg" ErrorMessage="*" ValidationGroup="Reg_Img"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="list" runat="server" style="margin-top: 5px; width: 99%; height: 70px; overflow-x: hidden;
                                overflow-y: visible">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-right: 25px; text-align: right;" colspan="4">
                            <asp:Button ID="imgBtnSubmit" runat="server" Text="Save" CssClass="button_all" ValidationGroup="Reg_Img"
                                OnClick="imgBtnSubmit_Click" />
                            &nbsp;&nbsp;<asp:Button ID="imgBtnReset" runat="server" CausesValidation="false"
                                CssClass="button_all" Text="Reset" OnClick="imgBtnReset_Click" />
                        </td>
                    </tr>
                </table>
            </fieldset>
            <asp:Label ID="lblprdid" runat="server" Text="" Visible="false"></asp:Label>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="imgBtnSubmit" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
