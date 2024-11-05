<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UC_LuckyWinners.ascx.cs" Inherits="UserControl_UC_LuckyWinners" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

 <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(34).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>


<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px; z-index: 999;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
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
                                Lucky Winners Details
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
                            <tr>
                                <td colspan="6"><strong><span class="astrics">*</span> Mandatory to select.</strong></td>
                            </tr>
                            <tr>
                                  <td align="center" width="20%">
                                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="reg_txt" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Visible="true">
                                    </asp:DropDownList>
                                </td>
                                <td width="18%">
                                      <span class="astrics">*</span></strong>
                                    <asp:DropDownList runat="server" CssClass="reg_txt" ID="ddlService" AutoPostBack="false">
                                        <asp:ListItem Selected="True" Value="">Select Service</asp:ListItem>
                                        <asp:ListItem Value="SRV1003">Gift Coupon</asp:ListItem>
                                        <asp:ListItem Value="SRV1006">Raffle Scheme</asp:ListItem>
                                        <%--  <asp:ListItem Text="text1" />
                                    <asp:ListItem Text="text2" />--%>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ControlToValidate="ddlService" runat="server" ValidationGroup="servss" ForeColor="Red"
                                        InitialValue="" />
                                </td>
                              
                                <td width="18%">
                                    <asp:DropDownList ID="ddlproname" runat="server" CssClass="reg_txt" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" />
                                </td>
                                <td width="13%">
                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="reg_txt"></asp:TextBox>
                                </td>
                                <td width="13%">
                                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="reg_txt" Visible="false"></asp:TextBox>
                                </td>
                                <%--<td align="justify" width="15%">
                                    <asp:DropDownList ID="ddlSendSMS" runat="server" CssClass="reg_txt"  Visible="false" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" >
                                        <asp:ListItem Text="--Delivery--"></asp:ListItem>
                                        <asp:ListItem Text="Sent"></asp:ListItem>
                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>--%>
                                <%--  <td width="15%">
                                    <asp:DropDownList ID="ddlDelivery" runat="server" CssClass="reg_txt"  AutoPostBack="true" Visible="false"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" >
                                    <asp:ListItem Text="--SMS--"></asp:ListItem>
                                        <asp:ListItem Text="Delivered"></asp:ListItem>
                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>     --%>
                                <td width="15%">
                                    <div class="merg_btn">
                                        <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" ValidationGroup="servss" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png"
                                            ToolTip="Reset" OnClick="ImgRefresh_Click" />
                                    </div>
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
                                        TargetControlID="txtDateFrom" WatermarkText="Draw From">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                        WatermarkText="Draw To">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </fieldset>
                <fieldset class="field_profile" style="display:none">
                     <legend>Lucky Draw</legend>
                    <asp:Panel ID="DefaultButtonPanel2" DefaultButton="ImgSearch" runat="server">
                          <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                <tr>
                                <td style="text-align:center"><b>Select product and date draw from search and go for lucky draw, and get winning customer's list &nbsp; <asp:Button ID="btnGoForLuckyDraw" runat="server" Text="Go For Lucky Draw and get winner's list"  CssClass="button_all" OnClick="btnGoForLuckyDraw_Click" /></b>
                                    </td>
                            </tr>
                            <tr>
                                 
                                <td>  
                                    &nbsp;</td>
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
                            <td width="2%">
                            <asp:ImageButton ID="btnExceldwn" runat="server" OnClick="btnExceldwn_Click" Width="25px" Height="25px" ImageUrl="~/Content/images/excel.png" ToolTip="Download Excel" />
                            </td>
                            <td width="13%" align="right">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRows" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRows_SelectedIndexChanged">
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
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                    PageSize="25" OnPageIndexChanging="GrdVw_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr No">
                            <ItemTemplate>
                                <%--<asp:Label ID="lblcompname" runat="server" Text='<%# Bind("EntryDate","{0:ddd, MMM d, yyyy}") %>'></asp:Label>--%>
                                 <%#Container.DataItemIndex+1 %>
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
                        <asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Coupon Code">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("CouponCode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Prize/CouponName">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("CouponName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>                        

                      <%--  <asp:TemplateField HeaderText="Prize">
                            <ItemTemplate>
                                <asp:Label ID="lblnetwork" runat="server" Text='<%# Bind("Prize") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>      --%>                 
                            <%--<asp:TemplateField HeaderText="Code 1">
                                <ItemTemplate>
                                    <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>--%>
                      <%--  <asp:TemplateField HeaderText="Code 2">
                            <ItemTemplate>
                                <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%# Bind("Code2") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>--%>
                     <%--   <asp:TemplateField HeaderText="SMS">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes" runat="server" Text='<%# Convert.ToInt32(Eval("IsSMS")) == 0 ? "Pending" : "Sent" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Gift Assigned">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Convert.ToInt32(Eval("IsCouponUsed")) == 0 ? "No" : "Yes" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Gift Delivered">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Convert.ToInt32(Eval("IsGiftDelivered")) == 0 ? "Pending" : "Delivered" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <%--<asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                    PageSize="25" OnPageIndexChanging="GrdVw_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Draw Date">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("EntryDate","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
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
                        <asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Prize">
                            <ItemTemplate>
                                <asp:Label ID="lblnetwork" runat="server" Text='<%# Bind("Prize") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>                       
                        <asp:TemplateField HeaderText="Code 1">
                            <ItemTemplate>
                                <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code 2">
                            <ItemTemplate>
                                <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%# Bind("Code2") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SMS">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes" runat="server" Text='<%# Convert.ToInt32(Eval("IsSMS")) == 0 ? "Pending" : "Sent" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivery">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Convert.ToInt32(Eval("IsDelivery")) == 0 ? "Pending" : "Delivered" %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>--%>
            </div>
        </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btnExceldwn" />
        </Triggers>
    </asp:UpdatePanel>