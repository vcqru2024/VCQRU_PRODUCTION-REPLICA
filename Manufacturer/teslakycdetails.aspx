<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="teslakycdetails.aspx.cs" Inherits="Manufacturer_teslakycdetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label6" runat="server"></asp:Label>
    <asp:Label ID="Label9" runat="server"></asp:Label>
    <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>
                                <asp:Label ID="lblheading" runat="server" Text="KYC User Detail" Font-Bold="true"></asp:Label></h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="form-group col-lg-10">
                                    <h6>User Info</h6>
                                </div>
                                <div class="form-group col-lg-2">
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" CausesValidation="false" OnClick="btnReset_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                            </div>
                            <div class="form-row align-items-end" id="divUPIKYC" runat="server">
                                <div class="form-group col-lg-3">
                                    <label>Avlaibe Point</label>
                                   <%-- <asp:Label ID="lblpoint" runat="server"></asp:Label>--%>
                                    <asp:TextBox ID="lblpoint" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>UPIId</label>
                                    <asp:TextBox ID="TextUPIId" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3" runat="server" visible="false">
                                     <span class="req">*</span><label>Select UPI KYC STATUS</label>
                                    <asp:DropDownList ID="ddlupikycstatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="-1" ID="upikyc" disabled="true" Selected="True">Select KYC Status</asp:ListItem>
                                        <asp:ListItem Value="0">Pending</asp:ListItem>
                                        <asp:ListItem Value="1">Approve</asp:ListItem>
                                        <asp:ListItem Value="2">Reject</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-lg-3" runat="server" visible="false">
                                    <asp:Button ID="btnverifyupi" Text="Verify" OnClick="btnverifyupi_Click" runat="server" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <div class="form-row" id="bankkyc" runat="server">
                                <asp:HiddenField ID="HiddenM_ConID" runat="server" />
                                <asp:HiddenField ID="hdnemail" runat="server" />

                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Name</label>
                                    <asp:TextBox ID="txtName" MaxLength="50" onchange="checkproduct(this.value);"
                                        class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Mobile</label>
                                    <asp:TextBox ID="txtMobile" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req"></span>
                                    <label>City</label>
                                    <asp:TextBox ID="txtCity" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>KYC Status</label>
                                    <asp:TextBox ID="txtKYC" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Bank Name</label>
                                    <asp:TextBox ID="TextBankName" MaxLength="50" onchange="checkproduct(this.value);"
                                        class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>Branch</label>
                                    <asp:TextBox ID="TextBranch" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req"></span>
                                    <label>Account Holder</label>
                                    <asp:TextBox ID="TextAccountHolder" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <span class="req"></span>
                                    <label>Account No.</label>
                                    <asp:TextBox ID="TextAccountNo" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>

                                </div>

                                <div class="form-group col-lg-3">
                                    <span class="req">*</span><label>IFSC Code</label>
                                    <asp:TextBox ID="TextIFSC" class="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>


                            </div>
                        </div>

                        <div class="col-lg-12" style="margin-top: 20px;" id="bankkycupdate" runat="server">
                            <div class="change_psw">
                                <div class="card-body card-body-nopadding text-center">
                                    <h2 style="color: #0088cc;">Update KYC Status </h2>
                                    <br />
                                    <br />

                                    <div class="form-row">

                                        <div class="form-group col-lg-12">
                                            <asp:DropDownList ID="KycStatus" Visible="true" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="" ID="KycStatusItem1">Select KYC Status</asp:ListItem>
                                                <asp:ListItem Value="1">Approve</asp:ListItem>
                                                <asp:ListItem Value="2">Reject</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group col-lg-12">

                                            <asp:TextBox ID="TextRemark" MaxLength="200" onchange="checkproduct(this.value);"
                                                class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'200');" placeholder="Remark"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-row">

                                        <div class="form-group col-lg-3">

                                            <asp:Button ID="Button1" OnClick="ImgSearch_Click" ValidationGroup="servss"
                                                class="btn float-right btn-primary btn-block" Style="color: #0088cc;" runat="server" Text="Submit" />

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

