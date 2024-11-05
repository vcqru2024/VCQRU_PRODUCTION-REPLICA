<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="CompProfile.aspx.cs" Inherits="Manufacturer_CompProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function checkproduct(vl) {
            PageMethods.checkNewProduct(vl, onCompleteProduct)
        }
        function onCompleteProduct(Result) {
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
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
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
                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Company Profile</h4>
                            </header>
                            <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="card-body card-body-nopadding">
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Company Name</label>
                                        <asp:TextBox ID="txtCompName" MaxLength="50" class="form-control form-control-sm" runat="server"
                                            placeholder="Company Name (Max 50 char)"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtCompName" ErrorMessage="Please enter company name"></asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtCompName"
                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:">
                                        </cc1:FilteredTextBoxExtender>
                                    </div>
                                    <div class="form-group col-lg-6 ">
                                        <span class="req">*</span><label>Category</label>
                                        <%--  <input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:DropDownList ID="ddlCategory" runat="server" class="form-control form-control-sm">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" Style="visibility: visible"
                                            ValidationGroup="chk94" InitialValue="0" ControlToValidate="ddlCategory" ErrorMessage="Please select category">
                                        </asp:RequiredFieldValidator>

                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label id="lblemail">Email id</label>
                                        <%--<asp:Label ID="lblemail" Text="" ></asp:Label>--%>
                                        <%--	<input type="email" value="" >--%>
                                        <asp:TextBox ID="txtEmail" MaxLength="50" onchange="checkproduct(this.value);" class="form-control form-control-sm"
                                            runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtEmail" ErrorMessage="Please enter Email id">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                            ControlToValidate="txtEmail" ValidationGroup="1" ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Website</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtWebSite" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator101" runat="server" ControlToValidate="txtWebSite"
                                            ValidationGroup="chk94" ErrorMessage="Please enter valid website url"
                                            ValidationExpression="(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>State</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:DropDownList ID="ddlState" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"
                                            AutoPostBack="true" class="form-control form-control-sm" runat="server">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" InitialValue="0" ControlToValidate="ddlState" ErrorMessage="Please select state">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>City</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:DropDownList ID="ddlCity" class="form-control form-control-sm" runat="server">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" InitialValue="--Select--" ControlToValidate="ddlCity" ErrorMessage="Please select city">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <%--<h6>Contact Info</h6>--%>
                                <div class="form-row">
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Director's Name</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtDirectorName" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtDirectorName" ErrorMessage="Please enter Director's Name">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" TargetControlID="txtDirectorName"
                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                        </cc1:FilteredTextBoxExtender>

                                    </div>

                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Director's Father Name</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtDirectorFatherName" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtDirectorFatherName" ErrorMessage="Please enter Director's Father Name">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" TargetControlID="txtDirectorFatherName"
                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                        </cc1:FilteredTextBoxExtender>

                                    </div>

                                     <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Director's Aadhar No</label>
                                        <%--<input type="number" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtAadharnumber" MaxLength="12" type="number" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtAadharnumber" ErrorMessage="Please Director's Aadhar No">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender12" TargetControlID="txtAadharnumber"
                                            FilterType="Numbers" InvalidChars=".">
                                        </cc1:FilteredTextBoxExtender>
                                        <%--<cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                        </cc1:ValidatorCalloutExtender>--%>
                                        <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                            ID="RegularExpressionValidator1" runat="server" ErrorMessage="Aadhar No must be  12 digit"
                                            ControlToValidate="txtAadharnumber" ValidationExpression="^[0-9]{12}$" />
                                    </div>

                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Person</label>
                                        <%--<input type="text" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtPersonName" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="Please enter person">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="txtPersonName"
                                            runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-,/'/';<>?:1234567890">
                                        </cc1:FilteredTextBoxExtender>

                                    </div>
                                    <div class="form-group col-lg-6">
                                        <span class="req">*</span><label>Mobile No</label>
                                        <%--<input type="number" value="" class="form-control form-control-sm">--%>
                                        <asp:TextBox ID="txtMob" MaxLength="10" type="number" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtMob" ErrorMessage="Please enter mobile no">
                                        </asp:RequiredFieldValidator>
                                        <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtMob"
                                            FilterType="Numbers" InvalidChars=".">
                                        </cc1:FilteredTextBoxExtender>
                                        <%--<cc1:ValidatorCalloutExtender ID="ValCalloutMobNo" runat="server" TargetControlID="RegExpValMobNo">
                                        </cc1:ValidatorCalloutExtender>--%>
                                        <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                            ID="RegExpValMobNo" runat="server" ErrorMessage="Mobile No must be between 10 to 13 number"
                                            ControlToValidate="txtMob" ValidationExpression="^[0-9]{10,13}$" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-lg-6">
                                        <label>Phone No.</label>

                                        <div class="form-row">
                                            <div class="form-group col-lg-2">

                                                <asp:TextBox ID="txtPhone0" MaxLength="5" class="form-control  form-control-sm" Text=" +91"
                                                    runat="server"></asp:TextBox>
                                            </div>

                                            <div class="form-group col-lg-5">
                                                <%--<input type="text" value="" class="form-control  form-control-sm" placeholder="STD Code">--%>
                                                <asp:TextBox ID="txtPhone1" MaxLength="5" class="form-control  form-control-sm" placeholder="STD Code"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-lg-5">
                                                <%--<input type="text" value="">--%>
                                                <asp:TextBox ID="txtPhone" MaxLength="8" class="form-control form-control-sm" placeholder="Phone No"
                                                    runat="server"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender2" TargetControlID="txtPhone"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender8" TargetControlID="txtPhone1"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender9" TargetControlID="txtPhone0"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:ValidatorCalloutExtender ID="ValCalloutPhoneNo" runat="server" TargetControlID="RegExpValPhoneNo0">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValPhoneNo0" runat="server" ErrorMessage="Country Code must be between 2 to 4 number"
                                                    ControlToValidate="txtPhone0" ValidationExpression="^[0-9]{2,4}$" />
                                                <%--<cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="RegExpValPhoneNo1">
                                                </cc1:ValidatorCalloutExtender>--%>
                                                <%--<asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValPhoneNo1" runat="server" ErrorMessage="City Code must be between 2 to 4 number"
                                                    ControlToValidate="txtPhone1" ValidationExpression="^[0-9]{2,4}$" />--%>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="RegExpValPhoneNo">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValPhoneNo" runat="server" ErrorMessage="Phone No must be between 6 to 8 number"
                                                    ControlToValidate="txtPhone" ValidationExpression="^[0-9]{6,8}$" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <label>Fax</label>

                                        <div class="form-row">
                                            <div class="form-group col-lg-2">

                                                <asp:TextBox ID="txtFax0" MaxLength="4" class="form-control  form-control-sm" Text="+91"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-lg-5">
                                                <%--<input type="text" value="" class="form-control  form-control-sm" placeholder="STD Code">--%>
                                                <asp:TextBox ID="txtFax1" MaxLength="5" class="form-control  form-control-sm" placeholder="STD Code"
                                                    runat="server"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-lg-5">
                                                <%--<input type="text" value="" class="form-control form-control-sm" placeholder="Fax No">--%>
                                                <asp:TextBox ID="txtFax" MaxLength="10" class="form-control form-control-sm" placeholder="Fax No"
                                                    runat="server"></asp:TextBox>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender3" TargetControlID="txtFax"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender6" TargetControlID="txtFax0"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender7" TargetControlID="txtFax1"
                                                    FilterType="Numbers" InvalidChars=".">
                                                </cc1:FilteredTextBoxExtender>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="RegExpValFaxNo0">
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValFaxNo0" runat="server" ErrorMessage="Country Code must be between 2 to 4 number"
                                                    ControlToValidate="txtFax0" ValidationExpression="^[0-9]{2,4}$" />
                                                <%--<cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" TargetControlID="RegExpValFaxNo1">
                                                </cc1:ValidatorCalloutExtender>--%>
                                                <%--<asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValFaxNo1" runat="server" ErrorMessage="City Code must be between 2 to 4 number"
                                                    ControlToValidate="txtFax1" ValidationExpression="^[0-9]{2,4}$" />--%>
                                                <%--<cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" TargetControlID="RegExpValFaxNo">
                                                </cc1:ValidatorCalloutExtender>--%>
                                                <%--<asp:RegularExpressionValidator Display="None" ValidationGroup="chk94" SetFocusOnError="true"
                                                    ID="RegExpValFaxNo" runat="server" ErrorMessage="Phone No must be between 6 to 8 number"
                                                    ControlToValidate="txtFax" ValidationExpression="^[0-9]{6,8}$" />--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-6" style="margin-bottom: 1rem;">
                                        <span class="req">*</span><label>Official Address</label>
                                        <%--<textarea class="form-control" rows="3"></textarea>--%>
                                        <asp:TextBox ID="txtAddress" class="form-control" TextMode="MultiLine" Rows="3"
                                            MaxLength="250" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                            runat="server"></asp:TextBox>
                                        <span class="warn">250 characters.</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtAddress" ErrorMessage="Please enter official address">
                                        </asp:RequiredFieldValidator>
                                    </div>

                                    <div class="form-group col-lg-6" style="margin-bottom: 1rem;">
                                        <span class="req">*</span><label>Residencial Address</label>
                                        <%--<textarea class="form-control" rows="3"></textarea>--%>
                                        <asp:TextBox ID="txtResiAddress" class="form-control" TextMode="MultiLine" Rows="3"
                                            MaxLength="250" onkeyDown="return checkTextAreaMaxLength(this,event,'250');"
                                            runat="server"></asp:TextBox>
                                        <span class="warn">250 characters.</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtResiAddress" ErrorMessage="Please enter residence address">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                   
                                </div>
                                <div class="form-row">
                                     <div class="form-group col-lg-3">
                                        <label>Play Sound File:</label>

                                        <ul class="graphic audio_play">
                                            <li><a id="FileDown" runat="server" title="Play" class="sm2_link"></a></li>
                                        </ul>
                                        
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <div class="label_cosefile">
                                     <asp:FileUpload ID="flSound" onchange="fileTypeCheckeng(this.value);" runat="server" />
                                        <asp:Label ID="lblfile" runat="server" CssClass="astrics"></asp:Label>
                                        <asp:RequiredFieldValidator ID="rfvsound" runat="server" ValidationGroup="chk94"
                                            ControlToValidate="flSound" ErrorMessage="its required"></asp:RequiredFieldValidator>
                                            </div>
                                    </div>
                                    <div class="form-group col-lg-3">
                                        <div class="label_cosefile">
                                        <asp:FileUpload ID="compLogo" runat="server" />
                                        <asp:Image runat="server" ID="imgLogo" style="width: 124px;height: 110px; display:block" />
                                        <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove Logo" OnClick="lnkDelete_Click"></asp:LinkButton>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="chkcompLogo"
                                            ControlToValidate="compLogo" ErrorMessage="logo required"></asp:RequiredFieldValidator>
                                           </div>
                                    </div>
                                    <div class="form-group col-lg-2 offset-lg-1">
                                        
                                        <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click" ValidationGroup="chk94" class="btn float-right btn-block btn-primary" Style="color: #0088cc; cursor:pointer" data-loading-text="Loading..."
                                            runat="server" Text="Update" />
                                    </div>
                                    </div>
                                    
                                <div class="form-row">
                                <div class="col-lg-8">
                                        <div class="not_box">
                                       <ul>
                                           <li><span class="notify"></span>* Sound File would be in .mp3 Formate & Company Logo Should be in (.jpg, .png & .gif). Max Length of Company Name 20 char.
                                               </li>
                                           </ul>
                                            </div>
                                    </div>
                                <div class="form-group col-lg-2 offset-md-2">
                                        
                                        
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
         </div>
</asp:Content>

