<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="FrmPendingDispatchLabel.aspx.cs" Inherits="FrmPendingDispatchLabel" Title="Label Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(25).addClass("active");
            $(".accordion2 div.open").eq(20).show();

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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Pending Dispatch Labels Details</h4>
                            </header>
                
                <div class="card-body card-body-nopadding">
                  <div id="NewMsgpop" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label></p>
            </div>
                    <div class="form-row">
                        <div class="form-group col-lg-5">
                           <%-- <label>Dealer Name</label>--%>
                             <asp:TextBox ID="txttrachingno" placeholder="Tracking No." runat="server" CssClass="form-control form-control-sm"></asp:TextBox>                            
                        </div> 
                        <div class="form-group col-lg-5">
                             <asp:DropDownList ID="ddlProSearch" runat="server" CssClass="form-control form-control-sm">
                                    </asp:DropDownList></div>
                        <div class="form-group col-lg-2">
                             <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                            ToolTip="Reset" />
                        </div>
                    </div>
                     <%-- <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="Button1" ToolTip="Add Dealer" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Dealer" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>--%>
                     <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
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
                         <div class="table-responsive">
                  <asp:HiddenField ID="docflag" runat="server" />
                <asp:GridView ID="GrdVwLabelRequest" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    EmptyDataText="Record Not Found" BorderColor="transparent" OnRowCommand="GrdVwLabelRequest_RowCommand">
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
                                <asp:Label ID="lblreqdate" runat="server" Text='<%# Bind("Entry_Date","{0:dd MMM, yyyy}") %>'></asp:Label>
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
                        <asp:TemplateField HeaderText="Req. Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbldiscrip" runat="server" Text='<%# Bind("TotalCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dispatch Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("DispatchCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pending Dispatch Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lblproprice" runat="server" Text='<%# Bind("PendingDispatchCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Receive Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbllabelsiZe" runat="server" Text='<%# Bind("ReceiveCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                        </asp:TemplateField>                                                                       
                    </Columns>
                 <%--   <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>                
                </div>
               </div>
                </div>

            </div>
          
                </div>
            </div>
         </div>
         </div>
            <div class="grid_container">
               <%-- <h4>
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
             
            </div>
      <%--  </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
