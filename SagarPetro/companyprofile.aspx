<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="companyprofile.aspx.cs" Inherits="Patanjali_companyprofile" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

            <style>
                .ajax__validatorcallout_popup_table {
                    z-index: 1000;
                }

                #ctl00_ContentPlaceHolder1_RequiredFieldValidatorupl4,
                #ctl00_ContentPlaceHolder1_RequiredFieldValidatorupl5 {
                    position: unset;
                    font-size: unset !important;
                }
            </style>

            <script type="text/javascript">
                function checkproduct(vl) {
                    debugger;
                    PageMethods.checkNewProduct(vl, onCompleteProduct)
                }

                function onCompleteProduct(Result) {
                    debugger;
                    if (Result == true) {
                        document.getElementById("lblemail").innerHTML = "Email Id Already exist.";
                        document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                        document.getElementById("<%=btnUpDate.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("lblemail").innerHTML = "";
                        document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                        document.getElementById("<%=btnUpDate.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                }
                function fileTypeCheckeng(mm) {
                    debugger;
                    PageMethods.checkFile(mm, onengcheck)
                }
                function onengcheck(Result) {
                    debugger;
                    if (Result == true) {
                        document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                        document.getElementById("<%=btnUpDate.ClientID %>").disabled = true;
                        document.getElementById("<%=btnUpDate.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                        document.getElementById("<%=btnUpDate.ClientID %>").disabled = false;
                        document.getElementById("<%=btnUpDate.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                }
            </script>


            <!--------tooltip------>
            <!-- jQuery via Google CDN -->

            <script src="../Content/js/tooltip/jquery.min.js" language="javascript" type="text/javascript"></script>

            <!-- Style-my-tooltips plugin script and style_my_tooltips function call with default option parameters -->
            <link href="../Content/js/tooltip/style-my-tooltips.css" rel="stylesheet" type="text/css" />

            <script type="text/javascript" language="javascript"
                src="../Content/js/tooltip/jquery.style-my-tooltips.js"></script>

            <script type="text/javascript" language="javascript">
                jQuery.noConflict();
                (function ($) {
                    $(document).ready(function () {
                        $("[title]").style_my_tooltips({
                            tip_follows_cursor: false, //boolean
                            tip_delay_time: 700, //milliseconds
                            tip_fade_speed: 300 //milliseconds
                        });
                        //dynamically added elements demo function
                        $("a[rel='add new element']").click(function (e) {
                            e.preventDefault();
                            $(this).attr("title", "Add another element").parent().after("<p title='New paragraph title'>This is a new paragraph! Hover to see the title.</p>");
                        });
                    });
                })(jQuery);
            </script>

        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
            <div class="home-section">
                <div class="card card-admin form-wizard profile box_card">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1"
                                runat="server" DisplayAfter="0">
                                <ProgressTemplate>
                                    <div align="center"
                                        style="position: absolute; left: 0; height: 1025px; width: 100%; top: 0px; z-index: 999;"
                                        class="NewmodalBackground">
                                        <div style="margin-top: 300px;" align="center">
                                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                            <span style="color: White;">Please Wait.....<br />
                                            </span>
                                        </div>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>

                            <div class="card-header">
                                <h4 class="card-title">Company Profile</h4>
                            </div>

                            <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="card-body">
                                <div
                                    class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-4">
                                    <div class="col">
                                        <div class="form-group text_boxicon">
                                            <label class="form-label">Company PAN /TAN No<span>*</span></label>
                                            <asp:TextBox ID="txtpantanno" Style='text-transform: uppercase'
                                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                runat="server" MaxLength="10" class="form-control">
                                            </asp:TextBox>
                                            <asp:Image ID="lblremarkspantan" runat="server" CssClass="imgIcon" Text=""
                                                onmouseover="tooltip.pop(this, this.alt)" />
                                            <asp:ImageButton ID="Imgpanverify" CssClass="imgIcon"
                                                Style="color: Black; border-width: 0px; right: 58px;"
                                                ToolTip="Online verification"
                                                ImageUrl="~/Content/images/generated_bill.png"
                                                OnClick="Imgpanverify_Click" runat="server" />
                                            <asp:HiddenField ID="hfIspanverified" runat="server" />
                                            <asp:HiddenField ID="hfIsaadharverified" runat="server" />
                                            <asp:HiddenField ID="hfIsGstverified" runat="server" />
                                            <asp:Label ID="lblpanmsz" runat="server"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl4" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ErrorMessage="its required"
                                                ControlToValidate="txtpantanno"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group text_boxicon">
                                            <label class="form-label">GSTIN No<span>*</span></label>
                                            <asp:TextBox ID="txtvat" runat="server" Style='text-transform: uppercase'
                                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                MaxLength="15" class="form-control"></asp:TextBox>
                                            <asp:Image ID="lblremarksvatno" runat="server" Text="" CssClass="imgIcon"
                                                onmouseover="tooltip.pop(this, this.alt)" />
                                            <asp:ImageButton ID="lnkgstverify" CausesValidation="false"
                                                CssClass="imgIcon" Style="color: Black; border-width: 0px; right: 58px;"
                                                ToolTip="Online verification"
                                                ImageUrl="~/Content/images/generated_bill.png"
                                                OnClick="lnkgstverify_Click" runat="server" />
                                            <asp:Label ID="lblgstmsz" runat="server"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl5" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ErrorMessage="its required"
                                                ControlToValidate="txtvat"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Director's Aadhar No<span>*</span></label>
                                        <asp:TextBox ID="txtaadharnumber"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                            runat="server" MaxLength="12" TextMode="Number" class="form-control">
                                        </asp:TextBox>
                                        </asp:TextBox>
                                        <asp:Image ID="lblremarksAadharno" runat="server" Text="" CssClass="imgIcon"
                                            onmouseover="tooltip.pop(this, this.alt)" />
                                        <asp:ImageButton ID="lnkaadharnumber" CausesValidation="false"
                                            CssClass="imgIcon" Style="color: Black; border-width: 0px; right: 58px;"
                                            ToolTip="Online verification" ImageUrl="~/Content/images/generated_bill.png"
                                            OnClick="Imageaadharverify_Click" runat="server" />
                                        <asp:HiddenField ID="hfaadharnumber" runat="server" />
                                        <asp:Label ID="lblaadharmsz" runat="server"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server"
                                            ForeColor="Red" ValidationGroup="chk94" ErrorMessage="its required"
                                            ControlToValidate="txtaadharnumber"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ValidationGroup="chk94"
                                            ValidationExpression="[0-9]{12}" ControlToValidate="txtaadharnumber"
                                            ID="RegularExpressionValidator1" runat="server"
                                            ErrorMessage="Enter in 12 digit aadhar numbers only !" Display="None"
                                            SetFocusOnError="true"></asp:RegularExpressionValidator>
                                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                                            TargetControlID="RegularExpressionValidator1">
                                        </cc1:ValidatorCalloutExtender>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Company Name <span>*</span></label>
                                            <asp:TextBox ID="txtCompName" MaxLength="50" class="form-control"
                                                runat="server" placeholder="Company Name (Max 50 char)"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ControlToValidate="txtCompName"
                                                ErrorMessage="Please enter company name"></asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4"
                                                TargetControlID="txtCompName" runat="server" FilterMode="InvalidChars"
                                                InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:">
                                            </cc1:FilteredTextBoxExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Category<span>*</span></label>
                                            <asp:DropDownList ID="ddlCategory" runat="server" class="form-select">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                                ForeColor="Red" Style="visibility: visible" ValidationGroup="chk94"
                                                InitialValue="0" ControlToValidate="ddlCategory"
                                                ErrorMessage="Please select category">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group" id="AadharOTP" runat="server" visible="false">
                                            <div class="form-group text_boxicon">
                                                <label class="form-label">OTP<span>*</span></label>
                                                <asp:TextBox ID="txtaadharotp" TextMode="Number"
                                                    oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                    MaxLength="6" type="number" class="form-control" runat="server">
                                                </asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server"
                                                    ForeColor="Red" ValidationGroup="chk94"
                                                    ControlToValidate="txtaadharotp" ErrorMessage="Please enter OTP">
                                                </asp:RequiredFieldValidator>

                                                <asp:ImageButton ID="lnkVerifyOTP" ValidationGroup="ValidateOTP"
                                                    CausesValidation="false" CssClass="imgIcon"
                                                    Style="color: Black; border-width: 0px; right: 58px;"
                                                    ToolTip="Validate OTP"
                                                    ImageUrl="~/Content/images/generated_bill.png"
                                                    OnClick="btnVerifyOTP_Click" runat="server" />

                                                <asp:HiddenField ID="hfRequest_Id" runat="server" />
                                                <asp:Label ID="lblVerifyOTP" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label id="lblemail" class="form-label">Email id<span>*</span></label>
                                            <asp:TextBox ID="txtEmail" MaxLength="50"
                                                onchange="checkproduct(this.value);" class="form-control"
                                                runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ControlToValidate="txtEmail"
                                                ErrorMessage="Please enter Email id">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator891"
                                                runat="server" ControlToValidate="txtEmail" ValidationGroup="1"
                                                ErrorMessage="a@a.com"
                                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Website</label>
                                            <asp:TextBox ID="txtWebSite" MaxLength="50" class="form-control"
                                                runat="server">
                                            </asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator101"
                                                runat="server" ControlToValidate="txtWebSite" ValidationGroup="chk94"
                                                ErrorMessage="Please enter valid website url"
                                                ValidationExpression="(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">State<span>*</span></label>
                                            <asp:DropDownList ID="ddlState"
                                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                                                AutoPostBack="true" class="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" InitialValue="0"
                                                ControlToValidate="ddlState" ErrorMessage="Please select state">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">City<span>*</span></label>
                                            <asp:DropDownList ID="ddlCity" class="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" InitialValue="--Select--"
                                                ControlToValidate="ddlCity" ErrorMessage="Please select city">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Director's Name<span>*</span></label>
                                            <asp:TextBox ID="txtDirectorName" MaxLength="50" class="form-control"
                                                runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94"
                                                ControlToValidate="txtDirectorName"
                                                ErrorMessage="Please enter Director's Name">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender10"
                                                TargetControlID="txtDirectorName" runat="server"
                                                FilterMode="InvalidChars"
                                                InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Director's Father Name<span>*</span></label>
                                            <asp:TextBox ID="txtDirectorFatherName" MaxLength="50" class="form-control"
                                                runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94"
                                                ControlToValidate="txtDirectorFatherName"
                                                ErrorMessage="Please enter Director's Father Name">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender11"
                                                TargetControlID="txtDirectorFatherName" runat="server"
                                                FilterMode="InvalidChars"
                                                InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Person<span>*</span></label>
                                            <asp:TextBox ID="txtPersonName" MaxLength="50" class="form-control"
                                                runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94"
                                                ControlToValidate="txtPersonName" ErrorMessage="Please enter person">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5"
                                                TargetControlID="txtPersonName" runat="server" FilterMode="InvalidChars"
                                                InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                            </cc1:FilteredTextBoxExtender>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Mobile No<span>*</span></label>
                                            <asp:TextBox ID="txtMob"
                                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                MaxLength="10" type="number" class="form-control" runat="server">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ControlToValidate="txtMob"
                                                ErrorMessage="Please enter mobile no">
                                            </asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1"
                                                TargetControlID="txtMob" FilterType="Numbers" InvalidChars=".">
                                            </cc1:FilteredTextBoxExtender>

                                            <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94"
                                                SetFocusOnError="true" ID="RegExpValMobNo" runat="server"
                                                ErrorMessage="Mobile No must be between 10 to 13 number"
                                                ControlToValidate="txtMob" ValidationExpression="^[0-9]{10,13}$" />
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Phone No.</label>
                                        <div class="row g-0">
                                            <div class="col-lg-2">
                                                <asp:TextBox ID="txtPhone0" MaxLength="5" class="form-control "
                                                    Text=" +91" runat="server">
                                                </asp:TextBox>
                                            </div>
                                            <div class="col-lg-5">
                                                <asp:TextBox ID="txtPhone1" MaxLength="5" class="form-control "
                                                    placeholder="STD Code" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-5">
                                                <asp:TextBox ID="txtPhone" MaxLength="8" class="form-control"
                                                    placeholder="Phone No" runat="server"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender2" TargetControlID="txtPhone"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender8" TargetControlID="txtPhone1"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender9" TargetControlID="txtPhone0"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:ValidatorCalloutExtender ID="ValCalloutPhoneNo" runat="server"
                                                    TargetControlID="RegExpValPhoneNo0">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94"
                                                    SetFocusOnError="true" ID="RegExpValPhoneNo0" runat="server"
                                                    ErrorMessage="Country Code must be between 2 to 4 number"
                                                    ControlToValidate="txtPhone0" ValidationExpression="^[0-9]{2,4}$" />
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2"
                                                    runat="server" TargetControlID="RegExpValPhoneNo">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94"
                                                    SetFocusOnError="true" ID="RegExpValPhoneNo" runat="server"
                                                    ErrorMessage="Phone No must be between 6 to 8 number"
                                                    ControlToValidate="txtPhone" ValidationExpression="^[0-9]{6,8}$" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Fax</label>
                                        <div class="row g-0">
                                            <div class="form-group col-lg-2">

                                                <asp:TextBox ID="txtFax0" MaxLength="4" class="form-control " Text="+91"
                                                    runat="server">
                                                </asp:TextBox>
                                            </div>
                                            <div class="form-group col-lg-5">

                                                <asp:TextBox ID="txtFax1" MaxLength="5" class="form-control "
                                                    placeholder="STD Code" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-lg-5">

                                                <asp:TextBox ID="txtFax" MaxLength="10" class="form-control"
                                                    placeholder="Fax No" runat="server"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender3" TargetControlID="txtFax"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender6" TargetControlID="txtFax0"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server"
                                                    ID="FilteredTextBoxExtender7" TargetControlID="txtFax1"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3"
                                                    runat="server" TargetControlID="RegExpValFaxNo0">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94"
                                                    SetFocusOnError="true" ID="RegExpValFaxNo0" runat="server"
                                                    ErrorMessage="Country Code must be between 2 to 4 number"
                                                    ControlToValidate="txtFax0" ValidationExpression="^[0-9]{2,4}$" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Official Address<span>*</span></label>
                                            <asp:TextBox ID="txtAddress" class="form-control" TextMode="MultiLine"
                                                Rows="1" MaxLength="250"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                                runat="server"></asp:TextBox>
                                            <span class="warn">250 characters.</span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94" ControlToValidate="txtAddress"
                                                ErrorMessage="Please enter official address">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Residencial Address<span>*</span></label>
                                            <asp:TextBox ID="txtResiAddress" class="form-control" TextMode="MultiLine"
                                                Rows="1" MaxLength="250"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                                runat="server">
                                            </asp:TextBox>
                                            <span class="warn">250 characters.</span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                                                ForeColor="Red" ValidationGroup="chk94"
                                                ControlToValidate="txtResiAddress"
                                                ErrorMessage="Please enter residence address">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <label class="form-label">Play Sound File</label>
                                            <a id="FileDown" runat="server" title="Play">Play</a>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <div class="label_cosefile">
                                                <asp:FileUpload ID="flSound" onchange="fileTypeCheckeng(this.value);"
                                                    runat="server" />
                                                <asp:Label ID="lblfile" runat="server" CssClass="astrics"></asp:Label>
                                                <asp:RequiredFieldValidator ID="rfvsound" runat="server"
                                                    ValidationGroup="chk94" ControlToValidate="flSound"
                                                    ErrorMessage="its required"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-group">
                                            <div class="label_cosefile">
                                                <asp:FileUpload ID="compLogo" runat="server" />
                                                <asp:Image runat="server" ID="imgLogo"
                                                    Style="width: 124px; height: 110px; display: block" />
                                                <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove Logo"
                                                    OnClick="lnkDelete_Click"></asp:LinkButton>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                                    ValidationGroup="chkcompLogo" ControlToValidate="compLogo"
                                                    ErrorMessage="logo required"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col mb-3">
                                        <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click" ValidationGroup="chk94"
                                            class="btn btn-primary px-5" data-loading-text="Loading..." runat="server"
                                            Text="Update" />
                                    </div>
                                </div>
                                <p>Sound File would be in .mp3 Formate &
                                    Company Logo Should be in (.jpg, .png & .gif). Max Length of Company
                                    Name 20 char.</p>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnUpDate" />
                            <asp:PostBackTrigger ControlID="lnkaadharnumber" />
                            <asp:PostBackTrigger ControlID="lnkVerifyOTP" />
                            <asp:PostBackTrigger ControlID="Imgpanverify" />
                            <asp:PostBackTrigger ControlID="lnkgstverify" />
                            <asp:PostBackTrigger ControlID="ddlState" />

                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </asp:Content>