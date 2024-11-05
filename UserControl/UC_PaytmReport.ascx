<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UC_PaytmReport.ascx.cs" Inherits="UserControl_UC_PaytmReport" %>

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
 <style>
   
   
      .ajax__calendar_today{
         padding:0px 0px 0px 0px;
    }
      .ajax__calendar_dayname{
         padding:0px 0px 0px 0px;
    }
</style>
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
<div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
            <div class="card card-admin form-wizard profile box_card">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Paytm Report</h4>
                            </header>
                
           
            <div id="newMsg" runat="server" style="width: 91%;">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                     <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                </p>
            </div>
                <div class="card-body card-body-nopadding">
                  
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                               <%-- <label>From</label>--%>
                             <asp:TextBox ID="txtDateFrom" runat="server"  CssClass="form-control form-control-sm"></asp:TextBox>
                             <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                        </div>
                             <div class="form-group col-lg-3">
                                 <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                   <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                                 <%--<label>To</label>--%>
                             </div>
                        <div class="form-group col-lg-2">
                            <asp:TextBox ID="txtmob" runat="server" placeholder="Enter 10 digit Mobile Number" CssClass="form-control form-control-sm"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-2">
                            <asp:DropDownList ID="ddlst" runat="server" 
                                        CssClass="form-control form-control-sm"> 
                                <asp:ListItem Text="All" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Accepted"></asp:ListItem>
                                <asp:ListItem Text="Success"></asp:ListItem>
                                <asp:ListItem Text="FAILURE"></asp:ListItem>
                                    </asp:DropDownList>
                              </div>
                        <div class="form-group col-lg-2">
                              <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                        OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" CssClass="btn btn-success refreses_field" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                        </div>
                            <div class="form-group col-lg-3">
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
                  
                        
                    <%-- <div class="form-row">
                        <div class="form-group col-lg-6">
                            &nbsp;
                            </div>
                       </div>--%>
                    <div class="card-admin form-wizard medias">
                      
                     <div class="background-section-form form-row">
												<div class="col-lg-6">
													<h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
                                                    <p class="m-0"><span>  Note:  </span>To view more than 100 records, Download Details.</p>
												</div>
                                                <div class="col-lg-4"> 
                                                     <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                    
                                                </div>
                          <div class="col-lg-2 text-right">
                               <asp:Button ID="btnDownloadExcel" runat="server" Text="Download" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" CssClass="btn btn-primary" />
                              </div>
												<div class="col-lg-2">
                                                    <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                                         Visible="false" >
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                      <%--  <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>--%>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
           <div class="table-responsive table_large">
                <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                     EmptyDataText="Record Not Found" BorderColor="transparent" OnPageIndexChanging="GrdLabel_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblentrydate" runat="server" Text='<%# Bind("pdate") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Beneficiary Account (Mobile no)">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("mobileno") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblsize2" runat="server" Text='<%# Bind("pstatus") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <%-- <asp:TemplateField HeaderText="Wallet Balance">
                            <ItemTemplate>
                                <asp:Label ID="lblsize3" runat="server" Text='<%# Bind("WBalance") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>--%>
                                                
                    </Columns>
                    <%--<PagerStyle HorizontalAlign="Center" CssClass="pagination" />
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
      </div>
    </div>