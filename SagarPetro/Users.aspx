<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Patanjali_Users" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>
                                <asp:Label ID="lblheading" runat="server" Text="CREATE USER" Font-Bold="true"></asp:Label></h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <asp:Label ID="lblmsg" runat="server" Style="color: Red; font-family: Arial; font-size: 15px;"></asp:Label>
                            <div class="form-row">
                                <%-- Button For Create Role --%>
                               <%-- <div class="form-group col-lg-2">
                                    <asp:Button ID="btnCreateRole" runat="server" Text="Create Role" OnClick="btnCreateRole_Click" CausesValidation="false" ValidationGroup="false" CssClass="btn btn-success btn-block" />
                                </div>--%>
                                <%-- End Of Role Button --%>
                                <div class="form-group col-lg-2">
                                    <asp:Button ID="btnregisteruser" runat="server" Text="Register User" OnClick="btnregisteruser_Click" CausesValidation="false" ValidationGroup="false" CssClass="btn btn-success btn-block" />
                                </div>


                            </div>
                            <%-- Role Part   Uncomment If Need Role Modul--%>
                            <%--<div id="divrole" runat="server" visible="false">
                                <div class="form-row">
                                    <div class="form-group col-lg-3">
                                        <span class="req">*</span><label>Role Type</label>
                                        <asp:TextBox ID="txtrole" MaxLength="100" onchange="checkproduct(this.value);"
                                            class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <asp:Button ID="btnsave" runat="server" Text="Save Role" OnClick="btnsave_Click" CssClass="btn btn-success btn-block mt-4" CausesValidation="false" ValidationGroup="false" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <asp:GridView ID="grdrole" runat="server" CssClass="custom-grid" OnRowCommand="grdrole_RowCommand" AutoGenerateColumns="false">
                                        <HeaderStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                        <AlternatingRowStyle BackColor="#F0F0F0" />
                                        <RowStyle BackColor="#E3EAEB" />
                                        <PagerStyle BackColor="#5D7B9D" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" />
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                     <asp:Button ID="btnActiveDeactive" runat="server" Text='<%# Convert.ToInt32(Eval("IsActive")) == 1 ? "Active" : "Deactive" %>' CommandName="ActiveDeactive" CommandArgument='<%# Eval("RoleId") %>' BackColor='<%# Convert.ToInt32(Eval("IsActive")) == 1 ? System.Drawing.Color.LightGreen : System.Drawing.Color.OrangeRed %>' />   
                                                    <asp:Button ID="btnDeleteRole" runat="server" Text="Delete" CommandName="DeleteRole" CommandArgument='<%# Eval("RoleId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>--%>
                            <%-- End Role Part --%>

                            <%-- User Registration Start --%>
                            <div runat="server" visible="false" id="divuserregistration">
                                   <div class="form-row">
                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Name</label>
                                    <asp:TextBox ID="txtName" MaxLength="50" onchange="checkproduct(this.value);"
                                        class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3" >
                                    <span class="req"></span>
                                    <label>Email</label>
                                    <asp:TextBox ID="txtEmail" class="form-control form-control-sm" MaxLength="100" Height="40px" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Mobile</label>
                                    <asp:TextBox ID="txtMobile" class="form-control form-control-sm" MaxLength="10" Height="40px" runat="server"></asp:TextBox>
                                </div>
                               
                               <%-- <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>User Role</label>
                                    <asp:DropDownList ID="ddluserrole" runat="server" class="form-control form-control-sm" ReadOnly="true"></asp:DropDownList>
                                </div>--%>
                                <div class="form-group col-lg-3">
                                    <asp:Button ID="btnRegisternewUser" runat="server" OnClick="btnRegisternewUser_Click" Text="Register Now" CausesValidation="false" ValidationGroup="false" CssClass="btn btn-success btn-block mt-4" />
                                </div>
                            </div>
                             <div class="form-row">
                                    <asp:GridView ID="grduserreg" runat="server" CssClass="custom-grid" OnRowCommand="grdrole_RowCommand" AutoGenerateColumns="false">
                                        <HeaderStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                        <AlternatingRowStyle BackColor="#F0F0F0" />
                                        <RowStyle BackColor="#E3EAEB" />
                                        <PagerStyle BackColor="#5D7B9D" ForeColor="White" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField DataField="RoleType" HeaderText="Role Type" />
                                            <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                            <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                                            <asp:BoundField DataField="UserMobile" HeaderText="User Mobile" />
                                            <asp:BoundField DataField="Created_Date" HeaderText="Date" />
                                            <asp:BoundField DataField="Status" HeaderText="Status" />
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                     <asp:Button ID="btnActiveDeactive" runat="server" Text='<%# (Eval("Status")).ToString() == "Active" ? "Deactivate" : "Active" %>' CommandName="ActiveDeactive" CommandArgument='<%# Eval("UserRole_id") %>' BackColor='<%# (Eval("Status")).ToString() == "Active" ? System.Drawing.Color.OrangeRed : System.Drawing.Color.LightGreen %>' />   
                                                    <asp:Button ID="btnedit" runat="server" Text="Edit" CommandName="CommandEdit" CommandArgument='<%# Eval("UserRole_id") %>' />
                                                    <asp:Button ID="btnDeleteRole" runat="server" Text="Delete" CommandName="DeleteRole" CommandArgument='<%# Eval("UserRole_id") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
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

