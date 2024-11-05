<%@ Page Title="Cash Transfer Details" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
    AutoEventWireup="true" CodeFile="FrmCashTransfer.aspx.cs" Inherits="FrmCashTransfer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(23).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" language="javascript">
        function checkAll(frm, mode) {
            var i = 0;
            for (; i < frm.elements.length; i++)
                if (frm.elements[i].type == "checkbox")
                frm.elements[i].checked = mode;
        }
    </script>

    <style>
        .redeem
        {
            border-radius: 16px;
            font-size: 12px;
            padding: 2px 5px 2px 5px;
            background-color: #110017;
            color: white;
            cursor: pointer;
        }
        .redeem_sec
        {
            border-radius: 16px;
            font-size: 12px;
            padding: 2px 5px 2px 5px;
            background-color: #767377;
            color: white;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div style="position: absolute; left: 0; height: 1500px; width: 100%; top: 0px; text-align: center;
                        z-index: 100001;" class="NewmodalBackground">
                        <div style="margin-top: 300px; text-align: center;">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="license_code">
                    <table width="99%">
                        <tr>
                            <td style="width: 20%;">
                                Cash Transfer Details
                            </td>
                            <td style="width: 65%;">
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Print label" ImageUrl="~/Content/images/add_new.png"
                                    Visible="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="BigpopMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearch">
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label2" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 20%;">
                                <asp:DropDownList ID="ddlComp_Id" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlComp_Id_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="justify" style="width: 20%;">
                                <asp:DropDownList ID="ddlPro_ID" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlPro_ID_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="justify">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="BtnSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="BtnSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="BtnRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="BtnRefesh_Click" ToolTip="Reset" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>
            <div class="grid_container">
                <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 6%;" align="center">
                                <input type="hidden" runat="server" id="hidden1" />
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                <asp:Label ID="lblGridHeaderTextLicence" runat="server" Text="Record(s) found"></asp:Label>
                                <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right">
                                <asp:Label ID="lbltotalLicence" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td style="width: 13%;" align="center">
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
                <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdVw_PageIndexChanging"  >
                    <Columns>
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%=++c %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Product Name [Service Name]">
                            <ItemTemplate>
                                <asp:Label ID="lblproname" Font-Bold="true" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>&nbsp;[<asp:Label
                                    ID="lbladdsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>]
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lbluseproduct" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile No">
                            <ItemTemplate>
                                <asp:Label ID="lblcusmobileno" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Transfer Date">
                            <ItemTemplate>
                                <asp:Label ID="lblsstdtfrom" runat="server" Text='<%# Bind("Entry_Date","{0:MMM d, yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="DateTo">     
                            <ItemTemplate>
                                <asp:Label ID="lblsstdtto" runat="server" Text='<%# Bind("DateTo","{0:MMM d, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Amount In(Rs.)">
                            <ItemTemplate>
                                <asp:Label ID="lbltoatalparici" runat="server" Text='<%# Bind("IsCash") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7%" />
                        </asp:TemplateField>                                                                                                
                    </Columns>
                    <EmptyDataRowStyle HorizontalAlign="Center" />
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
