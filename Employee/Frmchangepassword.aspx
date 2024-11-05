<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Employee/Employee.master"
    AutoEventWireup="true" CodeFile="Frmchangepassword.aspx.cs" Inherits="Employee_Frmchangepassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(1).addClass("active");
            $(".accordion2 div.open").eq(1).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">Change Password</i></h4>
                            </header>
           
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"  ForeColor="red"  ></asp:Label>
                    <%--<asp:Label ID="LblMsg" runat="server" CssClass="astrics"  Font-Bold="false"></asp:Label>--%>
                </p>
            </div>
                <div class="card-body card-body-nopadding">
                                <h6>Change Password</h6>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label> Old Password</label>
                                         
                                           <asp:TextBox ID="txtoldpass" MaxLength="50" TextMode="Password" class="form-control form-control-sm"
                                 runat="server"></asp:TextBox>
                                        
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidatorNew3" runat="server" ForeColor="Red"
                                ValidationGroup="PRO" ControlToValidate="txtoldpass" ErrorMessage="required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                    <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>New Password</label>
                                              <asp:TextBox ID="txtnewpass" MaxLength="20" TextMode="Password" class="form-control form-control-sm"
                                runat="server"></asp:TextBox>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                ValidationGroup="PRO" ControlToValidate="txtnewpass" ErrorMessage="required"></asp:RequiredFieldValidator>
                            <cc1:ValidatorCalloutExtender ID="ValCalloutNewPass" runat="server" TargetControlID="RegExpValNewPass">
                            </cc1:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator Display="None" ValidationGroup="PRO" SetFocusOnError="true"
                                ID="RegExpValNewPass" runat="server" ErrorMessage="Password must be between 4 to 20 character"
                                ControlToValidate="txtnewpass" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{4,20}$" />
                                        </div>
                                    </div>
                      <div class="form-row">
                                    <div class="form-group col-lg-6">
                                             <span class="req">*</span><label>Re-enter Password</label>
                                         <asp:TextBox ID="txtreenterpass" MaxLength="50"  class="form-control form-control-sm" TextMode="Password"
                                runat="server"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ErrorMessage="required"
                                ValidationGroup="PRO" ControlToValidate="txtreenterpass"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                ControlToCompare="txtnewpass" ControlToValidate="txtreenterpass" ForeColor="Red"
                                Type="String" Operator="Equal" ErrorMessage="Password not matched"></asp:CompareValidator>
                                    </div>
                          </div>
                     <div class="form-row"> <div class="form-group col-lg-1"><asp:Button ID="btnChangePass" OnClick="btnChangePassword_Click" ValidationGroup="PRO"
                               class="btn btn-primary float-right mb-0" runat="server" Text="Save" />
                                    </div>
                                    <div class="form-group col-lg-1">
                                        
                            <asp:Button ID="btnReset" OnClick="btnReset_Click" class="btn btn-primary float-right mb-0" runat="server"
                                Text="Reset" /> </div><div class="form-group col-lg-10">

                                           </div>
                         </div>
                    </div>
            
        </ContentTemplate>
    </asp:UpdatePanel>
                    </div>
                </div>
            </div>
         </div>
    
</asp:Content>
