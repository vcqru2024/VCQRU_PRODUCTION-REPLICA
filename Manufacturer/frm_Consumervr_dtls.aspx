<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="frm_Consumervr_dtls.aspx.cs" Inherits="Manufacturer_frm_Consumervr_dtls" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function deleteVrUser(midd) {
            alert(midd);
        }

        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });
            // Delete account start---
            debugger;
            $("#ErrorMsg").text("");
            $("#ErrorMsg").text("");
            $(".btnDeleteAccount").click(function () {
                debugger;
                let text = "Are you sure you want to delete this user?";
                if (confirm(text) == false) {
                    return false;
                }

                if ($(this).closest('tr').find('span[id*="lblactudateMobile"]').text().length >= 10) {
                    var mobile_val = $(this).closest('tr').find('span[id*="lblactudateMobile"]').text();

                    if (mobile_val.length >= 10) {
                        $.ajax({
                            type: "Post",
                            url: "https://qa.vcqru.com/Info/MasterHandler.ashx?method=DeleteAccountVRkabel&mobileno=" + mobile_val + "&mode=Website",
                            success: function (data) {
                                if (data != "") {
                                    const obj = JSON.parse(data);
                                    if (obj.status == "200") {
                                        $("#ErrorMsg").text("This user account has been deleted!");
                                        $(this).closest("tr").hide();
                                        $(this).closest("tr").hide('slow');
                                    } else if (obj.status == "400") {
                                        $("#ErrorMsg").text("This account is not registered with us!");
                                    } else {
                                        $("#ErrorMsg").text("Please try after some time!");
                                    }
                                    return false;
                                } else {
                                    $("#ErrorMsg").text("Please try after some time!");
                                    return false;
                                }
                            },
                        });
                    } else {
                        $("#ErrorMsg").text("Please try after some time!");

                    }
                }
            });
            // Delete account close---

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>KYC User Data</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-wizard medias">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                         <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="yyyy-MM-dd" PopupButtonID="txtDateFrom"
                                        TargetControlID="txtDateFrom" >
                                    </cc1:CalendarExtender>
                                       <%-- <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />--%>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:TextBox ID="txtDateto" Visible="true" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="yyyy-MM-dd" Animated="False"
                                        PopupButtonID="txtDateto" TargetControlID="txtDateto">
                                    </cc1:CalendarExtender>
                                       <%-- <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />--%>
                                    </div>
                                    <div class="form-group col-lg-3">                                      
                                           <asp:DropDownList ID="userType" Visible="true" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                            </div>

                                     <div class="form-group col-lg-3">
                                    <asp:ImageButton ID="ImgSearch"  Visible="true" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                        OnClick="ImgRefresh_Click" />

                                
                                    <asp:Button ID="btn_download" Visible="true" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                </div>
                                 <br />
                           
                                 


                                <div class="form-row">
                                    <div class="dropdown col-lg-3">
                                       <asp:DropDownList ID="ddlstate" OnSelectedIndexChanged="ddlstate_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                     <div class="col-lg-3">
                                      <asp:DropDownList ID="ddlvrrole" OnSelectedIndexChanged="ddlvrrole_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                         </div>
                                        <div class="col-lg-3">
                                        <asp:DropDownList ID="ddlsubrole" OnSelectedIndexChanged="ddlsubrole_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    <div class="col-lg-3">
                                        <asp:DropDownList ID="ddlallreg" Visible="false" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                     
                                 
                               
                                    <div class="col-lg-3">
                                    <asp:ImageButton ID="btnsearch" Visible="false" runat="server" ImageUrl="~/Content/images/search.png" />
                                </div>
                                </div>
                                 <br />  
                                <div class="form-row">
                                    
                                      <div class="form-group col-lg-3">
                                         <asp:Button ID="Button2" Visible="true" runat="server" Text="Download" OnClick="btn_download_Click_drpdown" CssClass="btn btn-primary" />
                                    
                                          </div>
                                         </div>
                                    
                                <br />
                                    <div class="row col-lg-12">
                                    
                                     <div class="col-lg-4"></div>
                                    <div class="col-lg-4 mt-2">
                                       <label id="countRows" runat="server" style="font-size:medium;color:red"></label>
                                          </div>
                                            <div class="col-lg-4 mt-2"><label id="ErrorMsg"  style="font-size:medium;color:red"></label></div>
                                </div>
                                <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1"  runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered" 
                                        EmptyDataText="Record Not Found" 
                                        BorderColor="transparent"
                                         allowpaging="false" ClientIDMode="Static">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Mobile">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblactudateMobile" runat="server" Text='<%# Bind("MobileNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Type">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("UserType") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField HeaderText="KYS Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("KYCStatus") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                        </asp:TemplateField>

                                       

                                        <asp:TemplateField HeaderText="Action">
                                         
                                            <ItemTemplate>
                                                <a href='ViewDetailsVrkable.aspx?mid=<%# Eval("M_Consumerid") %>'><img src="../Content/images/edit.png" ></a>

                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>

                                         

                                        
                                        </Columns>

                                    
                                    </asp:GridView>
                                </div>

                               <%-- <div class="form-group col-lg-6">
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
                                </div>--%>
                            </div>
    </div>
    </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>


