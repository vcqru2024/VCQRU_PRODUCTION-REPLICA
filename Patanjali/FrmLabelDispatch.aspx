<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="FrmLabelDispatch.aspx.cs" Inherits="Patanjali_FrmLabelDispatch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {


            $(".accordion2 p").eq(22).addClass("active");
            $(".accordion2 div.open").eq(20).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
        function CheckScrap(lblCourierIdValue) {
            debugger;
            $('#<%=LabelAlertText.ClientID%>').text("Are you sure to receive Courier Dispatch Order?");
            $('#<%=lblCourierId.ClientID%>').val(lblCourierIdValue);
            $('#<%=LabelCalText.ClientID%>').val("Cal Yes");
            // alert('Hello ').val());//
            // alert($('#=lblCourierId.ClientID%>').val());
            $('#<%=MyRadio.ClientID%>').css("display", "block");
            $('#smallModal123').modal("show");
            return false;
        }
        function Checkdelete() {

           // $('#<%=LabelAlertText.ClientID%>').val("Are you sure to receive Courier Dispatch Order?");
            $('#<%=LabelCalText.ClientID%>').val("Cal Deny");
         //   $('#<%=MyRadio.ClientID%>').css("display","block");
            $('#smallModal123').modal("show"); return false;
        }
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
        .pad
        {
            text-align: left;
            padding: 0px 4px 0 4px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {

            debugger;
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../Content/images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "../Content/images/plus.gif";
            }
        }        
    </script>

    <script language="javascript" type="text/javascript">
        function checkTextAreaMaxLength(textBox, e, length) {

            debugger;
            var mLen = textBox["MaxLength"];
            if (null == mLen)
                mLen = length;
            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                    {
                        e.returnValue = false;
                        return false;
                    }
                    else//Firefox
                        e.preventDefault();
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


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
    
        <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Label Receive</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Label Receive</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- table view -->
            <div class="user-role-card">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col col-md-4 mb-3">
                                <div class="global-search">
                                    <div class="form-group ">
                                     <input type="search" class="form-control" onkeyup="performSearch(this.value)" placeholder="Search">
                                        <span><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>
                           
                        </div>


                         <div class="row">

                             
                            <div class="col">
                                <label for="Product Description" class="form-label">Enter Courier Name</label>

                                <asp:TextBox ID="txtProName" runat="server" CssClass="form-control" placeholder="Courier Name"></asp:TextBox>

                            </div>
                           
                           

                            <div class="col">
                                 <asp:Button ID="btnSearch" style="margin-top:6%;"  OnClick="btnSearch_Click" ValidationGroup="chk94" class="btn btn-primary"
                                    runat="server" Text="Search" />
                            
                                
                            </div>

                        </div>

                          <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label><asp:HiddenField ID="hdCompanyNm"
                        runat="server" />
                </p>
            </div>

                        <div class="row">
                            	<div class="col-lg-8">
													<h4 class="mb-0">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
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
                        <div class="app-table">
                            <div class="table-responsive">
                               
                                   <asp:GridView ID="GrdCourierDispatch" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="Flag" CssClass="table table-hover" EmptyDataText="Record Not Found" 
                        BorderColor="transparent" 
                        OnRowCommand="GrdCourierDispatch_RowCommand"  style="margin-bottom:0">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                    <a href="JavaScript:divexpandcollapse('div<%# Eval("Courier_Disp_ID") %>');">
                                        <img id="imgdiv<%# Eval("Courier_Disp_ID") %>" width="9px" border="0" src="../Content/images/plus.gif"
                                            alt="" title="View Products" />
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>                                    
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="170px" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Courier Company">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Bind("Courier_Name") %>'></asp:Label>
                                    <asp:Label ID="lblCDispID" runat="server" Visible="false" Text='<%# Bind("Courier_Disp_ID") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="27%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tracking No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblLTrackingNo" runat="server" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblLDispDate" runat="server" Text='<%# Bind("Dispatch_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <asp:Label ID="lblLDispLocation" runat="server" Text='<%# Bind("Dispatch_Location") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quantity">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatusReceived" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="16%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <%try
                                      {
                                          Flag = Convert.ToInt32(GrdCourierDispatch.DataKeys[index].Values["Flag"].ToString());
                                      }

                                      catch
                                      {
                                      }
                                      if (Flag == 0)
                                      {
                                            
                                             %>
                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/24x24.png"
                                        Height="16px" Width="16px" OnClientClick='<%# Eval("Courier_Disp_ID", "CheckScrap(\"{0}\"); return false;") %>' 
                                        CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                        ToolTip="Receive Courier" CausesValidation="false" />&nbsp;
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Content/images/Erase.png" Height="12px"
                                        Width="12px"  CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                        ToolTip="Courier Not Received" CausesValidation="false" OnClientClick='<%# Eval("Courier_Disp_ID", "Checkdelete(\"{0}\"); return false;") %>'
                                         />
                                    <%}
                                      else if (Flag == 5)
                                      {
                                          %>
                                          <asp:ImageButton ID="NNewImageButton1" runat="server" ImageUrl="~/Content/images/24x24.png"
                                        Height="16px" Width="16px" OnClientClick="$('#smallModal123').modal();return false;"  CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                        ToolTip="Receive Courier" CausesValidation="false" />&nbsp;
                                          
                                          <%
                                      }
                                    %>
                                    <%index++; %>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <tr>
                                        <td colspan="90%" style="background-color: White">
                                            <div id="div<%# Eval("Courier_Disp_ID") %>" style="display: none; position: relative;
                                                overflow: auto; width: 98%">
                                                <fieldset class="Newfield Newfield_width2">
                                                    <legend>Product Wise Label information</legend>
                                                    <div style="padding-left: 5px; width: 98.5%;">
                                                        <asp:GridView ID="GrdLablelDet" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                                            EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                                                            Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Product Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLProNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Label Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLLabelNm" runat="server" Text='<%# Bind("Label_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Series From">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLSeriesFrom" runat="server" Text='<%# Bind("Series_From") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Series To">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLSeriesTo" runat="server" Text='<%# Bind("Series_To") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="23%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Quantity">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLCountQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="23%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                      <%--  <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                    </asp:GridView>
                   <%-- <asp:Label ID="lblCourierId" runat="server" Text="" Visible="false"></asp:Label>--%>
                 <asp:HiddenField   id="lblCourierId" runat="server" />
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>


              <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                 <%--   <h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 20px; display: none;">
                                    <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                        Text="Payment Received: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
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
                    </h4>--%>
                    
                </div>
            </asp:Panel>
            <!--===============================PopUp Alert Starts===============================-->
         <%--   <asp:Panel ID="PanelAlert" runat="server" Width="20%" style="display:none;">--%>
    <div class="modal fade" id="EraseModal" tabindex="-1" role="dialog" aria-labelledby="EraseModalLabel" aria-hidden="true" style="">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnAlertPnlClose" data-dismiss="modal" aria-hidden="true" runat="server" CausesValidation="false" class="close" /></div>
                        <!--<fieldset class="service_field" >-->
                       <%-- <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>--%>
                        <div class="regis_popup" style="text-align: center;">
                           <%-- <br />
                            <asp:Label ID="LabelAlertText" runat="server" Text="Are you sure you want to rejected?" Font-Size="11px"></asp:Label>
                            <span id="MyRadio" runat="server" visible="false">
                                <asp:RadioButton ID="rdReceipt" runat="server" Text="Receive" Checked="true" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceipts" runat="server" Text="Receive with scrap" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceiptd" runat="server" Text="Reject" GroupName="REC" Visible="false" />&nbsp;&nbsp;
                            </span>--%>
                            <br />
                            <br />
                           
                            <br />
                        </div>
                    </div>
                </div>
           <%-- </asp:Panel>--%>
        </div>

    <div class="modal fade" id="smallModal123" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-sm modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="smallModalLabel">Alert</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<%--<p class="about-section-text1">Are you sure you want to delete ?</p>--%>
                           
                          
                                    <span >
                                       <%-- <asp:Label ID="LabelAlertheader" runat="server" Text="Password" ></asp:Label>--%>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong></strong></span></span>
                                
                            
                            <asp:Label ID="LabelAlertText" runat="server" Text="Are you sure you want to rejected?" ></asp:Label>
                            <br /> <br />
                            <span id="MyRadio" runat="server" style="display:none;">
                                <asp:RadioButton ID="rdReceipt" runat="server" Text="Receive" Checked="true" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceipts" runat="server" Text="Receive with scrap" GroupName="REC" />&nbsp;&nbsp;
                                <asp:RadioButton ID="rdReceiptd" runat="server" Text="Reject" GroupName="REC" Visible="false" />&nbsp;&nbsp;
                            </span>
						</div>
						<div class="modal-footer">
                             <asp:Button ID="btnYesReceipt" runat="server" Text="Yes" class="btn btn-light" OnClick="btnYesReceipt_Click" />&nbsp;&nbsp;<asp:Button
                                ID="btnNoReceipt" runat="server" Text="No" class="btn btn-light"  data-dismiss="modal" />
						</div>
					</div>
				</div>
			</div>

            <!--===============================Popup Close================================-->
            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText2" runat="server" style="display:none;" ></asp:Label>
    <asp:HiddenField  id="LabelCalText" runat="server" />
            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="Panel1" runat="server" Width="25%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonPaymentpopclose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="Label7" runat="server" Text="Reason Information" Font-Size="12px"></asp:Label>
                                </span>
                            </p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <div style="height: 115px; overflow: auto;">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblreaseonMessage" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:TextBox ID="LabelReasonText" runat="server" TextMode="MultiLine" Width="94%"
                                                placeholder="Remark..." onkeyDown="return checkTextAreaMaxLength(this,event,'100');"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                ControlToValidate="LabelReasonText" ValidationGroup="REM"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="BtnCancelRemark1" OnClick="BtnCancelRemark1_Click" ValidationGroup="REM"
                                                CssClass="button_all" runat="server" Text="Submit" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Label ID="Label13" runat="server"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="ButtonPaymentpopclose" PopupControlID="Panel1" TargetControlID="Label13">
            </cc1:ModalPopupExtender>


        </div>

        <script type="text/javascript">
            function performSearch(searchText) {
                $('#ctl00_ContentPlaceHolder1_GrdCourierDispatch tbody tr').each(function () {
                    var row = $(this);
                    var found = false;
                    row.find('td').each(function () {
                        var cellText = $(this).text().toLowerCase();
                        if (cellText.includes(searchText.toLowerCase())) {
                            found = true;
                            return false; // Exit the loop if found
                        }
                    });

                    if (found) {
                        row.show();
                    } else {
                        row.hide();
                    }
                });
            }



        </script>
</asp:Content>

