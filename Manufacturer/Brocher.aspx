<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Brocher.aspx.cs" Inherits="Manufacturer_Brocher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Add Brochure </h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <%--  <div class="form-row">
                                

                            </div>--%>
                           <div class="form-group col-lg-6">
                                <asp:Label ID="lblProductImage" CssClass="col-md-2 control-label" runat="server" Text="Brochure"></asp:Label>
                                <div>
                                    <asp:FileUpload 
                                        ID="ProductImageUpload" 
                                        CssClass="form-control" 
                                        runat="server" 
                                        accept=".pdf" />
        
                                    <!-- RequiredFieldValidator to ensure a file is uploaded -->
                                    <asp:RequiredFieldValidator 
                                        ID="RequiredFieldValidatorProductImageUpload" 
                                        runat="server" 
                                        ValidationGroup="formitem" 
                                        CssClass="text-danger" 
                                        ErrorMessage="*Please Upload Brochure (PDF)" 
                                        ControlToValidate="ProductImageUpload" 
                                        ForeColor="Red">
                                    </asp:RequiredFieldValidator>

                                    <!-- RegularExpressionValidator to ensure the uploaded file is a PDF -->
                                    <asp:RegularExpressionValidator 
                                        ID="RegexValidatorProductImageUpload" 
                                        runat="server" 
                                        ControlToValidate="ProductImageUpload" 
                                        CssClass="text-danger" 
                                        ErrorMessage="*Please upload a valid PDF file" 
                                        ValidationExpression="^.*\.(pdf)$" 
                                        ForeColor="Red" 
                                        ValidationGroup="formitem">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <%--                            <div class="form-row">
                                

                            </div>--%>
                            <div class="form-group">
                                <div class="col-md-2 "></div>
                                <div class="col-md-6 ">

                                    <asp:Button ID="btnAddImage" CssClass="btn btn-success " runat="server" Text="Add Pdf file" ValidationGroup="formitem" OnClick="btnAddImage_Click" />
                                    <%--<asp:Button ID="btnCancel" runat="server" Text="CANCEL" CausesValidation="false" OnClick="btnCancel_Click" ValidationGroup="false" CssClass="btn btn-danger" />--%>
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="table-responsive table_large">
                                <asp:GridView ID="ImageGrid" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                    DataKeyNames="Id,Brochure" EmptyDataText="Record Not Found" BorderColor="transparent"
                                    AllowPaging="false" PageSize="21" Font-Size="Smaller" OnRowDeleting="ImageGrid_RowDeleting">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" HeaderText="Actions" />
                                      <asp:TemplateField HeaderText="Brochure">
                                            <ItemTemplate>
                                                <asp:Label ID="lblImage" runat="server" Text='<%# Bind("brochure") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="File">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDownloadBill" runat="server" OnClick="btnDownloadBill_Click" ToolTip="Download image file">
                        <img src="../images/download.png" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>


                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

