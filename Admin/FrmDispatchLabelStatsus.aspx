<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDispatchLabelStatsus.aspx.cs" Inherits="FrmDispatchLabelStatsus" Title="Pending Dispatch Labels Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(43).addClass("active");
            $(".accordion2 div.open").eq(40).show();

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
                        top: 0px; z-index: 100001;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="print_req">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Pending Dispatch Labels Details
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Product" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" Visible="false" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center;">
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
            </div>
            <div id="NewMsgpop" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label></p>
            </div>
            <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <asp:Panel ID="DefaultButton" runat="server" DefaultButton="ImgSearch">
                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                            <tr>
                                <td align="right">
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txttrachingno" placeholder="Tracking No." runat="server" Text=""
                                        CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="25%">
                                   <asp:DropDownList ID="ddlcompname" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlcompname_SelectedIndexChanged" />
                                </td> 
                                <td width="25%">
                                    <asp:DropDownList ID="ddlProSearch" runat="server" CssClass="reg_txt">
                                    </asp:DropDownList>
                                </td>                               
                                <td>
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                                    </div>                                    
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
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowProductCnt_SelectedIndexChanged">
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
                <asp:HiddenField ID="docflag" runat="server" />
                <asp:GridView ID="GrdVwLabelRequest" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    BorderColor="transparent" AllowPaging="True" PageSize="15" OnRowCommand="GrdVwLabelRequest_RowCommand"
                    OnPageIndexChanging="GrdVwLabelRequest_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Tracking No.">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblTracking" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Request Date">
                            <ItemTemplate>
                                <asp:Label ID="lblreqdate" runat="server" Text='<%# Bind("Entry_Date","{0:dd MMM, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblactudate" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="23%" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Req. Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbldiscrip" runat="server" Text='<%# Bind("TotalCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dispatch Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("DispatchCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pending Dispatch Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lblproprice" runat="server" Text='<%# Bind("PendingDispatchCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Receive Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbllabelsiZe" runat="server" Text='<%# Bind("ReceiveCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                        </asp:TemplateField>                                                                       
                    </Columns>
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
