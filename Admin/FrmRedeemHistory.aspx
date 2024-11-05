<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmRedeemHistory.aspx.cs" Inherits="Admin_FrmRedeemHistory" Title="Awards Redeem History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(30).addClass("active");
            $(".accordion2 div.open").eq(23).show();

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
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="redeem_history">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Redeem History
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ImageUrl="~/Content/images/add_new.png" runat="server"
                                    ToolTip="Create New Label" Visible="false" style="display:none;" /><%--OnClick="imgNew_Click"--%>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server" style="width: 91%;">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="ImgSearch">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <asp:Panel ID="DefaultButtonPanel" DefaultButton="ImgSearch" runat="server">
                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                            <tr>
                                
                                <td align="justify" style="width: 25%;" >
                                <asp:DropDownList ID="ddlComp" runat="server" CssClass="reg_txt" AutoPostBack="true" OnSelectedIndexChanged="ddlComp_SelectedIndexChanged" ></asp:DropDownList>
                                    <asp:TextBox ID="txtSerCompName" runat="server" CssClass="reg_txt" placeholder="Company Name" style="display:none;"></asp:TextBox>
                                </td>
                                <td align="justify" style="width: 15%;">
                                    <asp:TextBox ID="txtSearchName" runat="server" CssClass="reg_txt" placeholder="Reward Name"></asp:TextBox>
                                </td>
                                <td align="right" width="15%">
                                    <asp:TextBox ID="txtrewardkey" runat="server" CssClass="reg_txt" placeholder="Reward Key" MaxLength="10" OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>
                                </td>
                                <td align="right" width="15%">
                                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="textbox_pop" >
                                    <asp:ListItem Value="SE" >--Select--</asp:ListItem>
                                    <asp:ListItem Value="PE" >Pending</asp:ListItem>
                                    <asp:ListItem Value="DI" >Dispatch</asp:ListItem>
                                    <asp:ListItem Value="DE" >Received</asp:ListItem>
                                    <asp:ListItem Value="WA" >In Wallet</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td align="justify" width="15%">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            OnClick="ImgSearch_Click" ToolTip="Search" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                                    </div>
                                </td>
                                <td align="right" width="13%" style="visibility: hidden;">
                                    <strong>Product Name :</strong>
                                </td>
                                <td width="20%" style="visibility: hidden;">
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
                            <td align="right" style="padding-right: 5px;">
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
                <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    DataKeyNames="IsDispatch,IsDelivered,Delivery_Type" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdLabel_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdLabel_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Entry Date">
                            <ItemTemplate>
                                <asp:Label ID="lblentrydate" runat="server" Text='<%# Bind("Entry_Date") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Redemption_Key">
                            <ItemTemplate>
                                <asp:Label ID="lblawardskey" runat="server" Text='<%# Bind("Award_Key") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Award Name">
                            <ItemTemplate>
                                <asp:Label ID="lblawardname" runat="server" Text='<%# Bind("AwardName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Points">
                            <ItemTemplate>
                                <asp:Label ID="lblredeempoints" runat="server" Text='<%# Bind("Cash_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Status">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        DeliveryType = GrdLabel.DataKeys[index].Values["Delivery_Type"].ToString();
                                        IDisp = Convert.ToInt32(GrdLabel.DataKeys[index].Values["IsDispatch"].ToString());
                                        IDel = Convert.ToInt32(GrdLabel.DataKeys[index].Values["IsDelivered"].ToString());
                                    }
                                    catch { }
                                    string MyStr = "";
                                    if (DeliveryType != "Cash")
                                    {
                                        if (DeliveryType == "Courier")
                                        {
                                            if (IDisp == 0)
                                                MyStr = "Pending";
                                            else
                                            {
                                                if (IDel == 0)
                                                    MyStr = "Dispatch";
                                                else
                                                    MyStr = "Received";
                                            }
                                        }
                                        else
                                        {
                                            if (IDel == 0)
                                                MyStr = "Dispatch";
                                            else
                                                MyStr = "Received";
                                        }
                                    }
                                    else
                                        MyStr = "In Wallet";
                                %>
                                <span >
                                    <%=MyStr%></span>
                                <%index++; %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivery">
                            <ItemTemplate>
                                <asp:Label ID="lbldelmode" runat="server" Text='<%# Bind("Delivery_Type") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
            </div>
        </ContentTemplate>
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="btnSave" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
