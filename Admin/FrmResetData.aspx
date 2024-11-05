<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmResetData.aspx.cs" Inherits="FrmResetData" Title="Reset Database" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(61).addClass("active");
            $(".accordion2 div.open").eq(61).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .style1
        {
            height: 29px;
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
                        z-index: 10000; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="regd_comp_code">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Reset Database
                            </td>
                            <td align="justify">
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </p>
            </div>
            <div class="grid_container" style="border: none;">
                <asp:Panel ID="PnlUpdateCompanyDetail" runat="server" Width="100%" DefaultButton="btnReset">
                    <div style="width: 100%;">
                        <div>
                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                <tr>
                                    <td>
                                        <strong>Company Name : </strong>
                                        <asp:DropDownList ID="ddlComp_Id" CssClass="drp" runat="server" Width="33%">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:CheckBox ID="chk1" runat="server" AutoPostBack="true" OnCheckedChanged="chkall_CheckedChanged" />
                                        <strong>Remove All </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                       
                                        <asp:CheckBox ID="chk7" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Reset Code Bank </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:CheckBox ID="chk9" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Reset All Invoice</strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:CheckBox ID="chk4" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove Print Code</strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:CheckBox ID="chk5" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove Allocate Code </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">                                       
                                        <asp:CheckBox ID="chk3" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove Products </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                        
                                        <asp:CheckBox ID="chk6" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove Company </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">                                        
                                        <asp:CheckBox ID="chk8" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove Enquiry </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>                                       
                                        <asp:CheckBox ID="chk2" runat="server" AutoPostBack="true" OnCheckedChanged="chk1_CheckedChanged" />
                                        <strong>Remove News </strong>
                                    </td>
                                </tr>
                            </table>
                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis" style="padding-left: 15px;">
                                <tr>
                                    <td align="right" style="padding-right: 30px;">
                                        <asp:Button ID="btnReset" OnClick="btnReset_Click" ValidationGroup="chk94" CssClass="button_all"
                                            runat="server" Text="Reset" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label6" runat="server"></asp:Label>
                <asp:Label ID="lblCompId123" runat="server" Visible="false"></asp:Label>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
