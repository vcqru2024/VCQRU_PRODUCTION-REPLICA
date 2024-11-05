<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="viewkycdetailssgr.aspx.cs" Inherits="SagarPetro_viewkycdetailssgr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home-section">
        <div class="user-role-card">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fa fa-pencil-square-o"></i>
                        <asp:Label ID="lblheading" runat="server" Text="KYC User Detail"></asp:Label></h5>
                </div>
                <div class="card-body">
                    <div class="col-md-2">
                        <asp:Button ID="btnback" OnClick="btnback_Click" runat="server" Text="Back" CssClass="btn btn-primary" />
                    </div>
                    <div class="card-title">
                        <hr>
                        <span>User Info</span>
                    </div>
                    <asp:HiddenField ID="HiddenM_ConID" runat="server" />
                    <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-md-3 row-cols-1 g-3">
                        <div class="col">
                            <label class="form-label">Name<span>*</span></label>
                            <asp:TextBox ID="txtName" MaxLength="50" onchange="checkproduct(this.value);"
                                class="form-control" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col">
                            <label class="form-label">Mobile</label>
                            <asp:TextBox ID="txtMobile" class="form-control" MaxLength="250" Height="40px" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col">
                            <label class="form-label">City</label>
                            <asp:TextBox ID="txtCity" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>

                        </div>

                        <div class="col">
                            <label class="form-label">KYC Status</label>
                            <asp:TextBox ID="txtKYC" class="form-control" MaxLength="250" Height="40px" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col">
                            <label class="form-label">Bank Name</label>
                            <asp:TextBox ID="TextBankName" MaxLength="50" onchange="checkproduct(this.value);"
                                class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col">
                            <label class="form-label">Branch</label>
                            <asp:TextBox ID="TextBranch" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col">

                            <label class="form-label">Account Holder</label>
                            <asp:TextBox ID="TextAccountHolder" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col">

                            <label class="form-label">Account No.</label>
                            <asp:TextBox ID="TextAccountNo" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>

                        </div>

                        <div class="col">
                            <label class="form-label">IFSC Code</label>
                            <asp:TextBox ID="TextIFSC" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class="col-xxl-12 col-xl-12 col-md-12 col-12">
                            <div class="card-title">
                                <hr>
                                <span>Document</span>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center">
                                <label class="form-label">Aadhar Front</label>
                                <asp:Image runat="server" ID="imgAadharFront" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkAadharFront" runat="server" class="btn btn-primary w-50" target="_blank" title="View Documents">View </a>
                                <label id="imgAadharFrontDiv" runat="server"></label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center">
                                <label class="form-label">Aadhar Back</label>
                                <asp:Image runat="server" ID="imgAadharBack" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkAadharBack" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View</a>
                                <label id="imgAadharBackDiv" runat="server"></label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center">
                                <label class="form-label">Pancard File</label>
                                <asp:Image runat="server" ID="imgPan" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkPan" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View </a>
                                <label id="imgPanDiv" runat="server"></label>
                            </div>

                        </div>
                        <div class="col">
                            <div class="text-center">
                                <label class="form-label">Passbook</label>
                                <asp:Image runat="server" ID="imgpass" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkPass" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View </a>
                                <label id="imgpassdiv" runat="server"></label>
                            </div>

                        </div>
                        <div class="col">
                            <div class="text-center">

                                <label class="form-label">Shop/Service Center File</label>
                                <asp:Image runat="server" ID="imgShop" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkShop" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View </a>
                                <label id="imgShopDiv" runat="server"></label>
                            </div>
                        </div>
                          <div class="col">
                            <div class="text-center">

                                <label class="form-label">Shop/Service Center File</label>
                                <asp:Image runat="server" ID="imgShop1" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkShop1" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View </a>
                                <label id="imgShopDiv1" runat="server"></label>
                            </div>
                        </div>
                          <div class="col">
                            <div class="text-center">

                                <label class="form-label">Shop/Service Center File</label>
                                <asp:Image runat="server" ID="imgShop2" CssClass="mx-auto d-block" Style="width: 150px; height: 110px;" />
                                <a id="HyperLinkShop2" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px; margin-top: 2px;">View </a>
                                <label id="imgShopDiv2" runat="server"></label>
                            </div>
                        </div>
                       
                        <div class="col-xxl-12 col-xl-12 col-md-12 col-12">
                            <div class="card-title">
                                <hr>
                                <span>Update KYC Status</span>
                            </div>
                        </div>
                        <div class="col">
                            <asp:DropDownList ID="KycStatus" Visible="true" runat="server" CssClass="form-select">
                                <asp:ListItem Value="" ID="KycStatusItem1">Select KYC Status</asp:ListItem>
                                <asp:ListItem Value="1">Approve</asp:ListItem>
                                <asp:ListItem Value="2">Reject</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextRemark" MaxLength="200" onchange="checkproduct(this.value);"
                                class="form-control" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'200');" placeholder="Remark"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Button ID="Button1" OnClick="ImgSearch_Click" ValidationGroup="servss"
                                class="btn btn-primary px-5" runat="server" Text="Submit" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

