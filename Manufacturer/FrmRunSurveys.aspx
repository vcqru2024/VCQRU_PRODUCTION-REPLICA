<%@ Page Title="Run Surveys Details" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master"
    AutoEventWireup="true" CodeFile="FrmRunSurveys.aspx.cs" Inherits="FrmRunSurveys" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(35).addClass("active");
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
            <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i> Run Surveys Details</h4>
                            </header>
                <div id="newMsg" runat="server" style="width: 91%;">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
          
           <div class="card-body card-body-nopadding">
                  
                    <div class="form-row">
                        <div class="form-group col-lg-4">
                           <%-- <label>Product Name</label>--%>                                                            
                              <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlproduct_SelectedIndexChanged" />
                        </div>
                        <div class="form-group col-lg-3">
                              <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm" ></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server"  ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="ss" />
                        </div>
                             <div class="form-group col-lg-3">
                               <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control form-control-sm" Visible="true"></asp:TextBox>
                                   <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateTo" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="ss" />
                             </div>
                         <div class="form-group col-lg-2">
                              <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="ss"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton CssClass="btn btn-success refreses_field" ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png"
                                            ToolTip="Reset" OnClick="ImgRefresh_Click" />
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
                                        TargetControlID="txtDateFrom" WatermarkText="Date From">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                        WatermarkText="Date To">
                                    </cc1:TextBoxWatermarkExtender>
                             </div>
                    </div>
                    
               <div class="card-admin form-wizard medias">
                     <div class="row background-section-form">
												<div class="col-lg-6">
													<h4 class="mb-0">Record's Found<span> <asp:Label ID="lblcount" runat="server"></asp:Label>
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                     <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                </div>
												<div class="mt-b col-lg-2">
                                                     <asp:ImageButton ID="btnExceldwn" runat="server" CssClass="float-right" OnClick="btnExceldwn_Click" ImageUrl="~/Content/images/excel.png" ToolTip="Download Excel" /><%--ToolTip="Save" --%>
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
                       <div class="table-responsive table_large">
                       <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    EmptyDataText="Record Not Found" BorderColor="transparent" OnRowDataBound="GrdVw_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Survey Date">
                            <ItemTemplate>
                                <asp:Label ID="lblCreateddate" runat="server" Text='<%# Bind("Createddate","{0:dd/MMM/yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                       <%-- <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>--%>
                  <%--      <asp:TemplateField HeaderText="Code1">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                 <asp:Label ID="Label1" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="25%" />
                        </asp:TemplateField>                        
                      <%--  <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>    
                         <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                               
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>  --%>                    
                        <asp:TemplateField HeaderText="Question">
                            <ItemTemplate>
                                   <asp:Label ID="lblnetwork" runat="server" Text='<%# Bind("Question") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Left" Width="65%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Rate">
                            <ItemTemplate>
                                   <asp:Label ID="lblnetwork" runat="server" Text='<%# Bind("intRate") %>'></asp:Label>
                                  <%-- <asp:Label Text='<%#Eval("Branchid")%>' ID="lblBranchid" Visible="false" runat="server" ></asp:Label>
                                                    <asp:LabelText='<%#Eval("Semesterid")%>' ID="lblSemesterid" Visible="false" runat="server" ></asp:Label>--%> 
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                       <%-- <asp:TemplateField HeaderText="Code 2">
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
                        </asp:TemplateField>--%>
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
            <div class="grid_container">
                
                
                <asp:GridView ID="GVRunsurvey" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                    PageSize="25" OnPageIndexChanging="GrdVw_PageIndexChanging">
                    <Columns>
                        <%--<asp:TemplateField HeaderText="Survey Date">
                            <ItemTemplate>
                                <asp:Label ID="lblcompname" runat="server" Text='<%# Bind("EntryDate","{0:ddd, MMM d, yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvname" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="MobileNo">
                            <ItemTemplate>
                                <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Surveys Text">
                            <ItemTemplate>
                                <asp:Label ID="lblnetwork" runat="server" Text='<%# Bind("SurveystypeText") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>                       
                        <%--<asp:TemplateField HeaderText="Code 1">
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
                        </asp:TemplateField>--%>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                
            </div>
             </div>
       <%-- </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btnExceldwn" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
