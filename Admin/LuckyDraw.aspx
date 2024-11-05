<%@ Page Title="Lucky Draw" Language="C#" MasterPageFile="~/Admin/MasterPage.master"
    AutoEventWireup="true" CodeFile="LuckyDraw.aspx.cs" Inherits="LuckyDraw" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(22).addClass("active");
            $(".accordion2 div.open").eq(21).show();

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
                                Lucky Draw Master
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
                    DataKeyNames="Draw,IsDraw" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdVw_PageIndexChanging"
                    OnRowCommand="GrdVw_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%=++c %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name [Service Name]">
                            <ItemTemplate>
                                <asp:Label ID="lblproname" Font-Bold="true" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>&nbsp;[<asp:Label
                                    ID="lbladdsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>]
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DateFrom">
                            <ItemTemplate>
                                <asp:Label ID="lblsstdtfrom" runat="server" Text='<%# Bind("DateFrom","{0:MMM d, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DateTo">
                            <ItemTemplate>
                                <asp:Label ID="lblsstdtto" runat="server" Text='<%# Bind("DateTo","{0:MMM d, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Paricipants">
                            <ItemTemplate>
                                <asp:Label ID="lbltoatalparici" runat="server" Text='<%# Convert.ToInt32(Eval("TParicipants")) == 0 ? "-- --" : Eval("TParicipants")  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7%" />
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Winners">
                            <ItemTemplate>
                                <asp:Label ID="lblsetparti" runat="server" Text='<%# Convert.ToInt32(Eval("WinningCodes")) == 0 ? "-- --" : Eval("WinningCodes")  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7%" />
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Draw Date">
                            <ItemTemplate>
                            <%
                                    try {                                        
                                        dts = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsDraw"].ToString());
                                    }
                                    catch
                                    {
                                    }
                                    if (dts == 0)
                                    {%>
                                -- --
                                <%}
                                    else
                                    { %>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("DrawDate","{0:MMM d, yyyy}") %>'></asp:Label>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText=" ">
                            <ItemTemplate>
                            <%
                                    try {
                                        IsActive = Convert.ToInt32(GrdVw.DataKeys[index].Values["Draw"].ToString());
                                        IsDraw = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsDraw"].ToString());
                                    }
                                    catch
                                    {
                                    }
                                     %>
                                     <%if (IsActive == 1)
                                       {
                                           if (IsDraw == 0)
                                           { %>
                                                <asp:Button ID="Imgbtndraw" runat="server" CommandArgument='<%# Bind("SST_Id") %>' CausesValidation="false" CommandName="DrawRewards"
                                                ToolTip="Draw Rewards" Text="Draw" CssClass="redeem" />&nbsp;
                                            <%}
                                           else
                                           { %>
                                           <asp:Label ID="lbldrwlbl" Text="Draw" runat="server" ForeColor="Green" ></asp:Label>
                                            <%}
                                       }
                                       else
                                       {%>
                                       <asp:Button ID="Imgbtndrawdis" runat="server" CommandArgument='<%# Bind("SST_Id") %>' CausesValidation="false" CommandName="DrawRewards" Enabled="false"
                                        ToolTip='<%# Bind("DateTo","Draw Rewards on After {0}") %>' Text="Draw" CssClass="redeem_sec" />&nbsp;
                                     <%} %>
                                     <%index++; %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
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
