<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/Employee.master" AutoEventWireup="true" CodeFile="UpdateProfile.aspx.cs" Inherits="Employee_UpdateProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(0).addClass("active");
            $(".accordion2 div.open").eq(0).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script language="javascript" type="text/javascript">
        function checkproduct(vl) {
            PageMethods.checkNewProduct(vl, onCompleteProduct)
        }
        function onCompleteProduct(Result) {
            if (Result == true) {
                document.getElementById("<%=lblemail.ClientID %>").innerHTML = "Email Id Already exist.";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblemail.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpDate.ClientID %>").className = "button_all";

            }
        }
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
                                    <div align="center" style="position: absolute; left: 0; height: 1025px; width: 100%; top: 0px; z-index: 999;"
                                        class="NewmodalBackground">
                                        <div style="margin-top: 300px;" align="center">
                                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                            <span style="color: White;">Please Wait.....<br />
                                            </span>
                                        </div>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <%--  <div class="head_cont">
                <h2 class="up_comp">
                    <table width="99%">
                        <tr>
                            <td width="30%">
                                &nbsp;Update Profile
                            </td>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>--%>
                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">Update Profile</i></h4>
                            </header>

                            <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="card-body card-body-nopadding">
                                <%--<h6>Contact Info</h6>--%>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Employee Type</label>
                                        <asp:DropDownList runat="server" ID="ddlEmployee" class="form-control form-control-sm">
                                            <asp:ListItem Text="Select" Value="0" />
                                            <asp:ListItem Text="Employee" Value="1" />
                                            <asp:ListItem Text="Supervisor" Value="2" />
                                        </asp:DropDownList>
                                        <%-- <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="txtPersonName"
                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                        </cc1:FilteredTextBoxExtender>--%>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="ddlEmployee" ErrorMessage="required" InitialValue="0">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Name</label>
                                        <asp:TextBox ID="txtPersonName" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <%-- <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="txtPersonName"
                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                        </cc1:FilteredTextBoxExtender>--%>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="name required">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req"></span>
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" MaxLength="100" onchange="checkproduct(this.value);" class="form-control form-control-sm"
                                            runat="server"></asp:TextBox>
                                        <asp:Label ID="lblemail" runat="server" CssClass="astrics"></asp:Label>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                            ControlToValidate="txtEmail" ValidationGroup="chk94"
                                            ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Mobile No</label>
                                        <asp:TextBox ID="txtMob" MaxLength="15" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtMob">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtMob"
                                            FilterType="Numbers" InvalidChars=".">
                                        </cc1:FilteredTextBoxExtender>
                                        <cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                        </cc1:ValidatorCalloutExtender>
                                        <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                            ID="RegExpValMobNo" runat="server" ErrorMessage="Mobile No must be between 10 to 13 number"
                                            ControlToValidate="txtMob" ValidationExpression="^[0-9]{10,13}$" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-12">
                                        <span class="req">*</span><label>Address</label>
                                        <asp:TextBox ID="txtAddress" Height="45" class="form-control form-control-sm" TextMode="MultiLine" MaxLength="250" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                            runat="server" Width="100%"></asp:TextBox>
                                        <asp:Label ID="Label1" Text="250 charecters." ForeColor="Red" Font-Size="14px" runat="server"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtAddress" ErrorMessage="address required ">
                                        </asp:RequiredFieldValidator>
                                    </div>

                                </div>
                                <%-- <div class="form-row">
                    <div class="form-group col-lg-12">
                        
                        </div>
                     </div>--%>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>City</label>
                                        <asp:TextBox ID="ddlCity" class="form-control form-control-sm" runat="server">
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="ddlCity" ErrorMessage="city required">
                                        </asp:RequiredFieldValidator>
                                    </div>

                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Pin Code</label>
                                        <asp:TextBox ID="txtpincode" MaxLength="15" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtpincode" ErrorMessage="pincode required">
                                        </asp:RequiredFieldValidator>
                                        <%--<cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender2" TargetControlID="txtpincode"
                                    FilterType="Numbers" InvalidChars=".">
                                </cc1:FilteredTextBoxExtender>--%>
                                        <%--<cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="RegExpValpincode">
                                </cc1:ValidatorCalloutExtender>--%>
                                        <asp:RegularExpressionValidator ValidationGroup="chk94" SetFocusOnError="true"
                                            ID="RegExpValpincode" runat="server" ErrorMessage="required 6 digits"
                                            ControlToValidate="txtpincode" ValidationExpression="^[0-9]{6,6}$" />
                                    </div>
                                </div>
                                <%--<div class="form-row">
                    <div class="form-group col-lg-12">
                       
                    </div>
                </div>--%>
                                <div class="form-row">
                                    <div class="form-group col-lg-12">
                                        <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click" ValidationGroup="chk94" class="btn btn-primary float-right mb-5"
                                            runat="server" Text="Update" />
                                        <asp:Button ID="btnNextDoc" OnClick="btnNextDoc_Click" class="btn btn-primary float-right mb-5" Visible="false"
                                            runat="server" Text="Next" />
                                    </div>
                                </div>

                            </div>

                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnUpDate" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

