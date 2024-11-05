<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddCoupons.aspx.cs" Inherits="Manufacturer_AddCoupons" %>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="col-lg-12 card card-admin form-wizard profile">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">Add/Edit Coupons</i></h4>
                            </header>
             <div id="DivNewMsg" runat="server" style="width: 88%;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                <div class="card-body card-body-nopadding">
                  
                  <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Coupon Name</label>
                          <asp:DropDownList ID="ddlCoupon" runat="server" CssClass="form-control form-control-sm">
                                                </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="ddlCoupon" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                         
                        </div>
                      <div class="form-group col-lg-6">
                          <span class="req">*</span>
                          <label>Coupon Qunatity</label>
                         <asp:TextBox ID="txtQty" runat="server" CssClass="form-control form-control-sm"  MaxLength="50"
                                                    onchange="checkCourior(this.value)"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="txtQty">
                                                </asp:RequiredFieldValidator>
                      </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>DateFrom</label>
                             <asp:TextBox ID="txtdtfrom" runat="server" CssClass="form-control form-control-sm" Text="" MaxLength="50"></asp:TextBox>
                                </div> <div class="form-group col-lg-6">              
                                     <span class="req">*</span><label>Date To</label>
                                                <asp:TextBox ID="txtdtto" runat="server" CssClass="form-control form-control-sm" Text="" MaxLength="50"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"  ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="txtdtfrom">
                                                </asp:RequiredFieldValidator>
                          <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="LOY"
                                                    ControlToCompare="txtdtfrom" ControlToValidate="txtdtto" ForeColor="Red" Type="Date"
                                                    Operator="GreaterThan" ErrorMessage="Date To is Less Than Date From"></asp:CompareValidator>
                                                <cc1:CalendarExtender ID="CalendarExtender7" runat="server" TargetControlID="txtdtfrom"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtdtfrom"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server" TargetControlID="txtdtfrom"
                                                    WatermarkText="Date From..">
                                                </cc1:TextBoxWatermarkExtender>
                                                <cc1:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtdtto"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtdtto"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server" TargetControlID="txtdtto"
                                                    WatermarkText="Date To..">
                                                </cc1:TextBoxWatermarkExtender>
                        </div>
                       
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                               <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                            </div>
                         <div class="form-group col-lg-4">
                           <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" ValidationGroup="PR1" CssClass="btn btn-primary float-right mb-0"
                                                runat="server" Text="Save" />
                         </div>
                         <div class="form-group col-lg-2">  
                             <asp:Button ID="btnReset" OnClick="btnReset_Click"
                                                    CausesValidation="false" CssClass="btn btn-primary float-right mb-5" runat="server" Text="Cancel" />

                         </div>
                         </div>
                </div>

                 <br /> <br />

            </div>
                
               
                </div>
            </div>
         </div>
     <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
</asp:Content>
