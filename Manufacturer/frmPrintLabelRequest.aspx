<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="frmPrintLabelRequest.aspx.cs" Inherits="frmPrintLabelRequest" Title="Label Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(21).addClass("active");
            $(".accordion2 div.open").eq(20).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" language="javascript">
        function precise_round(num, decimals) {
            return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);
        }
        function FindAllGrandT(vl) {

            var lblCode = document.getElementById("<%=HdLabelCodeRequest.ClientID %>").value;
            var ProID = document.getElementById("<%=ddlprotype.ClientID %>").value;
            if (lblCode == "") {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please select Product !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                return;
            }
                        
            var code = document.getElementById("<%=txtNoofLabel.ClientID %>").value;
            if (code != "") {
                if (parseInt(code) > 100000)
                {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter No. of Requested Label not exceeding 1000000 (1 lakh)";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";                 
                    return;
                }
            }

            var val = lblCode + "-" + vl + "-" + ProID;
            PageMethods.FindAllAmount(val, onCompleteGrandT)
        }
        function onCompleteGrandT(Result) {
            var Arr = Result.toString().split('-'); 
            if (Arr[1].toString() == "True") {
                if (Arr[0].toString() == "0") {                    
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                }
                else {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=Div1.ClientID %>").className = "";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = false;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = precise_round(Arr[0], 2);
                }                
            }
            else {
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
            }
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a style="display: block"></a>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
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
   <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
            <div class="card card-admin form-wizard profile box_card">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Request for print Labels</h4>
                            </header>
                
                <div class="card-body card-body-nopadding">
                  <div id="NewMsgpop" runat="server">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                    <div class="form-row">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="Button1" ToolTip="Add Label Request" OnClick="Button1_Click1"
                                            CausesValidation="false" runat="server" Text="Add Label Request" class="btn btn-primary mb-0" />
                           </div>
                      </div>
                    <div class="form-row">
                        <div class="form-group col-lg-2">
                           <%-- <label>Dealer Name</label>--%>
                              <asp:TextBox ID="txttrachingno" placeholder="Tracking No." runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-2">
                             <asp:DropDownList ID="ddlProSearch" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-3">
                               <asp:TextBox ID="txtDateFrom" placeholder="Date From" runat="server" Text="" CssClass="form-control form-control-sm"></asp:TextBox>
                            </div>
                         <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtDateTo" placeholder="Date To" runat="server" Text="" CssClass="form-control form-control-sm"></asp:TextBox>
                         </div>
                        <div class="form-group col-lg-2">
                             <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                        </div>
                    </div>
                 
                       <div class="form-row">
                          
                           <div class="form-group col-lg-6">
                              <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom"
                                        runat="server" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server" TargetControlID="txtDateFrom"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                            </div>
                           </div>
                       <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-8">
													<h4 class="mb-0">Record's Found : <span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
												</div>
                                                <div class="col-lg-2">
                                                     <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">

													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
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
                <div class="table-responsive table_large">
                <asp:GridView ID="GrdVwLabelRequest" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                    DataKeyNames="Flag" EmptyDataText="Record Not Found" 
                    BorderColor="transparent" OnRowCommand="GrdVwLabelRequest_RowCommand"
                  >
                    <Columns>
                        <asp:TemplateField HeaderText="Tracking No.">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblTracking" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Request Date">
                            <ItemTemplate>
                                <asp:Label ID="lblreqdate" runat="server" Text='<%# Bind("RequestDate") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblactudate" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="23%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Label Type">
                            <ItemTemplate>
                                <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("LabelType") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <asp:Label ID="lbllabelsiZe" runat="server" Text='<%# Bind("Label_Size") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price/Label">
                            <ItemTemplate>
                                <asp:Label ID="lblproprice" runat="server" Text='<%# Bind("Label_Prise") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Req. Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbldiscrip" runat="server" Text='<%# Bind("RequestedLabels") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblrequeststatusdiscrip" runat="server" Text='<%# Bind("RequestStatusFlag") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="16%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <%try
                                  {
                                      pflag = Convert.ToInt32(GrdVwLabelRequest.DataKeys[index].Values["Flag"].ToString());
                                  }
                                  catch { }
                                  if (pflag == 0)
                                  {  
                                %>
                                <asp:ImageButton ID="Imgprintcancellabel" runat="server" ImageUrl="~/Content/images/Erase.png"
                                    Height="12px" CausesValidation="false" Width="12px" CommandName="RequestCancel"
                                    CommandArgument='<%# Bind("Row_ID") %>' ToolTip="Request Cancel" OnClientClick="return confirm('Are you sure you want to cancel?')" />
                                <%} %>
                                <%index++; %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                        </asp:TemplateField>
                    </Columns>
                   <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                <!--PopUp Starts-->
                <!-- Pop Alert -->
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                    </div>
                </div>
                </div>

            </div>
            </div>
        <%--    <div class="head_cont">
                <h2 class="print_req">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Product" OnClick="imgNew_Click" ImageUrl="../Content/images/add_new.png"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center;">
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
            </div>--%>
         
           
                </div>
            </div>
        </div>
    
            <div class="grid_container">
                <%--<h4>
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
                </h4>--%>
                <asp:HiddenField ID="docflag" runat="server" />
                
                <asp:Panel ID="PanelPrintRequest" runat="server" Width="30%" style="display:none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnRequestpopClose" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LblRequestPrintHeader" runat="server" Font-Bold="true" Text="Request for print label"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="Div1" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="Label1" runat="server"></asp:Label></p>
                                </div>
                                <div id="DivNewMsg" runat="server" style="width: 85%;">
                                    <p>
                                        <asp:Label ID="LabelRequestmsg" runat="server"></asp:Label></p>
                                </div>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                           
                                            <strong><span class="astrics">*</span>Product Name :</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlprotype" runat="server" CssClass="form-control form-control-sm" 
                                                OnSelectedIndexChanged="ddlprotype_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                           
                                            <strong><span class="astrics">*</span> :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTypeNew1" runat="server"></asp:Label>
                                            <asp:DropDownList ID="ddlLabelType" runat="server" CssClass="drp" Width="95%" Style="text-transform: capitalize;"
                                                Visible="false">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            
                                            <strong><span class="astrics">*</span> :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNoofLabel" MaxLength="10" runat="server" CssClass="text_box_small"
                                                onchange="FindAllGrandT(this.value)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong><span class="astrics">*</span> :</strong>
                                        </td>
                                        <td style=" text-align:left; padding-left:5px;">
                                            (<asp:Label ID="lblGrandTotal" runat="server" />)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 10px;">
                                            <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: right;">
                                            <asp:Button ID="btnRequestSend" runat="server" OnClick="btnRequestSend_Click" CssClass="button_all"
                                                Text="Send Request" ValidationGroup="reqlbl" />&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderRequest" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelPrintRequest" TargetControlID="LabelRequestC" CancelControlID="btnRequestpopClose">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelRequestC" runat="server"></asp:Label>
                <!--PopUp Close-->
                <!--===============================PopUp Alert Starts===============================-->
                <asp:Panel ID="PanelAlert" runat="server" Width="20%" style="display:none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                <br />
                                <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYes_Click" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                    Visible="false"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                    CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
                </cc1:ModalPopupExtender>
                <!--===============================Popup Close================================-->
                <div>
                    <asp:Label ID="lblRequestLabelID" runat="server" Visible="false"></asp:Label>
                    <asp:HiddenField ID="hdNoofCodes" runat="server" />
                    <asp:HiddenField ID="HiddenFieldProNm" runat="server" />
                    <asp:HiddenField ID="HiddenFieldLabelType" runat="server" />
                </div>
            </div>
       <%-- </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
