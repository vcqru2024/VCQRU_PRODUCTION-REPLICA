<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="adduser.aspx.cs" Inherits="Patanjali_adduser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                <div class="col">
                    <h5>Add new user</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">dashboard</a></li>
                            <li class="breadcrumb-item"><a href="../SagarPetro/newuser.aspx">Our user</a></li>
                            <li class="breadcrumb-item active" aria-current="page">add new user</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                    <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <label for="username" class="form-label">user name<span>*</span></label>
                            <asp:TextBox runat="server" ID="username" CssClass="form-control"
                                pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>
                           
                            <div class="invalid-feedback">Enter valid user name</div>
                        </div>
                        <div class="col">

                            <label for="userEmail" class="form-label">user email<span>*</span></label>
                            <asp:TextBox runat="server" ID="userEmail" CssClass="form-control" TextMode="Email" MaxLength="30"
                                required></asp:TextBox>
                           
                            <div class="invalid-feedback">Enter valid email id</div>
                        </div>
                        <div class="col">
                            <label for="userMobile" class="form-label">user mobile<span>*</span></label>
                            <asp:TextBox runat="server" ID="userMobile" CssClass="form-control" type="number"
                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                MaxLength="10" required></asp:TextBox>
                          
                            <div class="invalid-feedback">Enter valid mobile number.</div>
                        </div>
                        <!-- <div class="row">
                                <asp:Label runat="server" ID="lblmsg"></asp:Label>
                            </div> -->
                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                            <div class="card-title">
                                <hr />
                                <span>Select User control setting</span>
                            </div>
                        </div>
                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                            <div class="user-select-options">
                                <div
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                                    <div class="col">
                                        <h6>DashBoard</h6>
                                        <asp:CheckBoxList runat="server" ID="Chkdashboard" />
                                    </div>
                                     <div class="col">
                                        <h6>Company Profile</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkCompprofile" />
                                    </div>
                                    <div class="col">
                                        <h6>Users</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkUsers" />
                                    </div>
                                    <%-- <div class="col">
                                            <h6>Profile</h6>
                                            <asp:CheckBoxList runat="server" ID="ChkProfile" />
                                    </div>--%>
                                    <div class="col">
                                        <h6>Product</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkProduct" />
                                    </div>
                                    <div class="col">
                                        <h6>Services</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkService" />
                                    </div>
                                    <%-- <div class="col">
                                        <h6>Transaction</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkTransaction" />
                                </div>--%>
                                    <div class="col">
                                        <h6>Lable</h6>
                                        <asp:CheckBoxList runat="server" ID="ChKLabel" />
                                    </div>
                                    <div class="col">
                                        <h6>Scrap</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkScrap" />
                                    </div>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12">
                                        <h6>Reports</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkReport" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col ms-auto text-end">
                            <a href="../SagarPetro/newuser.aspx" class="btn btn-light px-3 border">Cancel</a>
                            <asp:Button runat="server" ID="btnSubmit" Text="Send Invite" CssClass="btn btn-primary px-3"
                                OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
