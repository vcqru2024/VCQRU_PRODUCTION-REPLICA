<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" Title="Change Password"
    CodeFile="Frmchangepasswords.aspx.cs" Inherits="Frmchangepasswords" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(3).addClass("active");
        $(".accordion2 div.open").eq(0).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                           <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Change Password</h4>
                            </header>
                            
                           

            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
            <div class="change_psw">
            <div class="card-body card-body-nopadding">
             
                <div class="form-row">
                    <div class="col-lg-12">
                    <div class="form-group">
                        <span class="req">*</span><label>Old Password</label>
                        <asp:TextBox ID="txtoldpass" MaxLength="50" TextMode="Password" class="form-control form-control-sm"
                       runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNew3" runat="server" class="valid_text" ForeColor="Red" ErrorMessage="*"
                            ValidationGroup="PRO" ControlToValidate="txtoldpass"></asp:RequiredFieldValidator>
                        <asp:Label ID="LblMsg" runat="server" CssClass="astrics valid_text " Font-Size="8pt" Font-Bold="false"
                            Text=""></asp:Label>
                    </div>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-lg-12">
                    <div class="form-group">
                        <span class="req">*</span><label>New Password </label>
                        <asp:TextBox ID="txtnewpass" MaxLength="50" TextMode="Password" class="form-control form-control-sm"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" class="valid_text" ForeColor="Red" ErrorMessage="*"
                            ValidationGroup="PRO" ControlToValidate="txtoldpass"></asp:RequiredFieldValidator>
                        <asp:Label ID="Label1" runat="server" CssClass="astrics valid_text" Font-Size="8pt" Font-Bold="false"
                            Text=""></asp:Label>
                    </div>
                        </div>
                </div>


                <div class="form-row">
                    <div class="col-lg-12">
                    <div class="form-group">
                        <span class="req">*</span><label>Re-enter Password</label>
                        <asp:TextBox ID="txtreenterpass" MaxLength="50" class="form-control form-control-sm" TextMode="Password" 
                            runat="server"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" class="valid_text" ForeColor="Red"  ErrorMessage="*"
                            ValidationGroup="PRO" ControlToValidate="txtreenterpass"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                            ControlToCompare="txtnewpass" ControlToValidate="txtreenterpass" ForeColor="Red"
                            Type="String" Operator="Equal" Text="Password didn't match" class="valid_text"></asp:CompareValidator>
                    </div>
                        </div>
                </div>
                  <div class="form-row">
                        <div class="col-lg-6">
                           <asp:Button ID="btnChangePass" OnClick="btnChangePassword_Click" ValidationGroup="PRO"
                            class="btn float-right btn-primary btn-block" style="color: #0088cc;"    runat="server" Text="Save" />
                      
                        </div>
                         <div class="col-lg-6">
                            <asp:Button ID="btnReset" OnClick="btnReset_Click" class="btn float-left btn-success btn-block" style="color: #0088cc;"  runat="server"
                            Text="Reset" />
                          </div>
                      </div>

            </div>
            </div>
           
        </ContentTemplate>
    </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
        </div>
</asp:Content>
