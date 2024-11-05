<%@ Page Title="Scrap Details" Language="C#" MasterPageFile="~/Admin/MasterPage.master" 
    AutoEventWireup="true" CodeFile="FrmScrapEntryM.aspx.cs" Inherits="FrmScrapEntryM" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(38).addClass("active");
            $(".accordion2 div.open").eq(34).show();

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HDF" runat="server" />
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
                <h2 class="scrap_entry">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Scrap Label Entry
                            </td>
                            <td>
                                <asp:ImageButton ID="imgNew" Visible="false" ImageUrl="~/Content/images/add_new.png" runat="server" /><asp:HiddenField
                                    ID="hidden1" runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center;">
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="ImgSearch">
                <fieldset class="field_profile">
                    <legend>Scrap Info</legend>
                    <table width="100%" cellpadding="0" cellspacing="2">
                        <tr>
                            <td align="right" style="width: 10%;">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlCompany"
                                    InitialValue="--Select--" ValidationGroup="abc" runat="server"></asp:RequiredFieldValidator>
                                <strong>
                                    <%--<span class="astrics">*</span>--%>
                                    Company :</strong>
                            </td>
                            <td style="width: 18%;">
                                <asp:DropDownList ID="ddlCompany" CssClass="reg_txt" runat="server" AutoPostBack="true"
                                    Width="100%" OnSelectedIndexChanged="ddlddlComp_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="right" style="width: 14%;">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlProduct"
                                    InitialValue="--Select--" ValidationGroup="abc" runat="server"></asp:RequiredFieldValidator>
                                <strong>
                                    <%--<span class="astrics">*</span>--%>
                                    Product Name :</strong>
                            </td>
                            <td style="width: 18%;">
                                <asp:DropDownList ID="ddlProduct" CssClass="reg_txt" runat="server" AutoPostBack="true"
                                    Width="100%" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="right" style="width: 4%;">
                                <strong>From:</strong>
                            </td>
                            <td style="width: 12%;">
                                <asp:TextBox ID="txtscrapfrom" onchange="upperMe()" CssClass="reg_txt" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapfrom" ErrorMessage="ex: AA06-01-001" Display="None"
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                            </td>
                            <td align="right" style="width: 3%;">
                                <strong>To:</strong>
                            </td>
                            <td style="width: 12%;">
                                <asp:TextBox ID="txtscrapto" CssClass="reg_txt" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapto" ErrorMessage="ex: AA06-01-001" Display="None"
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                            </td>
                            <td style="width: 12%;" align="justify">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" ValidationGroup="abc" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" ToolTip="Refresh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="ImgRefresh_Click" />
                                </div>
                            </td>
                        </tr>
                    </table>
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
                                Record(s) found<span class="small_font"> (<asp:Label ID="lblcount" Text="0" runat="server"></asp:Label>)<asp:Label
                                    ID="lblC" Text="0" runat="server" Visible="false"></asp:Label></span>
                            </td>
                            <td>
                                <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                            </td>
                            <td width="11%" align="right">
                                <asp:ImageButton ID="btnSave" OnClick="btnSave_Click" ImageUrl="~/Content/images/SaveNew.png"
                                    runat="server" /><%--ToolTip="Save"--%>
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
                <div class="printed_pro">
                    <table width="100%" cellspacing="0" cellpadding="0" style="font-weight:bold;" >
                        <tr>                           
                            <td align="left">
                                <asp:Label ID="lblcode" Visible="false" runat="server"></asp:Label>
                                <asp:Label ID="lblfullcode" Visible="false" runat="server"></asp:Label>                                
                                <table cellpadding="2px" cellspacing="2px" style="font-size: 9pt;">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAdminscrap" runat="server" Style="background-color: #C0C7D7; width: 15px;
                                                height: 15px;" OnClick="btnAdminscrap_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Scrap by Admin  &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCourierRescrap" runat="server" Style="background-color: #FFFFFF;
                                                width: 15px; height: 15px;" OnClick="btnCourierRescrap_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Scrap During Courier Receive  &nbsp;&nbsp;
                                        </td>                                       
                                        <td>
                                            <asp:Button ID="btnAvailable" runat="server" Style="background-color: #c7efc8; width: 15px;
                                                height: 15px;" OnClick="btnAvailable_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                           Printed Labels Available &nbsp;&nbsp;
                                        </td>                                       
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="display:none;">
                         <td class="bord_right"  width="34%"  style=" font-size:12px; font-weight:bold; ">
                            Dispath Label(s) found<span class="small_font"> (<asp:Label ID="Labeldispath" Text="0" runat="server"></asp:Label>)</span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <div style="overflow: auto; height: 975px;">
                        <asp:GridView ID="Grdscrap" runat="server" AutoGenerateColumns="False" CssClass="grid"
                            DataKeyNames="ScrapeFlag,ff" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                            BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="Grdscrap_PageIndexChanging">
                            <Columns>
                                <%--  <asp:TemplateField HeaderText="Product Name">
                                <ItemTemplate>
                                    <%=++sr%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="1%" />
                            </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Serial Code">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1SeNew" runat="server" Text='<%# Bind("SerialCode") %>'></asp:Label>
                                        <asp:Label ID="lblactudate123nEW" CssClass="tr_line1" runat="server" Width="5px"
                                            Visible="false" Text='<%# Bind("Series_Order") %>'></asp:Label>
                                        <asp:Label ID="Label1Se" runat="server" Text='<%# Bind("Series_Serial") %>' Width="5px"
                                            Visible="false"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1SeNew4" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <input id="chkselecth" name="chkselecth" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%  
                                            try
                                            {
                                                ScrapeFlag = Convert.ToInt32(Grdscrap.DataKeys[index].Values["ScrapeFlag"].ToString());
                                            }
                                            catch { }
                                            if (ScrapeFlag == 1)
                                            {
                                        %>
                                        <input id="Checkbox1" name="chkselect" checked="checked" type="checkbox" value='<%# Eval("SerialCode") %>' />
                                        <%
                                            }
                                            else
                                            { 
                                        %>
                                        <input id="chkselect" name="chkselect" type="checkbox" value='<%# Eval("SerialCode") %>' />
                                        <%
                                            }
                                            index++;%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="1%" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Right" CssClass="pagination" />
                            <RowStyle CssClass="tr_line1" />
                            <AlternatingRowStyle CssClass="tr_line2" />
                        </asp:GridView>
                    </div>
                </div>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator1" runat="server">
                </asp:ValidatorCalloutExtender>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator2" runat="server">
                </asp:ValidatorCalloutExtender>
                <!--PopUp Starts-->
                <!--PopUp Close-->
            </div>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelForScrap" runat="server" Width="30%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnCloseScrap" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertNewHeader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <br />
                            <table style="width: 100%;">
                                <tr>
                                    <td align="right" width="25%">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                            ValidationGroup="CHKSCR" InitialValue="--Select--" ControlToValidate="ddlreason"></asp:RequiredFieldValidator>
                                        <strong><span class="star_red">*</span> Reason :&nbsp;</strong>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlreason" CssClass="drp" runat="server" Style="text-transform: capitalize;
                                            width: 45%;">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="25%">
                                        <strong>Remarks :&nbsp;</strong>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtreasonremarks" TextMode="MultiLine" CssClass="textarea_pop" runat="server"
                                            Style="text-transform: capitalize; width: 87%; height: 70px;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <%--<asp:Label ID="LabelAlertNewText" runat="server" Text="" Font-Size="11px"></asp:Label><br />--%>
                            <br />
                            <asp:Button ID="btnYesScrap" runat="server" Text="Save" CssClass="button_all" OnClick="btnYesScrap_Click"
                                ValidationGroup="CHKSCR" /><%--&nbsp;&nbsp;<asp:Button ID="btnNoScrap" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNoScrap_Click" CausesValidation="false" />--%>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="LabelControlID" runat="server"></asp:Label><asp:Label ID="LabelModel"
                runat="server" Text="Yes" Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderScrap" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnCloseScrap" PopupControlID="PanelForScrap" TargetControlID="LabelControlID">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:PostBackTrigger ControlID="imgNew" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
