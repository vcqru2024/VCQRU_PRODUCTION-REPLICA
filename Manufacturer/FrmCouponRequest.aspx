<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Coupon Request Master" CodeFile="FrmCouponRequest.aspx.cs" Inherits="FrmCouponRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(18).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
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
    </style>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Coupon Request Master</h4>
                            </header>
                <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>

                 <div class="card-body card-body-nopadding">
                  
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                           <%-- <label>Dealer Name</label>--%>
                            <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control form-control-sm" placeholder="Coupon Name"></asp:TextBox>
                          
                        </div>
                        <div class="form-group col-lg-6">
                            <asp:ImageButton ID="btnSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="btnSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="btnRefesh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png"
                                        OnClick="btnRefesh_Click" ToolTip="Refresh" />
                        </div>
                    </div>
                      <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Coupons" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Coupons" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>
                     <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div>
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
                                                     <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
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
                        DataKeyNames="IsActive,IsAdminVerify" EmptyDataText="Record Not Found" 
                        BorderColor="transparent"
                        OnRowCommand="GrdVw_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <%=sno++%>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Coupon Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("CouponName") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qunatity">
                                <ItemTemplate>
                                    <asp:Label ID="lblcouqty" runat="server" Text='<%# Bind("CouponCount") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DateFrom">
                                <ItemTemplate>
                                    <asp:Label ID="lbldtdtfrm" runat="server" Text='<%# Bind("DateFrom","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DateTo">
                                <ItemTemplate>
                                    <asp:Label ID="lbldttto" runat="server" Text='<%# Bind("DateTo","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>                                    
                                    <asp:Label ID="lblreqstatn" runat="server" Text='<%# Convert.ToInt32(Eval("IsAdminVerify")) == 0 ? "Pending" : Convert.ToInt32(Eval("IsAdminVerify")) == 1 ? "Verified" : "Canceled" %>' Font-Size="9pt"></asp:Label>                                  
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>                                    
                                    <%try
                                      {
                                          IsAdminVerify = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsAdminVerify"]);
                                          Flag = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsActive"]);
                                      }
                                      catch { }
                                      if (IsAdminVerify == 0)
                                      {
                                          %>
                                          <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                        CommandName="EditRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="Edit Coupon"
                                        CausesValidation="false" />&nbsp;
                                          <%
                                          if (Flag == 0)
                                          {%>
                                        <asp:ImageButton ID="ImgbtnAct" runat="server" ImageUrl="~/Content/images/check_act.png"   OnClientClick="return confirm('Are you sure you want to De-Activate Coupon?');"  
                                            CommandName="ActivateRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="De-Activate Coupon"
                                            CausesValidation="false" Visible="false" />
                                        <%}
                                          else
                                          { %>
                                        <asp:ImageButton ID="ImgbtnActN" runat="server" ImageUrl="~/Content/images/check_gr.png"  OnClientClick="return confirm('Are you sure you want to Activate Coupon?');"  
                                            CommandName="ActivateRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="Acivate Coupon"
                                            CausesValidation="false" Visible="false" />
                                        <%} %>
                                        <asp:ImageButton ID="ImgbtnDel" runat="server" ImageUrl="~/Content/images/delete.png" OnClientClick="return confirm('Are you sure you want to delete?');"  
                                        CommandName="DeleteRow" CommandArgument='<%# Bind("CouponRequest_ID") %>' ToolTip="Delete Coupon"
                                        CausesValidation="false" />
                                        <%} %>
                                    <%index++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:HiddenField ID="dhnactiontype" runat="server" />
                     </div>
                         </div>
                </div>
                </div>
                 
                </div>
            </div>
         </div>
         </div>
    
          <%--  <div class="head_cont">
                <h2 class="add_Courior">
                    <table width="99%">
                        <tr>
                            <td width="40%">
                                &nbsp;
                            </td>
                            <td width="45%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Coupon Request" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>--%>
            
           
            <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                    
                   
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="35%" Style="display: none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewCourier" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblAddCourierHeader" runat="server" Text=""></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="DivNewMsg" runat="server" style="width: 88%;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <asp:UpdateProgress ID="UpdateProgressForPay2New" 
                                    runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="position: absolute; left: -330px; height: 907px; width: 1024px; top: -170px;
                                            text-align: center;" class="NewmodalBackground">
                                            <div style="margin-top: 300px;" align="center">
                                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                                <span style="color: White;">Please Wait.....<br />
                                                </span>
                                            </div>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Courier Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right">
                                               
                                                <strong><span class="astrics">*</span> :</strong>
                                            </td>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                              
                                                <strong><span class="astrics">*</span> :</strong>
                                            </td>
                                            <td>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                               
                                                <strong><span class="astrics">*</span> :</strong>
                                            </td>
                                            <td>
                                               
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                
                                            </td>
                                        </tr>                                        
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewCourier"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewCourier">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
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
                            <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYes_Click" />&nbsp;&nbsp;<asp:Button
                                ID="btnNo" runat="server" Text="No" CssClass="button_all" OnClick="btnNo_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
            </cc1:ModalPopupExtender>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
