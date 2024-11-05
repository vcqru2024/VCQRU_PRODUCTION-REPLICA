<%@ Page Title="Lucky Winners Details" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master"
    AutoEventWireup="true" CodeFile="FrmLuckyWinners.aspx.cs" Inherits="FrmLuckyWinners" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        top: 0px; z-index: 999;" class="NewmodalBackground">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Lucky Winners Details<asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label></h4>
                            </header>
             <div class="card-body card-body-nopadding">
                    <div class="form-row">
                        <div class="form-group col-lg-12">
                            <asp:Button ID="btnGoForLuckyDraw" runat="server" Text="Go For Lucky Draw and get winner's list"  CssClass="btn btn-primary mb-0" OnClick="btnGoForLuckyDraw_Click" ValidationGroup="servss" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                            <%--<label>Product Name</label>--%>
                           <asp:DropDownList runat="server" CssClass="form-control form-control-sm" ID="ddlService" AutoPostBack="false" >
                                    <asp:ListItem Selected="True" Value="">Select Service</asp:ListItem>
                                    <asp:ListItem Value="SRV1003">Gift Coupon</asp:ListItem>
                                    <asp:ListItem Value="SRV1006">Raffle Scheme</asp:ListItem>                                  
                                    <%--  <asp:ListItem Text="text1" />
                                    <asp:ListItem Text="text2" />--%>
                                </asp:DropDownList>
                              <asp:RequiredFieldValidator  ControlToValidate="ddlService" runat="server"  ValidationGroup="servss" ForeColor="Red" ErrorMessage="*"
                                                     InitialValue=""/> 
                        </div>
                        <div class="form-group col-lg-3">
                             <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" />
                        </div>
                        <div class="form-group col-lg-3">
                          <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                        </div>
                        
                        
                        <div class="form-group col-lg-3">
                             <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" ValidationGroup="servss"    />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png"
                                            ToolTip="Reset" OnClick="ImgRefresh_Click" />
                            </div> 
                        <div class="form-group col-lg-3">
                             <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control form-control-sm" Visible="false"></asp:TextBox>
                        </div>
                        
                    </div>
                    
                   
                  <div class="form-row">
                      <div class="form-group col-lg-3">
                            <%--<label>From</label>--%>
                            <asp:DropDownList ID="ddlSendSMS" runat="server" CssClass="form-control form-control-sm"  Visible="false" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" >
                                        <asp:ListItem Text="--Delivery--"></asp:ListItem>
                                        <asp:ListItem Text="Sent"></asp:ListItem>
                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-3">
                              <asp:DropDownList ID="ddlDelivery" runat="server" CssClass="form-control form-control-sm"  AutoPostBack="true" Visible="false"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" >
                                    <asp:ListItem Text="--SMS--"></asp:ListItem>
                                        <asp:ListItem Text="Delivered"></asp:ListItem>
                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                           
                        </div>
                      <div class="form-group col-lg-6">
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
                                   </div>
                        </div>



                 <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-6">
													<h4 class="mb-0">Record's Found<span> <asp:Label ID="lblcount" runat="server"></asp:Label>
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                      <asp:ImageButton ID="btnExceldwn" runat="server" Visible="false" OnClick="btnExceldwn_Click" Width="25px" Height="25px" ImageUrl="~/Content/images/excel.png" ToolTip="Download Excel" />
                                                </div>
												<div class="col-lg-2">
                                                  <%--   <asp:ImageButton ID="btnSave" OnClick="btnSave_Click" ImageUrl="~/Content/images/SaveNew.png"
                                    CausesValidation="false" runat="server" />--%><%--ToolTip="Save" --%>
													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
                                                    <asp:DropDownList ID="ddlRows" runat="server" AutoPostBack="true"
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
                     <div class="table-responsive">
              <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    EmptyDataText="Record Not Found" BorderColor="transparent">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr No">
                            <ItemTemplate>
                                <%--<asp:Label ID="lblcompname" runat="server" Text='<%# Bind("EntryDate","{0:ddd, MMM d, yyyy}") %>'></asp:Label>--%>
                                 <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <%-- <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblCodeCheckDate" runat="server" Text='<%# Bind("EntryDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                              
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Coupon Code">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("CouponCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Prize/CouponName">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("CouponName") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
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
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Gift Delivered">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Convert.ToInt32(Eval("IsGiftDelivered")) == 0 ? "Pending" : "Delivered" %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
               <%--     <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                         </div>
              </div>



                 </div>
                <div class="card-body card-body-nopadding">
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <label>Lucky Draw : Select SERVICE, PRODUCT and DRAW DATE from search and go for lucky draw, and get winning customer's list</label>
                      
                        </div>
                        
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-12">
                            <asp:Label ID="lblinvalid" Text="Incorrect Lucky Draw. Please select correct Service,Product,Date for lucky winner's result" runat="server" Visible="false" ForeColor="Red" /> 
                        </div>
                         </div>
                </div>
                </div>

                    
                </div>
            </div>
          </div>
               </div>
            <div class="grid_container">
              <%--  <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td width="2%">
                            
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
       <%-- </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btnExceldwn" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
