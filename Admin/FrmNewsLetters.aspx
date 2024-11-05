<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="E-NewsLetter" CodeFile="FrmNewsLetters.aspx.cs" Inherits="FrmNewsLetters" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(46).addClass("active");
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

   <style type="text/css" >
   .PopupPanel
   {   	
   	position:relative;
   	background-color:White;
   	width: 350px;
    background-color: #f1c40f;
    border-radius: 7px;    
   }
   </style>

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
                                E-Newsletter
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
                    <td>
                        <strong>News Letters : </strong>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="NewsLet"
                            runat="server" ControlToValidate="ddlNewsLetter" InitialValue="--Select News Letters--"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlNewsLetter" runat="server" Width="99%" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlNewsLetter_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <strong>News Subject : </strong>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="NewsLet"
                            runat="server" ControlToValidate="Editor2" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td>
                        <strong>News Content : </strong>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="NewsLet"
                            runat="server" ControlToValidate="Editor1" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="height: 245px;">
                        <Custom:CustomEditor runat="server" ID="Editor2" />
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td valign="top">
                        <cc2:Editor ID="Editor1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="3">
                        <asp:Label ID="lblid" runat="server" Visible="False"></asp:Label>
                        <asp:Button ID="btnsave" Text="Save" runat="server" ValidationGroup="NewsLet" CssClass="button_all"
                            OnClick="btnsave_Click" />
                        <asp:Button ID="btncancel" Text="Reset" runat="server" CssClass="button_all" OnClick="btncancel_Click"
                            CausesValidation="False" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="ImgSearch">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                            <tr>
                                <td width="25%">
                                    <asp:TextBox ID="txtsearchemail" runat="server" CssClass="textbox_pop" placeholder="E-mail ID"></asp:TextBox>
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td align="justify">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            OnClick="ImgSearch_Click" ToolTip="Search" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Date From">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                        WatermarkText="Date To">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>
            </asp:Panel>
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
                    BorderStyle="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Send Date">
                            <ItemTemplate>
                                <asp:Label ID="Labeldate" runat="server" Text='<%# Bind("Entry_Date","{0:MMM dd yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="18%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="E-mail ID">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="20%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Subject">
                            <ItemTemplate>
                                <asp:LinkButton ID="Label1" runat="server" Text='<%# Bind("Subject") %>' style="color:Blue !important;" />
                                <cc1:HoverMenuExtender ID="hme2" runat="Server" TargetControlID="Label1" PopupControlID="PopupMenu"
                                    PopupPosition="Left" OffsetX="450" OffsetY="0" PopDelay="50" HoverCssClass="popupHover" />
                                <asp:Panel ID="PopupMenu" CssClass="PopupPanel" runat="server">     
                                   <strong style="font-size:10pt; color:Black;"> Subject: </strong><asp:Label ID="LblSubjectEmail" runat="server" Text='<%# Bind("Subject") %>' Font-Bold="true" Font-Size="9pt" ></asp:Label>  <br />                             
                                    <strong style="font-size:10pt; color:Black;"> Conntent: </strong><asp:Label ID="LblContentEmail" runat="server" Text='<%# Bind("Content") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle  HorizontalAlign="Justify" CssClass="grd_pad" />
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
