<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="UserRegistrationVr.aspx.cs" Inherits="UserRegistrationVr" %>

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

    
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Registration Report</h4>
                        </header>
                        <div class="card-body card-body-nopadding">                            
                            <div class="form-wizard medias">                               
                                <div class="form-row">                                            
                                            <div class="form-group col-lg-3">
                                            <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                                <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="yyyy-MM-dd" PopupButtonID="txtDateFrom"
                                            TargetControlID="txtDateFrom" >
                                            </cc1:CalendarExtender>
                                            </div>                                       

                                          <div class="form-group col-lg-3">
                                            <asp:TextBox ID="txtDateto" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="yyyy-MM-dd" Animated="False"
                                            PopupButtonID="txtDateto" TargetControlID="txtDateto">
                                            </cc1:CalendarExtender>
                                            </div>  
                                  
                                            <div class="form-group col-lg-3">
                                            <asp:ImageButton ID="ImgSearch"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                            
                                                <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                            OnClick="ImgRefresh_Click" />
                                            </div>
                                  
                                      </div>
                                 
                                 <br />  
                               <div class="form-row">
                                   
                                 <div class="form-group  col-lg-12" style="font-size:medium;color:red;text-align:center;"><label id="ErrorMsg" runat="server" style="color:red;"></label></div>
                             
                                <div class="form-group col-lg-3">
                                       <asp:Button ID="btn_download"  Visible="true" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                                                 
                                </div>                           

                                <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1"  visible="false"  runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered" 
                                        EmptyDataText="Record Not Found" 
                                        BorderColor="transparent"
                                         allowpaging="false"  ClientIDMode="Static">
                                    <Columns>
                                        <asp:TemplateField HeaderText="User Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[Category Name]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="New User Registered">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudateMobile" runat="server" Text='<%# Bind("[New User Registered]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Total Users Registered">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("[Total Users Registered]") %>'></asp:Label>
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


