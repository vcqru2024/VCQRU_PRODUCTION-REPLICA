<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UC_AwardDetailsVendor.ascx.cs" Inherits="UserControl_UC_AwardDetailsVendor" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<style>
   
   
      .ajax__calendar_today{
         padding:0px 0px 0px 0px;
    }
      .ajax__calendar_dayname{
         padding:0px 0px 0px 0px;
    }
</style>
<script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(3).addClass("active");
            $(".accordion2 div.open").eq(3).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>


<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
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

          
        <div class="col-md-9 col-lg-10">
        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="card card-admin form-wizard profile box_card">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Award Details</h4>
                            </header>
                
           
            <div id="newMsg" runat="server" style="width: 91%;">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                     <asp:Label ID="Label6" runat="server" CssClass="astrics"></asp:Label>
                </p>
            </div>
                <div class="card-body card-body-nopadding">
                  
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                            <%--<label>Product Name</label>--%>
                             <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Visible="true">
                                    </asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-3">
                            <asp:DropDownList ID="ddlProduct" runat="server" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                        CssClass="form-control form-control-sm">
                                    </asp:DropDownList>
                              </div>
                        <div class="form-group col-lg-3">
                               <%-- <label>From</label>--%>
                             <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                        </div>
                             <div class="form-group col-lg-3">
                                 <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                 <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                                 <%--<label>To</label>--%>
                             </div>
                        </div>
                        
                        <div class="form-row">
                        <div class="form-group col-lg-6"> 
                              <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"  ValidationGroup="servss"
                                        OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field"  ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                            <asp:Label Text="" runat="server"  Visible="false"  ID="Label7" style="font-size: 13px; font-weight: bold;"></asp:Label>
                            <asp:Button Text="Redeem Your Points" ID="Button1" CssClass="button_all" Visible="false" runat="server" />
                        </div>
                            <div class="form-group col-lg-6">
                                 <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Date From....">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                        WatermarkText="Date To....">
                                    </cc1:TextBoxWatermarkExtender>
                            </div>
                    </div>
                     <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-6">
													<h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                     <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">
                                                    <asp:Label ID="Label8" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="Label9" runat="server"></asp:Label>
                                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                                         Visible="false" >
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
                     <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                    DataKeyNames="IsCashConvert" EmptyDataText="Record Not Found" 
                    OnRowCommand="GrdLabel_RowCommand" BorderColor="transparent" >
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblentrydate" runat="server" Text='<%# Bind("Updt") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User (Award)">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                (<asp:Label ID="lblsize" runat="server" Text='<%# Bind("GiftName") %>'></asp:Label>)
                                
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="25%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Bind("EarnedStatus") %>'></asp:Label>
                                <asp:Label ID="BLoyalty_PointEarnedID" runat="server" Text='<%# Bind("BLoyalty_PointEarnedID") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                      <%--  <asp:TemplateField HeaderText=" Code1 & Code2">
                            <ItemTemplate>
                                <asp:Label ID="lblcode1" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>-<asp:Label
                                    ID="lblcode2" runat="server" Text='<%# Bind("Code2") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="6%" />
                        </asp:TemplateField>--%>
                       <%-- <asp:TemplateField HeaderText=" Earn">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        Earn = "";// GrdLabel.DataKeys[index].Values["Type"].ToString();
                                        IsCash = Convert.ToInt32(GrdLabel.DataKeys[index].Values["IsCashConvert"]);
                                    }
                                    catch
                                    {
                                    }
                                %>
                                <%if (Earn == "Earn")
                                  { %>
                                <%if (IsCash == 0)
                                  { %>
                                <span class="WebRupee">&#x20B9;</span><%} %><asp:Label ID="lblearntype" runat="server" Text='<%# Bind("Points") %>'></asp:Label>
                                <%}
                                  else
                                  { %>
                                <asp:Label ID="lblnoneearn" runat="server" Text=' -- -- '></asp:Label>
                                <%} %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>--%>
                       <%-- <asp:TemplateField HeaderText=" Redeem">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        Redeem = GrdLabel.DataKeys[index].Values["Type"].ToString();
                                    }
                                    catch
                                    {
                                    }
                                %>
                                <%if (Redeem == "Redeem")
                                  { %>
                                <asp:Label ID="lblredeemype" runat="server" Text='<%# Bind("Points") %>'></asp:Label>
                                <%}
                                  else
                                  { %>
                                <asp:Label ID="lblnoneredeem" runat="server" Text=' -- -- '></asp:Label>
                                <%} %>
                                <%index++;%>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>--%>
                       <%-- <asp:TemplateField HeaderText=" Mode">
                            <ItemTemplate>
                                <asp:Label ID="lblcheckmode" runat="server" Text='<%# Bind("Mode") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>--%>
                    </Columns>
                   <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
                    </div>
                    </div>
                </div>

               
                </div>
            </div>
               </div>

           <%-- <fieldset class="field_profile" style="display:none;">
                <legend style="background: url(../images/doc.png) no-repeat 3px center;">Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td width="40%" align="left">
                             <span class="WebRupee" style="font-size: 12px; font-weight: bold;"> </span></td>
                        <td width="23%">
                           
                        </td>
                      
                    </tr>
                    <tr>
                        <td><asp:Label Text="" runat="server"  ID="lblAvailablePoints" style="font-size: 13px; font-weight: bold;" /></td> <td>
                            <asp:Button Text="Bank details for transfer cash" ID="btnRedem" CssClass="button_all" Visible="false" runat="server" /></td>
                    </tr>
                </table>
            </fieldset>--%>
            <div class="grid_container">
              <%--  <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right" style="padding-right: 20px;">
                                <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </h4>
               --%>
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelCreate" runat="server" Width="32%" Style="display: none;">
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
                                            <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                    </div>
                                    <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                        <legend>Check Code Info</legend>
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
                                                        ValidationGroup="LCR" ControlToValidate="txtMobileNo"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Mobile No. :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMobileNo" CssClass="textbox_pop" runat="server" Width="150px"
                                                        MaxLength="10" OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(10
                                                    digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtCode1"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Code1 :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCode1" CssClass="textbox_pop" runat="server" Width="150px" MaxLength="5"
                                                        OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(5 digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                        ValidationGroup="LCR" ControlToValidate="txtCode2"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Code2 :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCode2" CssClass="textbox_pop" runat="server" Width="150px" MaxLength="8"
                                                        OnKeyPress="return isNumberKey(this, event);"></asp:TextBox>&nbsp;(8 digits)
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="2" style="padding-right: 5px;">
                                                    <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                    <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="LCR" CssClass="button_all"
                                                        UseSubmitBehavior="false" runat="server" Text="Save" />
                                                    <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                                        Text="Reset" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
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
                                <div class="regis_popup" style="overflow: auto; hieght: 350px;">
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
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label5" runat="server"></asp:Label>
              <%--  <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                    CancelControlID="btnPasswordPnlClose" PopupControlID="PanelShowPassword" TargetControlID="Label3">
                </cc1:ModalPopupExtender>--%>
            </div>
       <%-- </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>