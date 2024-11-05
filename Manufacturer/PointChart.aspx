<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="PointChart.aspx.cs" Inherits="Manufacturer_PointChart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Point Chart </h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                          <%--  <div class="form-row">
                                

                            </div>--%>
                            <div class="form-row">
                                <div class="form-group col-lg-4">

                                    <asp:Label ID="lblCategory" CssClass="col-md-2 control-label " runat="server" Text="Catagory Name"></asp:Label>
                                         
                                    <div class="col-lg-12">
                                        <asp:DropDownList ID="ddlCategory" CssClass="form-control" runat="server">
                                            <asp:ListItem Text="--Select Category--" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Resins" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Shiners & Waxes" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Sealers" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Epoxy Resins" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Marble Glues" Value="5">Marble Glue</asp:ListItem>
                                            <asp:ListItem Text="Marble Densifiers" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="Polishing Powders" Value="7"></asp:ListItem>
                                        </asp:DropDownList> 
                                           <%--<div class="col-lg-12" style="text-align:left;">--%>
                                        <div style="margin-top:10px"></div>
                                             <asp:RequiredFieldValidator 
                                               ID="RequiredFieldValidator1"   runat="server" ValidationGroup="formitem" CssClass="text-danger"  Style="margin-top:12px; font-weight:bold;" ErrorMessage="*Please Select Category"  ControlToValidate="ddlCategory"  InitialValue="0" ForeColor="Red">
                                           </asp:RequiredFieldValidator>
                                   
                                     <%--  </div>--%>
                                            </div>
                                     
                                    
                                </div>
                                     <div class="form-group col-lg-6">
                                <asp:Label ID="lblProductImage" CssClass="col-md-2 control-label" runat="server" Text="Image"></asp:Label>
                                <div>                                        
                                    <asp:FileUpload 
                                        ID="ProductImageUpload" 
                                        CssClass="form-control" 
                                        runat="server" 
                                        accept="image/*" />
        
                                    <!-- RequiredFieldValidator to ensure an image is uploaded -->
                                    <asp:RequiredFieldValidator 
                                        ID="RequiredFieldValidatorProductImageUpload" 
                                        runat="server" 
                                        ValidationGroup="formitem" 
                                        CssClass="text-danger" 
                                        ErrorMessage="*Please Upload Image" 
                                        ControlToValidate="ProductImageUpload" 
                                        ForeColor="Red">
                                    </asp:RequiredFieldValidator>

                                    <!-- RegularExpressionValidator to restrict the file to image formats only -->
                                    <asp:RegularExpressionValidator 
                                        ID="RegexValidatorProductImageUpload" 
                                        runat="server" 
                                        ControlToValidate="ProductImageUpload" 
                                        CssClass="text-danger" 
                                        ErrorMessage="*Please upload a valid image file (.jpg, .jpeg, .png, .gif)" 
                                        ValidationExpression="^.*\.(jpg|jpeg|png|gif)$" 
                                        ForeColor="Red" 
                                        ValidationGroup="formitem">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>

                            </div>
<%--                            <div class="form-row">
                                

                            </div>--%>
                            <div class="form-group">
                                <div class="col-md-2 "></div>
                                <div class="col-md-6 ">

                                    <asp:Button ID="btnAddImage" CssClass="btn btn-success " runat="server" Text="Add Image" ValidationGroup="formitem" OnClick="btnAddImage_Click" />
                                    <asp:Button ID="btnCancel" runat="server" Text="CANCEL" CausesValidation="false" OnClick="btnCancel_Click" ValidationGroup="false" CssClass="btn btn-danger" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="table-responsive table_large">
                                <asp:GridView ID="ImageGrid" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                    DataKeyNames="Id,Image" EmptyDataText="Record Not Found" BorderColor="transparent"
                                    AllowPaging="false" PageSize="21" Font-Size="Smaller" OnRowEditing="ImageGrid_RowEditing"
                                    OnRowCancelingEdit="ImageGrid_RowCancelingEdit" OnRowUpdating="ImageGrid_RowUpdating" OnRowDeleting="ImageGrid_RowDeleting">
                                    <Columns>
                                        <asp:CommandField ShowEditButton="True" HeaderText="Actions" />
                                        <asp:CommandField ShowDeleteButton="True" HeaderText="Actions" />

                                        <%--  <asp:TemplateField HeaderText="Image ID" >
                <ItemTemplate>
                    <asp:Label ID="lblImageid" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblImageIdEdit" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>--%>

                                        <asp:TemplateField HeaderText="Image">
                                            <ItemTemplate>
                                                <asp:Image ID="image" Height="100px" Width="100px" ImageUrl='<%# Bind("Image") %>' runat="server" />
                                                <%--//<asp:Label ID="lblImage" runat="server" Text='<%# Bind("Image") %>'></asp:Label>--%>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:FileUpload ID="editImage" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfvImage" runat="server" ControlToValidate="editImage" InitialValue=""
                                                    ErrorMessage="*Image is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCategory" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="editddlCategory" CssClass="form-control" runat="server">
                                                    <asp:ListItem Text="--Select Category--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Transparent Resin" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Waxes" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Sealers" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Suriepox" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="Marble Glues" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="Marble Densifiers" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text="Polishing Powders" Value="7"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="editddlCategory"
                                                    InitialValue="0" ErrorMessage="*Please select a category." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>

                                       <%-- <asp:TemplateField HeaderText="Title">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="editTitle" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="editTitle"
                                                    ErrorMessage="*Title is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>--%>

                                        <%--<asp:TemplateField HeaderText="File">
                <ItemTemplate>
                    <asp:LinkButton ID="btnDownloadBill" runat="server" OnClick="btnDownloadBill_Click" ToolTip="Download image file">
                        <img src="../images/download.png" />
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>--%>
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

