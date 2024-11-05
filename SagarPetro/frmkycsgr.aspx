<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="frmkycsgr.aspx.cs" Inherits="SagarPetro_frmkycsgr" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

         

            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>User KYC</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">User</li>
                                    <li class="breadcrumb-item active" aria-current="page">New Gift</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="user-role-card">
                    <div class="card">

                        <div class="card-body">
                            <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                            <asp:Label ID="LblMsg" runat="server"></asp:Label>
                            <div class="row">
                                <div class="col">
                                    <asp:TextBox ID="txtDateFrom" Visible="true" runat="server" placeholder="DD-MM-YYYY" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom"
                                        ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                        ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                </div>
                                <div class="col">
                                    <asp:TextBox ID="txtDateto" Visible="true" runat="server" placeholder="DD-MM-YYYY" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto"
                                        ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                        ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                </div>
                                <div class="col">
                                    <asp:DropDownList ID="userType" Visible="false" runat="server"
                                        CssClass="form-control">
                                    </asp:DropDownList>
                                </div>

                                <div class="col text-end">
                                    <asp:ImageButton ID="ImgSearch" Visible="true" runat="server"
                                        CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        ValidationGroup="servss" ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success"
                                        ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                        OnClick="ImgRefresh_Click" />
                                    <asp:Button ID="btn_download" Visible="true" runat="server" Text="Download"
                                        OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-4">
                                    <label class="form-label">Search:</label>
                                    <input type="search" id="searchInput" onkeypress="return restrictEnterKey(event)" onkeyup="performSearch(this.value)"
                                        class="form-control" placeholder="Search">
                                </div>
                            </div>
                            <div class="app-table mt-3">
                                <div class="table-responsive">
                                     <div class="table-responsive">
                                    <table id='dataTable' class='table table-hover mb-0 table-bordered'>
                                        <thead>
                                            <tr>
                                                <th>Sr No</th>
                                                <th>Name</th>
                                                <th>Mobile Number</th>
                                                <th>KYS Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater runat="server" ID="grd1">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%#Container.ItemIndex+1 %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("ConsumerName") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("MobileNumber") %>
                                                        </td>
                                                        <td>
                                                            <%# Eval("KYCStatus") %>
                                                        </td>
                                                        <td>
                                                          <a href='viewkycdetailssgr.aspx?mid=<%# Eval("M_Consumerid") %>'>
                                                        <img src="../Content/images/edit.png"></a>
                                                        </td>
                                                        
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                                    
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-lg-6">
                                    <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="DD-MM-YYYY">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server"
                                        TargetControlID="txtDateto" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server"
                                        TargetControlID="txtDateto" Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server"
                                        TargetControlID="txtDateto" WatermarkText="DD-MM-YYYY">
                                    </cc1:TextBoxWatermarkExtender>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
         

        </asp:Content>