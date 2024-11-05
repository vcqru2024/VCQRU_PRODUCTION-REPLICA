<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="hpl_userregistration.aspx.cs" Inherits="Manufacturer_hpl_userregistration" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }

            .custom-grid th, .custom-grid td {
                padding: 8px;
                border: 1px solid #ddd;
            }

            .custom-grid th {
                background-color: #4CAF50;
                color: white;
            }

            .custom-grid tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .custom-grid tr:hover {
                background-color: #ddd;
            }
            #menudiv .card-title{
                position:relative;
            }
              #menudiv .card-title span{
                  position: absolute;
    top: 0;
    transform: translate(-50%, -50%);
    left: 50%;
    background-color: #fff;
    font-size: 16px;
    padding: 0 1rem;
    font-weight: 600;
    color:#000;
    text-wrap: nowrap;
              }
              #menudiv h6{
                  margin:1rem 0;
                  color:#498df7;
              }
              #menudiv table{
                  width:100%;
              }
               #menudiv table tbody{
                  display: flex;
    flex-wrap: wrap;
              }
               #menudiv table tbody tr{
                   width:25%;
               }
                #menudiv table tbody tr td{
                     display: flex;
    align-items: center;
    gap: 0.50rem;
                }
                   #menudiv table tbody tr td label{
                       font-weight: 600;
    font-size: 14px;
    color: #808080;
                   }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <%--<header class="card-header">--%>
                        <header class="<%= Session["card-header"] %>">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>
                                <asp:Label ID="lblheading" runat="server" Text="CREATE OEM" Font-Bold="true"></asp:Label></h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <asp:Label ID="lblmsg" runat="server" Font-Bold="true"></asp:Label>
                            <%-- User Registration Start --%>
                            <div runat="server" id="divuserregistration">
                                <div class="form-row">
                                    <div class="form-group col-lg-3">
                                        <span class="req">*</span>
                                        <label>Name</label>
                                        <asp:TextBox ID="txtName" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <span class="req"></span>
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" class="form-control form-control-sm" MaxLength="100" Height="40px" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <span class="req">*</span>
                                        <label>Mobile</label>
                                        <asp:TextBox ID="txtMobile" class="form-control form-control-sm" MaxLength="10" Height="40px" runat="server"></asp:TextBox>
                                    </div>

                                    <div class="form-group col-lg-3">
                                        <span class="req">*</span>
                                        <label>Location</label>
                                        <asp:TextBox ID="txtlocation" class="form-control form-control-sm" MaxLength="100" Height="40px" runat="server"></asp:TextBox>
                                    </div>

                                </div>
                                <%-- Menu Selection  --%>
                                <div id="menudiv">
                                    <div class="card-title">
                                            <hr />
                                            <span>Select Product</span>
                                        </div>
                                     <div class="user-select-options">
                                                <div>
                                                    <h6>Company Product</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkProductName" />
                                                </div>
                                               <%-- <div>
                                                    <h6>DashBoard</h6>
                                                    <asp:CheckBoxList runat="server" ID="Chkdashboard" />
                                                </div>--%>
                                              <%--  <div class="col">
                                                    <h6>Company Profile</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkCompprofile" />
                                                </div>--%>
                                              <%--  <div class="col">
                                                    <h6>Users</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkUsers" />
                                                </div>--%>

                                               <%-- <div>
                                                    <h6>Reports</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkReport" />
                                                </div>--%>
                                                 <%--<div>
                                                    <h6>Product</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkProduct" />
                                                </div>--%>
                                              <%--  <div>
                                                    <h6>Services</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkService" />
                                                </div>--%>

                                               <%-- <div>
                                                    <h6>Lable</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChKLabel" />
                                                </div>--%>
                                               <%-- <div>
                                                    <h6>Scrap</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkScrap" />
                                                </div>--%>
                                                 <%-- <div>
                                                    <h6>Claim Report</h6>
                                                    <asp:CheckBoxList runat="server" ID="ChkClaimrpt" />
                                                </div>--%>
                                        </div>

                                </div>
                                <%-- Menu Selection End --%>

                                <div class="form-group col-lg-3">
                                    <asp:Button ID="btnRegisternewUser" runat="server" OnClick="btnRegisternewUser_Click" Text="Register Now" CausesValidation="false" ValidationGroup="false" CssClass="btn btn-success btn-block mt-4" />
                                </div>
                            </div>
                            <%--End Of User Registration Start --%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

