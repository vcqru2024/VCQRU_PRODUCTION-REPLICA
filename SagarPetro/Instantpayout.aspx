<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Instantpayout.aspx.cs" Inherits="SagarPetro_Instantpayout" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                   <%-- <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>--%>
                </ProgressTemplate>
            </asp:UpdateProgress>
<div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
            <div class="card card-admin form-wizard profile box_card">
                <header class="card-header">
                                <h4 class="card-title">Instant Payout Details</h4>
                            </header>
                
           
            
                <div class="card-body card-body-nopadding">
                  <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                     <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                </p>
            </div>
           <%-- akash --%>
                    <style>
                        .report-overview  .card-title{
                            text-transform:uppercase;
                        }
                         .report-overview .box-card{
                               padding: 8px;
                            text-transform: capitalize;
                            border-radius: 4px;
                         }
                        .report-overview .one{
                            background-color: rgb(108 117 125 / 25%);
                            color:var(--secondary);
                        }
                        .report-overview  .two{
                            background-color: rgb(40 167 69 /25%);
                            color:#28a745;
                        }
                        .report-overview .three{
                            background-color: rgb(220 53 69 / 25%);
                            color:var(--danger);
                        }
                        .report-overview  .four{
                            background-color: rgb(255 193 7 / 25%);
                            color:var(--warning);
                        }
                        .report-overview  .box-card h6{
                            margin-bottom:4px;
                            font-weight: 700;
                        }
                        .report-overview .box-card p{
                            margin-bottom:0;
                        }
                        
                    </style>
                <div class="report-overview">
                    <div class="row">
                        <div class="col-lg-6 mb-3">
                            <%--<div class="card">
                                <div class="card-body p-2">
                                    
                                </div>
                            </div>--%>
                            <h5 class="card-title">Code Details</h5>
                                    <div class="row g-2">
                                        <div class="col">
                                            <div class="box-card one">
                                                <h6>Total</h6>
                                                <p><asp:Label ID="lbltotalcode" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col">
                                            <div class="box-card two">
                                                 <h6>Success</h6>
                                                <p><asp:Label ID="lblsuccesscode" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col">
                                            <div class="box-card three">
                                                 <h6>Failure</h6>
                                                <p><asp:Label ID="lblfailurecode" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col"> 
                                            <div class="box-card four">
                                                 <h6>Pending</h6>
                                                <p><asp:Label ID="lblpendingcode" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                    </div>
                        </div>
                         <div class="col-lg-6 mb-3">
                           <h5 class="card-title">Amount Details</h5>
                                    <div class="row g-2">
                                        <div class="col">
                                            <div class="box-card one">
                                                <h6>Total</h6>
                                                <p>₹ <asp:Label ID="lbltotalamount" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col">
                                            <div class="box-card two">
                                                 <h6>Success</h6>
                                                <p>₹ <asp:Label ID="lblsuccessamount" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col">
                                            <div class="box-card three">
                                                 <h6>Failure</h6>
                                                <p>₹ <asp:Label ID="lblfailureamount" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                         <div class="col"> 
                                            <div class="box-card four">
                                                 <h6>Pending</h6>
                                                <p>₹ <asp:Label ID="lblpendingamount" runat="server"></asp:Label></p>
                                            </div>
                                        </div>
                                    </div>
                        </div>
                    </div>
                </div>
            <%-- end --%>
                    <div class="row">
                        <div class="col">
                               <%-- <label>From</label>--%>
                             <asp:TextBox ID="txtDateFrom" runat="server"  CssClass="form-control"></asp:TextBox>
                             <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                        </div>
                             <div class="col">
                                 <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control"></asp:TextBox>
                                   <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                                 <%--<label>To</label>--%>
                             </div>
                        <div class="col">
                            <asp:TextBox ID="txtmob" runat="server" placeholder="Enter 10 digit Mobile Number" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col" style="display:none">
                            <asp:DropDownList ID="ddlst" runat="server" 
                                        CssClass="form-control">
                                <asp:ListItem Text="All" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Accepted"></asp:ListItem>
                                <asp:ListItem Text="Success"></asp:ListItem>
                                <asp:ListItem Text="FAILURE"></asp:ListItem>
                                    </asp:DropDownList>
                              </div>
                        <div class="col">
                              <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                        OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                        </div>
                            <div class="col">
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
                   
                   <div class="card-admin">
                       <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4> 
                                                         <p class="m-0"><span>  Note:  </span>* To view more than 100 records, Download Details.
                                                             ** Real time transaction status will be updated in 10 mins.
                                                         </p>
                     <div class="background-section-form form-row">
												 <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                
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
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
           <div class="app-table">
               <div class="table-responsive">
                <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                     EmptyDataText="Record Not Found" BorderColor="transparent" OnPageIndexChanging="GrdLabel_PageIndexChanging">
                   <Columns>
                        <asp:TemplateField HeaderText="Sr No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Consumer Name">
                            <ItemTemplate>
                                <asp:Label ID="lblConsumerName" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile No">
                            <ItemTemplate>
                                <asp:Label ID="lblMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code1">
                            <ItemTemplate>
                                <asp:Label ID="lblRec_code1" runat="server" Text='<%# Bind("Rec_code1") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code2">
                            <ItemTemplate>
                                <asp:Label ID="lblRec_code2" runat="server" Text='<%# Bind("Rec_code2") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Account No">
                            <ItemTemplate>
                                <asp:Label ID="lblAccountNo" runat="server" Text='<%# Bind("AccountNo") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account Holder Name">
                            <ItemTemplate>
                                <asp:Label ID="lblAccountHolderName" runat="server" Text='<%# Bind("AccountHolderName") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Old Bal.">
                            <ItemTemplate>
                                <asp:Label ID="lblOldBal" runat="server" Text='<%# Bind("OldBal") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Charge Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("TCharge_Amount") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Gst Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("GstAmount") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="New Bal.">
                            <ItemTemplate>
                                <asp:Label ID="lblNewBal" runat="server" Text='<%# Bind("NewBal") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Order Id">
                            <ItemTemplate>
                                <asp:Label ID="lblorderid" runat="server" Text='<%# Bind("orderid") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bank status">
                            <ItemTemplate>
                                <asp:Label ID="lblpstatus" runat="server" Text='<%# Bind("BankStatus") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bank Remarks">
                            <ItemTemplate>
                                <asp:Label ID="lblComment" runat="server" Text='<%# Bind("BankRemark") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Final status">
                            <ItemTemplate>
                                <asp:Label ID="lblInqStatus" runat="server" Text='<%# Bind("FinalStatus") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Final Remarks">
                            <ItemTemplate>
                                <asp:Label ID="lblInqComment" runat="server" Text='<%# Bind("FinalRemark") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date & time">
                            <ItemTemplate>
                                <asp:Label ID="lblpdate" runat="server" Text='<%# Bind("ReqDate") %>'></asp:Label><br />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="15%" />                           
                        </asp:TemplateField>

                                                
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
    </div>
</asp:Content>

