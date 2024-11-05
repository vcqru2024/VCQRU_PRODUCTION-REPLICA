<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="Frmcodeverification.aspx.cs" Inherits="frmManfEnquiry" Title="Code Verification Details" %>

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
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Code Detail</h4>
                    </header>

                    <div class="card-body card-body-nopadding">

                         <div class="form-row">
                            
                           <div class="form-group col-lg-12">

                                 <asp:DropDownList ID="ddlservice" runat="server" AutoPostBack="true" CssClass="form-control form-control-sm" OnSelectedIndexChanged="ddlservice_SelectedIndexChanged" />
                                 </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-lg-6">
                                 <label>Product Name</label>
                                <%--<asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" />--%>
                                <asp:ListBox ID="liproname" runat="server" CssClass="form-control form-control-sm" SelectionMode="Multiple"  />
                            </div>
                           <div class="form-group col-lg-6">
                                      <label>Location</label>                          
                                <asp:ListBox ID="listate" runat="server" CssClass="form-control form-control-sm" SelectionMode="Multiple" />
                            </div>
                        </div>
                      
                         <div class="form-row">
                            <div class="form-group col-lg-6">
                                <asp:DropDownList ID="ddlRemarks" runat="server" CssClass="form-control form-control-sm">
                                   
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-6">
                                
                                <asp:TextBox ID="Mobile" runat="server" CssClass="form-control form-control-sm" placeholder="Mobile No." />
                            </div>
                        </div>
                              <div class="form-row">
                          
                            <div class="form-group col-lg-6">
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm">
                                    <asp:ListItem Text="--Select Status--"></asp:ListItem>
                                    <asp:ListItem Text="Success"></asp:ListItem>
                                    <asp:ListItem Text="Unsuccess"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                                  <div class="form-group col-lg-6">
                                <%--<asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control form-control-sm"/>--%>
                                    
                                
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-lg-6">
                                
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                    ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateFrom" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                            </div>
                            <div class="form-group col-lg-6">
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateTo" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                    ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateTo" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                            </div>
                        </div>
                         <div class="form-row">
                            <div class="form-group col-lg-6">
                               
                            </div>
                            <div class="form-group col-lg-6" style="text-align-last:end">
                                
                               <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Code Details" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" Width="190" CssClass="btn btn-primary" style="margin-left: 35px;" />
                            </div>
                        </div>

                        <%--<div class="form-row">
                            <div class="form-group col-lg-6">
                                <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                    ToolTip="Search" OnClick="ImgSearch_Click" />
                                <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                    OnClick="ImgRefresh_Click" />
                            </div>--%>
                            <div class="form-group col-lg-6" style="z-index:999999">
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
                        
                    </div>
                    
                </div>
                <%--------------------------------------------Removed----------------------%>
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
