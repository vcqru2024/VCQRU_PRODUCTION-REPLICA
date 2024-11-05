<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="pfluserprofile.aspx.cs" Inherits="Patanjali_pfluserprofile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .starcolur{
            color:red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Manage Profile</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Library</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div> 
            <div class="my-profile-card">
                <div class="card">
                    
                    <div class="card-body">
                    
                        <div class="my-profile-tabs">
                            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="pills-CompanyDetails-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-CompanyDetails" type="button" role="tab"
                                        aria-controls="pills-CompanyDetails" aria-selected="true">User
                                        Details</button>
                                </li>
                              
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="pills-ChangePassword-tab" data-bs-toggle="pill"
                                        data-bs-target="#pills-ChangePassword" type="button" role="tab"
                                        aria-controls="pills-ChangePassword" aria-selected="false">Change
                                        Password</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-CompanyDetails" role="tabpanel"
                                    aria-labelledby="pills-CompanyDetails-tab" tabindex="0">
                                    <div class="mange-profile-view-mode">
                                        <div class="mange-profile-action-btn">
                                            <div class="row g-3 align-items-center">
                                                <div class="col">
                                                    <h5>Company Details</h5>
                                                </div>
                                                
                                            </div>
                                        </div>
                                     
                                        <div class="profile-viwe-mode">
                                            <div
                                                class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-3 row-cols-1 g-3">
                                                <div class="col">
                                                   <asp:TextBox ID="txtUserName" runat="server" ReadOnly="true" CssClass="form-control" placeholder="User Name"></asp:TextBox>
                                                </div>
                                                 <div class="col">
                                                   <asp:TextBox ID="txtemail" runat="server" ReadOnly="true" CssClass="form-control" placeholder="User Email"></asp:TextBox>
                                                </div>
                                                 <div class="col">
                                                   <asp:TextBox ID="txtmobile" runat="server" ReadOnly="true" CssClass="form-control" placeholder="User Mobile"></asp:TextBox>
                                                </div>
                                                 <div class="col">
                                                   <asp:HiddenField ID="hdnuserid" runat="server" />
                                                </div>
                                                 <%-- <div class="col ms-auto text-end">
                                                    <asp:Button ID="btncancel" CssClass="btn btn-primary px-5" OnClick="btncancel_Click" runat="server" Text="Cancel" />
                                                </div>--%>
                                                <%-- <div class="col ms-auto text-end">
                                                    <asp:Button ID="btnsubmit" CssClass="btn btn-primary px-5" OnClick="btnsubmit_Click" runat="server" Text="Edit" />
                                                </div>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                              
                                <div class="tab-pane fade" id="pills-ChangePassword" role="tabpanel"
                                    aria-labelledby="pills-ChangePassword-tab" tabindex="0">
                                    <div class="mange-profile-view-mode">
                                        <div class="mange-profile-action-btn">
                                            <h5>Change Password</h5>
                                        </div>
                                       
                                            <div class="row align-items-end g-3">
                                                <div class="col">
                                                    <label for="txtoldpwd" class="form-label">Old Password<span class="starcolur">*</span></label>
                                                    <asp:TextBox ID="txtoldpwd" runat="server" CssClass="form-control" ></asp:TextBox>
                                                </div>
                                                <div class="col">
                                                    <label for="txtnewpass" class="form-label">New Password<span class="starcolur">*</span></label>
                                                    <asp:TextBox ID="txtnewpass" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                                <div class="col">
                                                    <label for="confirmpassword" class="form-label">Confirm Password<span class="starcolur">*</span></label>
                                                    <asp:TextBox ID="confirmpassword" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                                <div class="col">
                                                    <asp:Button ID="btnupdatepassword" CssClass="btn btn-primary px-5" OnClick="btnupdatepassword_Click" runat="server" Text="Save" />
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

