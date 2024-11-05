<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Login Summary" CodeFile="FrmStatusReport.aspx.cs" Inherits="FrmStatusReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(37).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        /*tab class*/.ajax__tab_xp .ajax__tab_tab, .ajax__tab_xp .ajax__tab_outer, .ajax__tab_xp .ajax__tab_inner
        {
            /*background: url(../Content/images/menu_over.png) repeat-x !important;*/
            background: none !important;
            height: 20px !important;
            padding: 0 !important;
            margin: 0;
            color: #ffffff;
            font-family: Arial;
            font-size: 10pt;
            font-weight: bold;
        }
        .ajax__tab_xp .ajax__tab_inner
        {
            /*background: url(images/menu_over.png) repeat-x !important;*/
            height: 20px !important;
            -webkit-border-radius: 10px 10px 0px 0px !important;
            -moz-border-radius: 10px 10px 0px 0px !important;
            border-radius: 10px 10px 0px 0px !important;
            margin: 0;
            color: #ffffff;
        }
        .ajax__tab_xp .ajax__tab_outer
        {
            background: url(../Content/images/tab_bg.png) repeat-x !important;
            height: 20px !important;
            margin: 0;
            color: #ffffff;
            margin-right: 5px;
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
            border: 1px solid #004795;
            border-bottom: none;
            margin-top: 7px;
            padding: 8px 8px 5px 8px !important;
        }
        /*tab class close*//*tab activ class*/.ajax__tab_xp .ajax__tab_active .ajax__tab_inner
        {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_tab, .ajax__tab_xp .ajax__tab_active .ajax__tab_inner, .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            background: #ffffff !important;
            height: 20px;
            padding: 0px;
            margin: 0;
            color: #333333;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            margin-right: 5px;
            border: 1px solid #999;
            border-bottom: none;
        }
        /*tab activ class Close*/</style>
    <%--<script type="text/javascript" src="js/jquery-1.7.2.min.js" language="javascript">
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a style="display: block"></a>
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Account Login Summary</h4>
                            </header>           
            <div id="NewMsgpop" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label></p>
                  <br />
            </div>
                 <div class="card-body card-body-nopadding">
                  <div class="card-admin form-wizard medias">
                     <div class="row background-section-form">
												<div class="col-lg-6">
													<h4>Record's Found<span> <asp:Label ID="lblcount" runat="server"></asp:Label>
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                     <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                  
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
                       <asp:GridView ID="GrdLoginSummary" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                        EmptyDataText="Record Not Found" BorderColor="transparent" >
                        <Columns>
                            <asp:TemplateField HeaderText="S.No">
                                <ItemTemplate>
                                    <%--<%=++index %>--%>
                                    <asp:Label ID="lbllosno" runat="server" Text='<%# Bind("sno") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Login Date Time">
                                <ItemTemplate>
                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("Login_Date","{0:MMM dd, yyyy hh:mm:ss tt}") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Logout Date Time">
                                <ItemTemplate>
                                    <asp:Label ID="lblactudate" runat="server" Text='<%# Bind("Logout_Date","{0:MMM dd, yyyy hh:mm:ss tt}") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IP Address">
                                <ItemTemplate>
                                    <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("Dial_Mode") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="30%" />
                            </asp:TemplateField>
                        </Columns>
                       <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
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
            <%--<fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButton" runat="server" DefaultButton="ImgSearch">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>                            
                            <td align="right" width="10%" >
                                <strong>From Date:</strong>
                            </td>
                            <td width="18%" >
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="right" width="10%" >
                                <strong>To Date:</strong>
                            </td>
                            <td width="18%" >
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td>
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/images/search_rec.png"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>--%>
            <div class="grid_container">
                <%--<h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>
                                    )</span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="10">Last 10 Rows</asp:ListItem>
                                        <asp:ListItem Value="15">Last 15 Rows</asp:ListItem>
                                        <asp:ListItem Value="20">Last 20 Rows</asp:ListItem>
                                        <asp:ListItem Value="25">Last 25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">Last 50 Rows</asp:ListItem>
                                        <asp:ListItem Value="51">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>--%>
                <div style="overflow: auto; height: 1000px;">
                    
                </div>
            </div>
      <%--  </ContentTemplate>
        <Triggers>
            
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
