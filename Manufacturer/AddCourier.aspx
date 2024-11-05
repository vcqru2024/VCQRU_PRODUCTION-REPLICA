<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddCourier.aspx.cs" Inherits="Manufacturer_AddCourier" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(14).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function checkCourior(vl) {
             vl = vl + "*" +document.getElementById("<%=hdncmphdn.ClientID %>").value;
             PageMethods.checkNewLabel(vl, onCompleteLaebl)
         }
         function onCompleteLaebl(Result) {
             if (Result == true) {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "Courior Name Already exist.";
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = true;
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
             }
             else {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "";
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = false;
                 document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
             }
         }        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="col-lg-12 card card-admin form-wizard profile">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">Add/Edit Courier Master<asp:HiddenField ID="hdncmphdn" runat="server" /></i></h4>
                            </header>
              <div id="DivNewMsg" runat="server" style="width: 88%;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                <div class="card-body card-body-nopadding">
                  
                  <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Courier Name</label>
                            <asp:TextBox ID="txtCourierName" runat="server" CssClass="form-control form-control-sm"  MaxLength="50"
                                                    onchange="checkCourior(this.value)"></asp:TextBox>
                             <asp:Label ID="lblCouriorChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PR1" ControlToValidate="txtCourierName">
                            </asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtCourierName"
                                runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                            </cc1:FilteredTextBoxExtender>
                        </div>
                      <div class="form-group col-lg-6">
                          <span class="req">*</span>
                          <label>Courier Email</label>
                          <asp:TextBox ID="txtCourierEmail" runat="server" CssClass="form-control form-control-sm" MaxLength="50"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ErrorMessage="*"
                              ValidationGroup="PR1" ControlToValidate="txtCourierEmail">
                          </asp:RequiredFieldValidator>
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                              ControlToValidate="txtCourierEmail" ValidationGroup="PR1" ErrorMessage="a@a.com"
                              ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                      </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Contact No</label>
                             <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control form-control-sm"  MaxLength="13"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PR1" ControlToValidate="txtContactNo">
                            </asp:RequiredFieldValidator>
                               <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtenderNo1" runat="server" FilterMode="ValidChars"
                                                    FilterType="Numbers" ValidChars="0123456789" TargetControlID="txtContactNo">
                                                </cc1:FilteredTextBoxExtender>
                            <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                            </cc1:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator Display="None" ValidationGroup="PR1" SetFocusOnError="true"
                                ID="RegExpValMobNo" runat="server" ErrorMessage="Contact No must be between 10 to 13 number"
                                ControlToValidate="txtContactNo" ValidationExpression="^[0-9]{10,13}$" />
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Address</label>
                             <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control form-control-sm" 
                                  TextMode="MultiLine" onkeyDown="return checkTextAreaMaxLength(this,event,'200');" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="txtAddress">
                                                </asp:RequiredFieldValidator>
                        </div>
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                               <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                            </div>
                         <div class="form-group col-lg-4">
                              <asp:Button ID="btnCourierSubmit" OnClick="btnCourierSubmit_Click" ValidationGroup="PR1"
                                                CssClass="btn btn-primary float-right mb-0" runat="server" Text="Save" />
                         </div>
                         <div class="form-group col-lg-2">   <asp:Button ID="btnCourierReset"
                                                    OnClick="btnCourierReset_Click" CausesValidation="false" CssClass="btn btn-primary float-right mb-0"
                                                    runat="server" Text="Cancel" /></div>
                         </div>
                </div>

            </div>
                

                </div>
            </div>
         </div>
     <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
</asp:Content>
