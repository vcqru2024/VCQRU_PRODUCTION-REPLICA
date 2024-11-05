<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="frmManfEnquiryW.aspx.cs" Inherits="frmManfEnquiryW" Title="Enquiry Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(36).addClass("active");
        $(".accordion2 div.open").eq(30).show();

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
    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; top: 0px; z-index: 999;"
                class="NewmodalBackground">
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
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Warranty Details</h4> 
                    </header>
             

                       
                    <div class="card-body card-body-nopadding">
                         <div class="form-row" style="margin-top: 10px;">
                            <div class="form-group col-lg-3">
                                <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                            </div>
                        <div class="form-row" style="display:none">
                            <div class="form-group col-lg-2">
                                <%--<label>Product Name</label>--%>
                                <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" />
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm">
                                    <asp:ListItem Text="--Selest Status--"></asp:ListItem>
                                    <asp:ListItem Text="Success"></asp:ListItem>
                                    <asp:ListItem Text="Unsuccess"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                    ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateTo" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                    ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                    ToolTip="Search" OnClick="ImgSearch_Click" />
                                <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                    OnClick="ImgRefresh_Click" />
                            </div>
                        </div>
                     
                       
                        <div class="form-row">
                            
                            <div class="form-group col-lg-6">
                                <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                    TargetControlID="txtDateFrom" WatermarkText="Enquiry From">
                                </cc1:TextBoxWatermarkExtender>
                                <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                    WatermarkText="Enquiry To">
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
                            <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                        </div>
                        <div class="col-lg-2">
                            <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                ID="lblToatalPoints" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" Visible="false">
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
                    <asp:GridView ID="GrdEnquiry" runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblWarrenty table-bordered"
                        EmptyDataText="Record Not Found" BorderColor="transparent">
                        <Columns>
                            <asp:TemplateField HeaderText="Purchase Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblcompname" runat="server" Text='<%# Eval("purchasedate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name (Product Id) ">
                                <ItemTemplate>
                                    <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                    <br />
                                    (<asp:Label ID="lblproductnameid" runat="server" Text='<%# Bind("Pro_ID") %>'></asp:Label>)
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="Enquiry Mode">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("ModeOfInquiry") %>'></asp:Label>
                            </ItemTemplate>
                            
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>   --%>

                            <asp:TemplateField HeaderText="Complete Code">
                            <ItemTemplate>
                                <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("code") %>'></asp:Label>
                            </ItemTemplate>
                            
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mobile No">
                                <ItemTemplate>
                                    <asp:Label ID="lblnoCodes" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Is Warranty">
                                <ItemTemplate>
                                    <asp:Label ID="lblactudate23411" runat="server" Text='<%# Convert.ToInt16(Eval("WarrantyDurationMonth")) > 0?"Yes":"No" %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Warranty Expiration Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%#Bind("Exp_Date","{0:dd/MM/yyyy}")%>'></asp:Label>
                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Warranty Period (months)">
                                <ItemTemplate>
                                    <%--   <asp:Label ID="lblstatussucc" runat="server" Text='<%# Bind("Successstatus") %>'></asp:Label>--%>
                                    <asp:Label ID="lblactudate23334" runat="server" Text='<%#Eval("WarrantyDurationMonth")%>'></asp:Label>
                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Bill Number">
                                <ItemTemplate>
                                    <asp:Label ID="lblvehicleno" runat="server" Text='<%#Eval("Bill Number")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Device">
                                <ItemTemplate>
                                    <asp:Label ID="lblBillno" runat="server" Text='<%#Eval("Vehicle Number")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>--%>

                             <asp:TemplateField HeaderText="Product Image">
                                <ItemTemplate>
                                  <a href='<%#Eval("[Product Image]")%>' runat="server" target="_blank" >View</a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>

                           
                           

                            
                             <asp:TemplateField HeaderText="Bill Invoice">
                                <ItemTemplate>
                                     <a href='<%#Eval("[Bill Invoice]")%>' runat="server" target="_blank" >View</a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="User Comment">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserComment" runat="server" Text='<%#Eval("User Comment")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>

                            <%--<asp:TemplateField HeaderText="Code 1">
                            <ItemTemplate>
                                <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("Received_Code1") %>'></asp:Label>
                            </ItemTemplate>
                            
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code 2">
                            <ItemTemplate>
                                <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%# Bind("Received_Code2") %>'></asp:Label>
                            </ItemTemplate>
                            
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblstatussucc" runat="server" Text='<%# Bind("Successstatus") %>'></asp:Label>
                            </ItemTemplate>
                            
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>--%>
                        </Columns>
                        <%--<PagerStyle HorizontalAlign="Center" CssClass="pagination" />
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
                        </tr>
                    </table>
                </h4>--%>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
