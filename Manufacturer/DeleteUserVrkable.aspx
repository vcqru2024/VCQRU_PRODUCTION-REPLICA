<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="DeleteUserVrkable.aspx.cs" Inherits="Manufacturer_DeleteUserVrkable" %>



<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
      

        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });
            

        });

    </script>
    <style>
        .roundedcorners {
            -webkit - border - radius: 30px;
            -khtml - border - radius: 30px;
            -moz - border - radius: 30px;
            border - radius: 30px;
        }

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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Delete Users Data</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                           
                            <div class="form-wizard medias">
                                
                               
                                <div class="form-row">
                                    

                                   
                                 <br />
                                
                                    <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1"  runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered" 
                                        EmptyDataText="Record Not Found" 
                                        BorderColor="transparent"
                                         allowpaging="false"  ClientIDMode="Static">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Mobile">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudateMobile" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudateMobile" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>

                                          <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("Usertype") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
   					<asp:TemplateField HeaderText="Mode">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("Mode") %>'></asp:Label>
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
        </div>
</asp:Content>

