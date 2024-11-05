<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="AddServiceSettings.aspx.cs" Inherits="Partner_AddServiceSettings" %>


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

            <script>

                function isrange(evt) {

                    if (evt.keyCode >= 48 && evt.keyCode <= 57)
                        return true;
                    if (evt.keyCode == 8)
                        return true;
                    if (evt.keyCode == 45)
                        return true;
                    return false;
                }


                function ValidateGetSubscription(Result) {
                    var Arr = Result.toString().split('*');
                    if (Arr[0] == "true") {
                        document.getElementById("<%=selsrvplanid.ClientID %>").value = Arr[2].toString();
                        document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = Arr[1].toString();
                        //document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        //document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                    else {
                        document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = "Please subscribe service fisrt.";
                        //document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        //document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                }
                function CheckDateExist(val) {
                    var vl = "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
                    if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                        vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
                    PageMethods.checkGetDateIsExist(vl, IsDateFromExist)
                }
                function CheckDateExistNew(val) {
                    var vl = "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
                    if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                        vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
                    PageMethods.checkGetDateIsExistNew(vl, IsDateFromExist)
                }
                function IsDateFromExist(Result) {
                    var Arr = Result.toString().split('*');
                    if (Arr[0] == "true") {
                        document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = Arr[1].toString();
                        document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = "";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                }
            </script>

        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

            <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
            <asp:Label Text="" ID="lblCouponRequest_ID" Visible="false" runat="server" />
            <asp:HiddenField ID="hdnloyalty" runat="server" />
            <asp:HiddenField ID="selsrvid" runat="server" />
            <asp:HiddenField ID="selsrvplanid" runat="server" />
            <asp:HiddenField ID="hhdnCompID" runat="server" />
            <asp:HiddenField ID="hdneditval" runat="server" />
            <asp:HiddenField ID="ActionText" runat="server" />
            <asp:HiddenField ID="IsAct" runat="server" />
            <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
            <asp:HiddenField ID="currindex" runat="server" />
            <asp:HiddenField ID="lblproidamc" runat="server" />
            <%-- <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HiddenField2" runat="server" />
            <asp:HiddenField ID="HiddenField3" runat="server" />--%>

            <asp:HiddenField ID="hdnprizetransid" runat="server" />
            <asp:HiddenField ID="hdnsstid" runat="server" />
            <asp:HiddenField ID="hdnisaddi" runat="server" />
            <asp:HiddenField ID="docflag" runat="server" />
            <asp:HiddenField ID="HdFieldAmcId" runat="server" />
            <asp:HiddenField ID="HdFieldOfferId" runat="server" />
            <asp:HiddenField ID="hdnpointsval" runat="server" />
            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>Add Service Settings</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="#">Our Service</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Add Service Settings</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="user-role-card">
                    <div class="card">
                        <div class="card-body">

<!-- 
                            <div class="mb-3 text-end">
                                <a href="#" class="btn btn-primary btn-sm">Add Product</a>
                            </div> -->


                            <asp:Label ID="lblsrvdtrngmsg" runat="server" ForeColor="Red" Font-Bold="true"
                                Font-Size="10pt"></asp:Label>
                            <asp:Label ID="lblsrvdtfrndto" runat="server" ForeColor="Green" Font-Bold="true"
                                Font-Size="10pt"></asp:Label>

                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                <div class="col">
                                    <label class="form-label">Select Service<span>*</span></label>
                                    <asp:DropDownList ID="ddlService" runat="server" class="form-select"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">

                                        <asp:ListItem Value="--Select--">--Select--</asp:ListItem>
                                        <asp:ListItem Value="SRV1018">COUNTERFIETING</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*"
                                        ForeColor="Red" runat="server" ControlToValidate="ddlService"
                                        ValidationGroup="SRVS" InitialValue="0"></asp:RequiredFieldValidator>
                                </div>


                                <div class="col">
                                    <label for="Product" class="form-label">Product<span>*</span></label>
                                    <asp:DropDownList ID="ddlProduct" runat="server" class="form-select"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <div class="invalid-feedback">Enter valid name.</div>
                                </div>
                                <div class="col">
                                    <label for="DateRange" class="form-label">Date Range<span>*</span></label>
                                    <div class="row">
                                        <div class="col">
                                            <asp:TextBox ID="txtloyaltydtfrom" class="form-control" runat="server"
                                                placeholder="Date From.."
                                                onchange="javascript:CheckDateExist(this.value);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFVIsDateFrom" runat="server"
                                                ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                                ControlToValidate="txtloyaltydtfrom">
                                            </asp:RequiredFieldValidator>

                                        </div>
                                        <div class="col">
                                            <asp:TextBox ID="txtloyaltydtto" class="form-control" runat="server"
                                                onchange="javascript:CheckDateExistNew(this.value);"
                                                placeholder="Date To.."></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server"
                                                ValidationGroup="LOY" ControlToCompare="txtloyaltydtfrom"
                                                ControlToValidate="txtloyaltydtto" ForeColor="Red" Type="Date"
                                                Operator="GreaterThanEqual"
                                                ErrorMessage="Date To must be less than Date From">
                                            </asp:CompareValidator>
                                            <cc1:CalendarExtender ID="CalendarExtender7" runat="server"
                                                TargetControlID="txtloyaltydtfrom" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                                TargetControlID="txtloyaltydtfrom" Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server"
                                                TargetControlID="txtloyaltydtfrom" WatermarkText="Date From..">
                                            </cc1:TextBoxWatermarkExtender>
                                            <cc1:CalendarExtender ID="CalendarExtender8" runat="server"
                                                TargetControlID="txtloyaltydtto" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server"
                                                TargetControlID="txtloyaltydtto" Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server"
                                                TargetControlID="txtloyaltydtto" WatermarkText="Date To..">
                                            </cc1:TextBoxWatermarkExtender>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div id="DivMsg" runat="server">
                                        <asp:Label ID="LblMsgBody" runat="server"></asp:Label>
                                    </div>
                                    <div id="NewMsgpop" runat="server">
                                        <div id="cpn" runat="server"></div>
                                        <asp:Label ID="Label2" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="col ms-auto text-end">

                                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success"
                                        OnClick="btnSave_Click" ValidationGroup="SRVS" Text="Save" />

                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" value="Cancel"
                                        OnClick="btnCancel_Click" Text="Cancel" />
                                </div>





                            </div>
                        </div>
                    </div>


        </asp:Content>