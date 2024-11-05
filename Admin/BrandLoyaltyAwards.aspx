<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Awards Master" CodeFile="BrandLoyaltyAwards.aspx.cs" Inherits="Admin_BrandLoyaltyAwards" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(13).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script language="javascript" type="text/javascript">
        function checklabel(vl) {
            PageMethods.checkNewLabel(vl, onCompleteLaebl)
        }
        function onCompleteLaebl(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "Label Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkSaveBtn();
        }
        function ChkSaveBtn() {
            var vl = document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML;           
            if (vl == "") {                
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
        }   
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
                <h2 class="consumer_awards">
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                Awards Master
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/Content/images/add_new.png"
                                    runat="server" ToolTip="Add New Award" />
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
                                <td align="right" width="15%">
                                    <strong>Award Name :</strong>
                                </td>
                                <td width="25%">
                                    <asp:TextBox ID="txtsearchlblname" runat="server" CssClass="textbox_pop" placeholder="Award Name"></asp:TextBox>
                                </td>
                                <td align="justify">
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
                            <td align="right" style="padding-right: 20px;">
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
                <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    DataKeyNames="IsDelete,IsActive" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    OnRowCommand="GrdAwards_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdAwards_PageIndexChanging"
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Awards Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("AwardName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" Width="35%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Points">
                            <ItemTemplate>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Bind("Points") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        dflag = Convert.ToInt32(GrdAwards.DataKeys[index].Values["IsDelete"].ToString());
                                        aflag = Convert.ToInt32(GrdAwards.DataKeys[index].Values["IsActive"].ToString());
                                    }
                                    catch { }

                                    if (dflag == 0)
                                    { %>
                                        <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("RowId") %>'
                                    CausesValidation="false" CommandName="EditLabel" ToolTip="Price Edit" />&nbsp;
                                    <%if (aflag == 0)
                                      {  
                                    %>
                                    <asp:ImageButton ID="imgawrdactive" runat="server" ImageUrl="~/Content/images/check_act.png"
                                        CausesValidation="false" ToolTip='<%# Bind("IsActiveMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                        CommandName="IsActive" Height="12px" Width="12px" />&nbsp;
                                    <%}
                                      else
                                      {%>
                                    <asp:ImageButton ID="imgawrddeactive" runat="server" ImageUrl="~/Content/images/check_gr.png"
                                        CausesValidation="false" ToolTip='<%# Bind("IsActiveMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                        CommandName="IsActive" Height="12px" Width="12px" />&nbsp;
                                    <%}                                     
                                    %> 
                                    <asp:ImageButton ID="imgshowlbl" runat="server" ImageUrl="~/Content/images/delete.png"
                                    CausesValidation="false" ToolTip='<%# Bind("IsDeleteMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                    CommandName="IsDelete" Height="10px" Width="10px" />&nbsp;
                                    
                                     <%}
                                    else
                                    { %>
                                         <asp:Label ID="lbldelaward" Text="Deleted" ForeColor="Red" runat="server" ></asp:Label>
                                         <%  }                                 
                                    %>                                    
                                   
                                <%index++; %>    
                                    
                                    
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
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelCreate" runat="server" Width="25%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnClosePop" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left"><strong>
                                        <asp:Label ID="lblheading" runat="server"></asp:Label></strong> </span><span class="right">
                                            <span class="astrics"><strong>*</strong></span> <em>indicates mandatory fields</em></span></p>
                            </div>
                            <asp:Panel ID="PnlCreateLavel" runat="server">
                                <div class="regis_popup">
                                    <div id="Div1" runat="server">
                                        <p>
                                             <asp:Label ID="Label6" runat="server" Visible="true"></asp:Label>
                                            <%--<asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label>--%></p>
                                    </div>
                                    <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                        <legend>Award Info</legend>
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr id="MytrNew" runat="server">
                                                <td colspan="2" align="center">
                                                    <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                        ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtlabelname"></asp:RequiredFieldValidator>
                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtlabelname"
                                                        runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                                    </cc1:FilteredTextBoxExtender>
                                                    <strong><span class="star_red">*</span>Award Name :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtlabelname" CssClass="textbox_pop" onchange="checklabel(this.value);" MaxLength="20"
                                                        runat="server" placeholder="Award Name" ></asp:TextBox>                                                        
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLabelChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                                                </td>
                                            </tr>                                            
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtlabelprise"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Points :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtlabelprise" CssClass="textbox_pop" runat="server" Width="60px"
                                                        MaxLength="6" OnKeyPress="return isNumberKey(this, event);" onchange="mathRoundForTaxes(this.id);"></asp:TextBox>
                                                </td>
                                            </tr>                                                                                        
                                        </table>
                                    </fieldset>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" colspan="2" style="padding-right: 5px;">
                                            <span style="color:Red; padding-left:5px; float:left;">Award Name should be in 20 char.</span>
                                                <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="LCR" CssClass="button_all"
                                                    UseSubmitBehavior="false" runat="server" Text="Save" />
                                                <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                                    Text="Reset" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupCreateLabel" runat="server" PopupControlID="PanelLabelCreate"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelCreate" CancelControlID="btnClosePop">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelCreate" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelPrise" runat="server" Width="32%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="PanelLabelPriseDetails" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left"><strong><b>
                                        <asp:Label ID="Label4" runat="server" Text="" ForeColor="Green" Font-Size="12pt"></asp:Label></b>&nbsp;&nbsp;<asp:Label
                                            ID="Label1" runat="server" Text="Label Price Details"></asp:Label>&nbsp;&nbsp;&nbsp;</strong>
                                    </span>
                                </p>
                            </div>
                            <asp:Panel ID="Panel2" runat="server">
                                <div class="regis_popup" style="overflow: auto; height: 350px;">
                                    <asp:GridView ID="GrdViewLabelDetails" runat="server" AutoGenerateColumns="False"
                                        CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                        BorderColor="transparent">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Price Change Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblentrydatedet" runat="server" Text='<%# Bind("Entry_Date") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Price (In Rs.)">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprisedet12" runat="server" Text='<%# Bind("Label_Prise") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="50%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                        <RowStyle CssClass="tr_line1" />
                                        <AlternatingRowStyle CssClass="tr_line2" />
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupLabelPriseDetails" runat="server" PopupControlID="PanelLabelPrise"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelPriseDet" CancelControlID="PanelLabelPriseDetails">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelPriseDet" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!--===============================PopUp Password Starts===============================-->
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblPassPnlHead" runat="server" Text="Password" Font-Size="10pt"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                <asp:Label ID="lblPopMsgText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                <br />
                                <div id="infobtn" runat="server">
                                    <asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" Visible="false" />
                                           <asp:HiddenField ID="hdntype" runat="server" Value="" /> <asp:HiddenField ID="hdnIsActive" runat="server" Value="0" /><asp:HiddenField ID="hdnIsDelete" runat="server" Value="0" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label5" runat="server"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                    CancelControlID="btnPasswordPnlClose" PopupControlID="PanelShowPassword" TargetControlID="Label3">
                </cc1:ModalPopupExtender>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
