<%@ Page Title="Customer Care" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="Customer_Care.aspx.cs" Inherits="Customer_Care" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(25).addClass("active");
            $(".accordion2 div.open").eq(25).show();

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
                        top: 0px; z-index: 999;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="pro_enquery">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Enquiry Details
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="ImgSearch">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                            <tr style="display:none;">
                                <td width="20%" colspan="2">
                                    <asp:DropDownList ID="ddlproname" runat="server" CssClass="reg_txt" />
                                </td>
                                <td width="20%">
                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="20%">
                                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="20%">
                                    <asp:DropDownList ID="ddlMode" runat="server" CssClass="reg_txt">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td width="20%" style="display:none;">
                                    <asp:DropDownList ID="ddlcompname" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlcompname_SelectedIndexChanged" />
                                </td>
                                <td width="20%">
                                    <asp:TextBox ID="txtcode1" MaxLength="5" OnKeyPress="return isNumberKey(this, event);"
                                        runat="server" placeholder="Code1" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="20%">
                                    <asp:TextBox ID="txtcode2" MaxLength="8" OnKeyPress="return isNumberKey(this, event);"
                                        runat="server" placeholder="Code2" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                            OnClick="ImgRefresh_Click" />
                                    </div>
                                </td>
                                <td align="justify" width="20%" style="display: none;">
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="reg_txt">
                                        <asp:ListItem Text="--All--"></asp:ListItem>
                                        <asp:ListItem Text="Success"></asp:ListItem>
                                        <asp:ListItem Text="Unsuccess"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Enquiry From">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                        WatermarkText="Enquiry To">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>
            </asp:Panel>
            <div class="grid_container">
                <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GrdEnquiry" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                    PageSize="25" OnPageIndexChanging="GrdEnquiry_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Enquiry Date">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("EnquiryDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblcompnnname" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Enq. Mode">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("ModeOfInquiry") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Enq. Detail">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes" runat="server" Text='<%# Bind("ContactDetails") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MRP">
                            <ItemTemplate>
                                <asp:Label ID="lblmrp" Style="padding-left: 10px;" CssClass="txt_rupees rupees" runat="server"
                                    Text='<%# Bind("MRP") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Exp.Date">
                            <ItemTemplate>
                                <asp:Label ID="lblexpdt" runat="server" Text='<%# Bind("Exp_Date","{0:MMM dd yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mfd.Date">
                            <ItemTemplate>
                                <asp:Label ID="lblmfgdt" runat="server" Text='<%# Bind("Mfd_Date","{0:MMM dd yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code 1">
                            <ItemTemplate>
                                <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("Received_Code1") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code 2">
                            <ItemTemplate>
                                <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%# Bind("Received_Code2") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Bind("Successstatus") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40%" />
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
