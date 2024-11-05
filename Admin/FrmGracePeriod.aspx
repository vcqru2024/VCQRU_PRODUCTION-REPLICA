<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmGracePeriod.aspx.cs" Inherits="FrmGracePeriod" Title="Given Grace Period" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(17).addClass("active");
            $(".accordion2 div.open").eq(11).show();

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
                    <div align="center" style="position: absolute; left: 0; height: 1230px; width: 100%;
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
                <h2 class="reg_pro">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Manage Product Amc and Offer Plan
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Product" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    CausesValidation="false" runat="server" Visible="false" />
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
            <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButton" runat="server" DefaultButton="ImgSearch">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td width="25%" align="justify">
                                <asp:HiddenField ID="currindex" runat="server" />
                                <asp:DropDownList ID="ddlComapany" OnSelectedIndexChanged="ddlComapany_SelectedIndexChanged"
                                    AutoPostBack="true" runat="server" CssClass="reg_txt" placeholder="Select Comany">
                                </asp:DropDownList>
                            </td>
                            <td align="justify" width="25%">
                                <asp:DropDownList ID="ddlProducts" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged"
                                    AutoPostBack="true" runat="server" CssClass="reg_txt">
                                </asp:DropDownList>
                            </td>
                            <td align="justify" width="25%">
                                <asp:DropDownList ID="ddltType" runat="server" CssClass="reg_txt">
                                    <asp:ListItem Value="AMC">AMC</asp:ListItem>
                                    <asp:ListItem Value="Offer">Offer</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="width: 10%;">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        CausesValidation="false" ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        CausesValidation="false" ToolTip="Reset" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>
            <fieldset class="Newfield" style="width: 98%">
                <legend>Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td colspan="12" style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 2%;">
                                        <img alt="" src="../Content/images/edit.png" />
                                    </td>
                                    <td style="width: 17%;">
                                        Edit Extention Date
                                    </td>
                                    <%-- <td style="width: 2%;">
                                        <img alt="" src="../Content/images/upg.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 15%;">
                                        Renewal Your AMC
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/upgrade.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 16%;">
                                        Renewal Your Offer
                                    </td>--%>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/delete.png" />
                                    </td>
                                    <td width="13%">
                                        Cancel
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/upg.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td>
                                        Grace Period
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/check_act.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td>
                                        Start Service
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/check_gr_red.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td>
                                        Stop Service
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdndtfrom" runat="server" />
                <asp:HiddenField ID="hdndtto" runat="server" />
            </fieldset>
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
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
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
                <div id="MyAmcOfferDetails" runat="server">
                    <asp:HiddenField ID="HdnUpdatePlanID" runat="server" />
                    <asp:HiddenField ID="HdnUpdatePlanType" runat="server" />
                    <asp:HiddenField ID="HdnUpdatePlanTransID" runat="server" />
                    <asp:GridView ID="GrdProductsAmc" runat="server" AutoGenerateColumns="False" CssClass="grid"
                        DataKeyNames="Trans_Type,IsCancel,Flag" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" OnRowCommand="GrdProductsAmc_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Amc Name">
                                <ItemTemplate>
                                    <asp:Label ID="proAmcType" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan Amount">
                                <ItemTemplate>
                                    <asp:Label ID="proplanAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                        runat="server" Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="proplanvrstatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Start Date">
                                <ItemTemplate>
                                    <asp:Label ID="proplanstdate" runat="server" Text='<%# Bind("Date_From") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="End Date">
                                <ItemTemplate>
                                    <asp:Label ID="proplanenddate" runat="server" Text='<%# Bind("Date_To") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discount">
                                <ItemTemplate>
                                    <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                        runat="server" Text='<%# Bind("Plan_Discount") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>                                                                       
                                    <%try
                                      {
                                          flag = Convert.ToInt32(GrdProductsAmc.DataKeys[index].Values["Flag"].ToString());
                                          IsCancel = Convert.ToInt32(GrdProductsAmc.DataKeys[index].Values["IsCancel"].ToString());
                                      }
                                      catch { }%>
                                    <% if (IsCancel == 1)
                                       {%>
                                    <asp:ImageButton CausesValidation="false" runat="server" ID="imgupdateplancan" CommandArgument='<%# Bind("Trans_ID") %>'
                                        CommandName="CancelPlan" ImageUrl="~/Content/images/delete.png" ToolTip="Cancel" />&nbsp;
                                    <%} %>
                                    <% if (flag == 0)
                                       { %>    
                                       <asp:ImageButton CausesValidation="false" runat="server" ID="imgupdateplan" CommandArgument='<%# Bind("Trans_ID") %>'
                                        CommandName="DateExtention" ImageUrl="~/Content/images/edit.png" ToolTip="Edit" />&nbsp;                                
                                    <asp:ImageButton CausesValidation="false" runat="server" ID="imgactiveplancan" CommandArgument='<%# Bind("Trans_ID") %>'
                                        CommandName="ActivePlan" ImageUrl="~/Content/images/check_gr_red.png" ToolTip="Start Service" /><%}
                                       else
                                       { %>
                                        <asp:ImageButton CausesValidation="false" runat="server" ID="imgupdateplangp" CommandArgument='<%# Bind("Trans_ID") %>'
                                        CommandName="GivenGPPlan" ImageUrl="~/Content/images/upg.png" ToolTip="Given Grace Period"
                                        Style="height: 11px; width: 11px;" />&nbsp;
                                    <asp:ImageButton CausesValidation="false" runat="server" ID="imgdeactiveplancan"
                                        CommandArgument='<%# Bind("Trans_ID") %>' CommandName="DeActivePlan" ImageUrl="~/Content/images/check_act.png"
                                        ToolTip="Stop Service" />
                                    <%} %>
                                    <%index++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Center" Width="7%" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                </div>
                <!-------------------Start Popup--------------->
                <asp:Panel ID="GivenGracePanel" runat="server" Width="25%" style="display:none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="BtnClosePopupRequest" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="GPHeadLabel" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table id="Table3" runat="server">
                                    <tr>
                                        <td style="height: 5px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Start Date : </strong>
                                        </td>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:TextBox ID="txtstdate" runat="server" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>End Date : </strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtenddate" Enabled="false" runat="server" />
                                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtstdate"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtdtfromamc2"
                                                                                            Mask="99/99/9999" MaskType="Date">
                                                                                        </cc1:MaskedEditExtender>--%>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" TargetControlID="txtstdate"
                                                WatermarkText="From..">
                                            </cc1:TextBoxWatermarkExtender>
                                            <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtenddate"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtenddate"
                                                Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender4" runat="server" TargetControlID="txtenddate"
                                                WatermarkText="To..">
                                            </cc1:TextBoxWatermarkExtender>
                                        </td>
                                    </tr>
                                </table>
                                <table id="details" runat="server">
                                    <tr>
                                        <td style="height: 5px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Start Date : </strong>
                                        </td>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:Label ID="lblstdate" runat="server"></asp:Label>
                                            <br />
                                        </td>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>End Date : </strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblenddate" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; vertical-align: top; text-align: right;">
                                            <strong>Given Grace Period : </strong>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtforgp" runat="server" Width="50px" OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                                <table id="Table2" runat="server">
                                    <tr>
                                        <td style="height: 25px; padding-top: 5px; font-size: 12pt;">
                                            <asp:Label ID="Label1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table style="width:100%;" id="Table1" runat="server">
                                    <tr>
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblMsgAlert" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="remarks" runat="server">
                                        <td style="width: 30%; vertical-align: top; text-align: right;">
                                            <strong>Remarks : </strong>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtremarks" TextMode="MultiLine" Width="98%" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'150');"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%;">
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnYes" runat="server" CssClass="button_all" OnClick="btnYes_Click"
                                                CausesValidation="false" Text="OK" /><a target="_blank"
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupForGp" runat="server" BackgroundCssClass="NewmodalBackground"
                    BehaviorID="CancelPendingRequest" PopupControlID="GivenGracePanel" TargetControlID="Label12"
                    CancelControlID="BtnClosePopupRequest">
                </cc1:ModalPopupExtender>
                <asp:Label ID="Label12" runat="server"></asp:Label>
                <asp:Label ID="LabelExectute" runat="server" Visible="false" ></asp:Label>
                <!-------------------End Popup--------------->
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
