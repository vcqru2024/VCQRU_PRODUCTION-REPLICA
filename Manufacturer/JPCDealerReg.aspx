<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="JPCDealerReg.aspx.cs" Inherits="Manufacturer_JPCDealerReg" %>

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
       function SetFocusOnEditTextBox() {
       
           var txt_dealercity = document.getElementById('<%= GridView2.ClientID %>').querySelector('.editTextBoxClass');
           if (txt_dealercity) {
               txt_dealercity.focus();
            }
        }
    
    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


     <script type="text/javascript">
         // Add an entry to the browser's history
         history.pushState({}, '', '../Manufacturer/JPCDealerReg.aspx');

         // Listen for the popstate event (back/forward button click)
         window.addEventListener('popstate', function (event) {
             // Redirect to a specific page when the back button is clicked
             //window.location.href = '/specific-page';
             location.reload();
         });
     </script>


    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>JPC Dealer Registration</h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" Visible="false" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row" id="btnsection" runat="server">
                                <div class="col-md-4">
                                     <asp:Button ID="btnnewregistration" Text="Register New Dealer" OnClick="btnnewregistration_Click" CssClass="btn btn-primary" runat="server" />
                                </div>
                                 <div class="col-md-4">
                                      <asp:Button ID="btneditdealer" Text="Edit/Download Dealer" OnClick="btneditdealer_Click" CssClass="btn btn-info" runat="server" />
                                </div>
                               
                            </div>
                            <br />
                            <div id="filtersection" runat="server" visible="false">
                                  <div class="form-row" >
                                    <div class="form-group col-lg-3" style="display:none">
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-3" style="display:none">
                                        <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtmobileno" runat="server" MaxLength="10" placeholder="Mobile NO" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:ImageButton ID="imgsearch" OnClick="imgsearch_Click" runat="server" CssClass="btn btn-primary" ImageUrl="../Content/images/search_rec.png" />
                                        <asp:ImageButton ID="imgreset" OnClick="imgreset_Click" runat="server" CssClass="btn btn-success" ImageUrl="../Content/images/reset.png" />
                                    </div>
                                </div>
                                <div class="form-row">

                                   <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                </div>
                            </div>
                           
                                <br />

                            <div class="row" runat="server" id="divregistration" visible="false">


                                <div class="col-lg-3">
                                   <%-- <asp:Label CssClass="small_font" runat="server">GST No</asp:Label>--%>
                                    <asp:TextBox class="form-control form-control-sm" MaxLength="15" runat="server" placeholder="Gst No" value="" ID="txtPan" />
                                       <asp:RegularExpressionValidator ID="rgxgstnumber" maxlenth="15" runat="server" ControlToValidate="txtPan"
                                        ValidationExpression="[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"
                                        ErrorMessage="Invalid GST Number." ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>

                                <div class="col-lg-3">
                                    <%--<asp:Label CssClass="small_font" runat="server">Dealer Name</asp:Label>--%>
                                    <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Dealer Name" value="" ID="txtDealer" />
                                   
                                </div>

                                <div class="col-lg-2">
                                    <%--<asp:Label CssClass="small_font" runat="server">Mobile No</asp:Label>--%>
                                    <asp:TextBox class="form-control form-control-sm" runat="server" MaxLength="10" placeholder="Mobile No" value="" ID="txtMobile" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtMobile"
                                        ValidationExpression="^[0-9]{10}$"
                                        ErrorMessage="Invalid Mobile Number." ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>

                                <div class="col-lg-2">
                                   <%-- <asp:Label CssClass="small_font" runat="server">Adhar No</asp:Label>--%>
                                    <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Adhar No" MaxLength="12" value="" ID="txtAdhar" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtAdhar"
                                        ValidationExpression="^[0-9]{12}$"
                                        ErrorMessage="Invalid Aadhar Number." ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>

                                 <div class="col-lg-2">
                                   <%-- <asp:Label CssClass="small_font" runat="server">City</asp:Label>--%>
                                    <asp:TextBox  class="form-control form-control-sm" runat="server" placeholder="City" MaxLength="12" value="" ID="txtaddress" />
                                </div>

                                <div class="col-lg-2">

                                    <asp:Button ID="btnsave" OnClick="Button1_Click" Style="margin-top: 17%;" class="btn btn-primary mr-2" runat="server" Text="Submit" />
                                </div>



                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped tblSorting table-bordered"
                                        EmptyDataText="Record Not Found" BorderColor="transparent">
                                        <HeaderStyle CssClass="tab-header" />

                                    </asp:GridView>
                                </div>


                            </div>
                            <div class="row">
                               

                                <div class="col-md-12">
                                    <asp:GridView ID="GridView2" runat="server" CssClass="table table-striped tblSorting table-bordered"
                                        EmptyDataText="Record Not Found" OnRowDataBound="GridView2_RowDataBound" BorderColor="Transparent" AutoGenerateColumns="False" DataKeyNames="DealerCode" OnRowEditing="GridView2_RowEditing" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowUpdating="GridView2_RowUpdating"  AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView2_PageIndexChanging">
                                        <HeaderStyle CssClass="tab-header" />
                                        <Columns>
                                            
                                           <%-- <asp:TemplateField HeaderText="Dealerid">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lbldealerid" runat="server" Text='<%# Eval("dealercode") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldealerid" runat="server" Text='<%# Bind("dealercode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Dealer Code">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lbldealercode" runat="server" Text='<%# Eval("dealercode") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldealercode" runat="server" Text='<%# Bind("dealercode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dealer Name">
                                                <EditItemTemplate>
                                                    <asp:Label ID="txt_dealername" runat="server" Text='<%# Bind("dealername") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("dealername") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dealer Mobile No">
                                                <EditItemTemplate>
                                                    <asp:Label ID="lbldealermobile" runat="server" Text='<%# Eval("mobileno") %>'></asp:Label>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldealermobile" runat="server" Text='<%# Bind("mobileno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txt_dealercity" runat="server"  CssClass="editTextBoxClass" Text='<%# Bind("city") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("city") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action" ShowHeader="False">
                                                    <edititemtemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-primary" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                    </edititemtemplate>
                                                    <itemtemplate >
                                                        <asp:LinkButton ID="LinkButton3" runat="server" class="btn btn-primary"   CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                            
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                  <div class="form-group col-lg-6">
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

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
