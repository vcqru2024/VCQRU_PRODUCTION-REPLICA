<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="UpdateRole.aspx.cs" Inherits="Manufacturer_UpdateRole" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    <script type="text/javascript">
        function Validate(e) {
            //alert();
            var keyCode = e.keyCode || e.which;
            var regex = /^[A-Za-z0-9]+$/;
            var isValid = regex.test(String.fromCharCode(keyCode));
            return isValid;
        }
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Update Role</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                           
                            <div class="form-wizard medias">
                                
                                <div class="form-row">
                                     <div class="col-lg-3"></div>
                          <div class="form-group col-lg-3">
                            <%--<span class="req">*</span><label>Mobile</label>--%>
                            <asp:TextBox ID="UserMobileNo" runat="server" class="form-control form-control-sm"  MinLength="10" MaxLength="12"  runat="server" placeholder="Enter 10 digit mobile no."  onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" required ></asp:TextBox>                        

                              </div>                                  
                                  

                                     <div class="form-group col-lg-6">
                                    <asp:ImageButton ID="ImgSearch"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset" OnClick="ImgRefresh_Click2" />

                                     </div>

                                   
                                <div class="col-lg-3">
                                </div>
                                <div class="col-lg-9">
                                 <asp:Label ID="lblMsg1" runat="server"></asp:Label><br><br>
                                </div>
                         
                                
                                
                                <br />
                                 <div class="col-lg-12" visible="false" runat="server" id="FormUpdate" style="margin-top:20px;">
                                
                          <div class="change_psw">
            <div class="card-body card-body-nopadding text-center">
              <h2  style="color: #0088cc;"  >Update Role/CIN Number </h2><br />
            
                                 <asp:Label ID="Label2" runat="server"></asp:Label><br />
                           
                         
                  <div class="form-row">
                                <asp:HiddenField id="HiddenM_ConID" runat="server" />
                      <asp:HiddenField id="HiddenRole" runat="server" />
                                    <div class="form-group col-lg-12">                                      
                                     <asp:DropDownList ID="UserRole" Visible="true" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="UserRole_SelectedIndexChanged">
                                        <asp:ListItem Value="0" ID="KycStatusItem1">Select Role</asp:ListItem>
                                        <asp:ListItem Value="1" ID="DealerItem">Dealar</asp:ListItem>
                                        <asp:ListItem Value="2" ID="RetailerItem">Retailer</asp:ListItem>
                                        <asp:ListItem Value="3" ID="CNBoyItem">Counter Boy</asp:ListItem>  
                                         <asp:ListItem Value="4" ID="ElectrItem">Elictrician</asp:ListItem>  
                                    </asp:DropDownList>
                                     </div>
                          <div class="form-group col-lg-12">    
                                <asp:TextBox  ID="ConName" MaxLength="10" class="form-control form-control-sm" runat="server" readonly="true"></asp:TextBox>
                             </div>
                        <%--  <div class="form-group col-lg-12">    
                               <label visible="false" ID="Lblcin_number" runat="server">Cin Number <span class="req">*</span></label>
                                <asp:TextBox visible="false" ID="cin_number" MaxLength="10" onchange="checkproduct(this.value);"
                                    class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'10');" placeholder="Cin Number- Dealer/Retailer"></asp:TextBox>
                             </div>--%>
                            <div class="form-group col-lg-12">   
                                 <label visible="false" ID="Lblcin_Refnumber" runat="server">Reference CIN Number <span class="req">*</span></label>
                                <asp:TextBox visible="false" ID="RefCinNo" MaxLength="10" onchange="checkproduct(this.value);"
                                    class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'10');" onkeypress="return Validate(event);" placeholder="Enter refrence CIN number" pattern="[a-zA-Z0-9]+" title="Accept only Alphabets or Numbers"></asp:TextBox>
                             </div>
                </div>
               <div class="form-row">
                       
                        <div class="form-group col-lg-3">
                     
                    <asp:Button ID="Button1"  OnClick="ImgRefresh_Click1" ValidationGroup="servss"
            class="btn float-right btn-primary btn-block" style="color: #0088cc;"    runat="server" Text="Submit" />
                      					
                        </div>
                </div>
                             
                 

            </div>
            </div>
                             
                   
 
            </div>
                           
                                    
                                
                                
                                </div>
    </div>
    </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>




