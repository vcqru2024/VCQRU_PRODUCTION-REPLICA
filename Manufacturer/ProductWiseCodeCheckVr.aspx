<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="ProductWiseCodeCheckVr.aspx.cs" Inherits="Manufacturer_ProductWiseCodeCheckVr" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
    <style>
       

        .aadhar {
            align-content: center;
            margin-top: 10px;
        }

        .verifyimghide {
            width: 20px;
            height: 20px;
            display: none
        }

        .verifyimgshow {
            width: 20px !important;
            height: 20px !important;
            display: block;
            position: absolute;
            right: 15px;
        }

        .box-data {
            padding: 10px;
            border: 1px solid #ececec;
            border-radius: 10px;
            background: #f5f5f5;
            position: relative;
        }

            .box-data img {
                height: 322px;
                width: 100%;
                border-width: 0px;
                border-radius: 10px;
            }

        .foot-box {
            padding-left: 66px;
            position: relative;
            margin-top: 15px;
        }

            .foot-box .roundedcorners {
                position: absolute;
                left: 0;
            }

            .foot-box span, .foot-box strong {
                font-size: 14px !important;
            }

            .foot-box strong {
                font-weight: 600 !important;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Product Wise Success Code Check</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            
                            <div class="form-wizard medias">                               
                                <div class="form-row">                                
                                           
                                            <div class="form-group col-lg-3">
                                            <asp:DropDownList ID="ddlProducts" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div> 
                                              
                                           <div class="form-group col-lg-3">
                                            <asp:ImageButton ID="ImgSearch3"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click3" />

                                            <asp:ImageButton ID="ImgRefresh3" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                            OnClick="ImgRefresh_Click3" />                                
                                            </div>
                                          
                                      
                                      </div>
                                 
                                 <br />  
                               <div class="form-row">
                                   
                                 <div class="form-group  col-lg-12" style="font-size:medium;color:red;"><label id="ErrorMsg" runat="server" style="color:red;"></label></div>
                             
                                <div class="form-group col-lg-3">
                                      
                                      <asp:Button ID="btn_download3" Visible="true" runat="server" Text="Download" OnClick="btn_download_Click_drpdown" CssClass="btn btn-primary" />
                                                                     
                                </div>                           

                                <div class="table-responsive table_large">
                                    <asp:GridView ID="GridProductWise"  visible="false"  runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered" 
                                        EmptyDataText="Record Not Found" 
                                        BorderColor="transparent"
                                         allowpaging="false"  ClientIDMode="Static">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Product Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[Product Name]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                           <asp:TemplateField HeaderText="City">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[City]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                         <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[State]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="No of Unique Users">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[No of Unique Users]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
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


