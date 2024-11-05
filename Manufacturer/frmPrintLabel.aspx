<%@ Page Title="View Printed Labels" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master"
    AutoEventWireup="true" CodeFile="frmPrintLabel.aspx.cs" Inherits="frmPrintLabel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(23).addClass("active");
        $(".accordion2 div.open").eq(20).show();

        $(".accordion2 p").click(function () {
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>View Pasted Labels</h4>
                            </header>
                
                <div class="card-body card-body-nopadding">
                  <div id="newMsg" runat="server" style="width: 91%;">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                    <div class="form-row">
                        <div class="form-group col-lg-5">
                            <span class="req">*</span><label>Product Name</label>
                              <asp:DropDownList ID="ddlProduct" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                    AutoPostBack="true" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-5">
                            <span class="req">*</span><label>Select Option</label>
                            <asp:DropDownList ID="ddlBatch" runat="server" CssClass="form-control form-control-sm" OnSelectedIndexChanged="ddlBatch_SelectedIndexChanged"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-2 mt-4">
                            <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary mr-2" ImageUrl="~/Content/images/search_rec.png" OnClick="ImgSearch_Click" ToolTip="Search" />
                            <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click" ToolTip="Refresh" />
                        </div>
                        </div>
                    
                    <%--  <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Dealer" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Dealer" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>--%>

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
              <asp:GridView ID="GrdPrintLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                    EmptyDataText="Record Not Found"  BorderColor="transparent" >
                    <Columns>
                        <asp:TemplateField HeaderText="Series Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsername" runat="server" Text='<%# Bind("SerialCode") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code 1">
                            <ItemTemplate>
                                <asp:Label ID="lblcode" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                    </Columns>
                 <%--   <PagerStyle HorizontalAlign="Right"  CssClass = "pagination"  />
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
                <h4>
                <%--    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found<span class="small_font"> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h4>--%>
                
            </div>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
