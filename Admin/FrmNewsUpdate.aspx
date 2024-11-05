<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="New Update" CodeFile="FrmNewsUpdate.aspx.cs" Inherits="FrmNewsUpdate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(49).addClass("active");
            $(".accordion2 div.open").eq(45).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

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
                    <div align="center" style="position: absolute; left: 0; height: 1207px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.... </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="news_panel">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                News Master
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <table cellspacing="2" cellpadding="0" class="regis_popup">
                <div id="divmsg" runat="server">
                    <p>
                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                    </p>
                </div>
                <tr>
                    <td valign="top">
                        <strong>News Heading : </strong>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Editor2"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <strong>News Summary : </strong>
                    </td>
                </tr>
                <tr>
                    <td style="height: 245px;">
                        <Custom:CustomEditor runat="server" ID="Editor2" />
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td valign="top">
                        <cc2:Editor ID="Editor1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="3">
                        <asp:Label ID="lblid" runat="server" Visible="False"></asp:Label>
                        <asp:Button ID="btnsave" Text="Save" runat="server" CssClass="button_all" OnClick="btnsave_Click" />
                        <asp:Button ID="btncancel" Text="Reset" runat="server" CssClass="button_all" OnClick="btncancel_Click"
                            CausesValidation="False" />
                    </td>
                </tr>
            </table>
            <br />
            <div class="grid_container">
                <h4 class="visit_head">
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <input type="hidden" runat="server" id="hidden1" />
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                <asp:Label ID="lblGridHeaderTextLicence" runat="server" Text="Record(s) found"></asp:Label>
                                <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right">
                                <span class="small_font">
                                    <asp:Button ID="ImageButton1" runat="server" Text="Delete" CssClass="button_all"
                                        CausesValidation="false" OnClick="ImageButton1_Click" />
                                    <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are You Sure ? "
                                        TargetControlID="ImageButton1">
                                    </cc1:ConfirmButtonExtender>
                                    <asp:Button ID="ImageButton2" runat="server" Text="Active / DeActive" CssClass="button_all"
                                        CausesValidation="false" OnClick="ImageButton2_Click" />
                                    <asp:Label runat="server" ID="lblConmsg" Text="" ForeColor="Red"></asp:Label></span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowsShow" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GridView1" runat="server" CssClass="grid" EnableModelValidation="True"
                    Width="100%" EmptyDataText="Record Not Found" CellPadding="0" AutoGenerateColumns="False"
                    BorderStyle="None" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                            <HeaderTemplate>
                                <input id="chkselecth" name="chkselecth" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <input id="chkselect" name="chkselect" type="checkbox" value='<%# Eval("tbl_id") %>' />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="Labeldate" runat="server" Text='<%# Bind("Updated_Date") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="17%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Heading">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("News_heading") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="15%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Summary">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("News") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="50%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:LinkButton ID="ImageButton1" runat="server" CausesValidation="false" Text='<%# Bind("Act_Flag") %>'
                                    CommandArgument='<%# Bind("tbl_id") %>' CommandName="ChangeStatus" ToolTip='<%# Bind("Act_Flag") %>' />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="8%" HorizontalAlign="Center" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ToolTip="Edit" ID="imgbtnedit" runat="server" CausesValidation="false"
                                    ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("tbl_id") %>' CommandName="EditRow" />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
