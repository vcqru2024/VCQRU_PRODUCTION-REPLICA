<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="frm_UserNotification.aspx.cs" Inherits="Manufacturer_frm_UserNotification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showAlert(title, text, icon) {
            Swal.fire({
                title: title,
                text: text,
                icon: icon,
                confirmButtonText: 'OK'
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

    </script>
    <style>
        .aadhar {
            align-content: center;
            margin-top: 10px;
        }

        .verifyimghide {
            width: 20px;
            height: 20px;
            display: none
        }

        .verifyimgshow {
            width: 20px !important;
            height: 20px !important;
            display: block;
            position: absolute;
            right: 15px;
        }

        .box-data {
            padding: 10px;
            border: 1px solid #ececec;
            border-radius: 10px;
            background: #f5f5f5;
            position: relative;
        }

            .box-data img {
                height: 322px;
                width: 100%;
                border-width: 0px;
                border-radius: 10px;
            }

        .foot-box {
            padding-left: 66px;
            position: relative;
            margin-top: 15px;
        }

            .foot-box .roundedcorners {
                position: absolute;
                left: 0;
            }

            .foot-box span, .foot-box strong {
                font-size: 14px !important;
            }

            .foot-box strong {
                font-weight: 600 !important;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>User Notification</h4>
                        </header>
                        <div class="card-body card-body-nopadding">
                            <div class="form-row">
                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-wizard medias">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-4">
                                        <span class="req">*</span><label>Whom to notify?</label>
                                        <asp:DropDownList ID="ddlProSearch" runat="server" ValidationGroup="chk94" AutoPostBack="true" OnSelectedIndexChanged="ddlProSearch_SelectedIndexChanged" CssClass="form-control form-control-sm">
                                            <asp:ListItem Value="0">All</asp:ListItem>
                                            <asp:ListItem Value="1">Individual Or Multiple</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-4" runat="server" id="Inputmobile" visible="false">
                                        <label>Mobile No.</label>
                                        <asp:TextBox ID="txtMobileNumber" MaxLength="100" class="form-control form-control-sm" runat="server" onkeyup="clearValidationMessages();"></asp:TextBox>
                                        <script type="text/javascript">
                                            function clearValidationMessages() {
                                                // Clear required field validator message
                                                var reqValidator = document.getElementById('<%= RequiredFieldValidator7.ClientID %>');
                                                if (reqValidator) {
                                                    reqValidator.style.display = 'none';  // Hide the validation message
                                                }

                                                // Clear custom validator message
                                                var customValidator = document.getElementById('<%= CustomValidatorMobile.ClientID %>');
                                                if (customValidator) {
                                                    customValidator.style.display = 'none';  // Hide the validation message
                                                }
                                            }
                                        </script>

                                        <span class="warn">For multiple add mobile number seperated by commas</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" Display="Dynamic" ControlToValidate="txtMobileNumber" ErrorMessage="Please enter at least one mobile number">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidatorMobile" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" Display="Dynamic" ControlToValidate="txtMobileNumber" ErrorMessage="All mobile numbers must be exactly 10 digits, separated by commas"
                                            OnServerValidate="ValidateMobileNumbers">
                                        </asp:CustomValidator>
                                    </div>
                                    <div class="form-group col-lg-4">
                                        <label>Choose Image File.</label>
                                        <asp:FileUpload ID="compLogo" runat="server" class="form-control form-control-sm" />
                                        <script type="text/javascript">
                                            function validateFileUpload(sender, args) {
                                                var fileUpload = document.getElementById('<%= compLogo.ClientID %>');
                                                if (fileUpload.value) {
                                                    var validExtensions = [".jpg", ".jpeg", ".png"];
                                                    var fileName = fileUpload.value;
                                                    var fileExtension = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
                                                    if (validExtensions.indexOf(fileExtension) < 0) {
                                                        args.IsValid = false;
                                                        alert("Only image files (.jpg, .jpeg, .png) are allowed.");
                                                    } else {
                                                        args.IsValid = true;
                                                    }
                                                } else {
                                                    args.IsValid = false;
                                                    alert("Please select an image file.");
                                                }
                                            }
                                        </script>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ValidationGroup="chkcompLogo"
                                            ControlToValidate="compLogo" ErrorMessage="Image required" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidatorFileUpload" runat="server" Display="Dynamic"
                                            ControlToValidate="compLogo"
                                            ErrorMessage="Only image files (.jpg, .jpeg, .png) are allowed"
                                            ForeColor="Red"
                                            ClientValidationFunction="validateFileUpload">
                                        </asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <div class="form-row">
                                    <div class="form-group col-lg-6" style="margin-bottom: 1rem;">
                                        <span class="req">*</span><label>Heading</label>
                                        <asp:TextBox ID="txtheader" class="form-control" TextMode="MultiLine" Rows="3"
                                            MaxLength="50" onkeydown="return checkTextAreaMaxLength(this,event,'50');"
                                            runat="server"></asp:TextBox>
                                        <span class="warn">50 characters.</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtheader" ErrorMessage="Please enter header">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-lg-6" style="margin-bottom: 1rem;">
                                        <span class="req">*</span><label>Message</label>
                                        <asp:TextBox ID="txtMessage" class="form-control" TextMode="MultiLine" Rows="3"
                                            MaxLength="250" onkeydown="return checkTextAreaMaxLength(this,event,'250');"
                                            runat="server"></asp:TextBox>
                                        <span class="warn">250 characters.</span>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtMessage" ErrorMessage="Please enter message">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-4">
                                        <span class="req">*</span><label>Valid From</label>
                                        <asp:TextBox ID="txtValidFrom" runat="server" class="form-control form-control-sm" TextMode="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorValidFrom" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtValidFrom" ErrorMessage="Please enter valid from date">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-lg-4">
                                        <span class="req">*</span><label>Valid Till</label>
                                        <asp:TextBox ID="txtValidTill" runat="server" class="form-control form-control-sm" TextMode="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorValidTill" runat="server" ForeColor="Red"
                                            ValidationGroup="chk94" ControlToValidate="txtValidTill" ErrorMessage="Please enter valid till date">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-lg-4 mt-3">
                                        <div class="form-check">
                                            <asp:CheckBox ID="chkActive" runat="server" CssClass="form-check-input" />
                                            <label class="form-check-label" for="chkActive">Active</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row" style="text-align: center;">
                                    <p style="text-align: center;">
                                        <asp:Button ID="btn_download" ValidationGroup="chk94" runat="server" Text="Send Notification" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </p>
                                </div>
                                <br />
                                <br />
                                <div class="table-responsive table_large">
                                    <asp:GridView ID="grd1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                        DataKeyNames="Message_id,Image_Path" EmptyDataText="Record Not Found" BorderColor="transparent"
                                        AllowPaging="false" PageSize="21" Font-Size="Smaller" OnRowEditing="grd1_RowEditing"
                                        OnRowCancelingEdit="grd1_RowCancelingEdit" OnRowUpdating="grd1_RowUpdating">
                                        <Columns>
                                            <asp:CommandField ShowEditButton="True" />

                                            <asp:TemplateField HeaderText="Message ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMessageid" runat="server" Text='<%# Bind("Message_id") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblMessageidEdit" runat="server" Text='<%# Bind("Message_id") %>'></asp:Label>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMobileno" runat="server" Text='<%# Bind("Mobile") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Heading">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHeader" runat="server" Text='<%# Bind("Headers") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Message">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContent" runat="server" Text='<%# Bind("Message") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="File">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDownloadBill" runat="server" OnClick="lnkDownload_Click" ToolTip="Download image file">
                    <img src="../images/download.png" />
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="IsActive">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsRead" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkIsReadEdit" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsActive")) %>' />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Valid From">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblValidfrom" runat="server" Text='<%# Bind("Valid_from", "{0:d}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtValidfromEdit" runat="server" Text='<%# Bind("Valid_from", "{0:yyyy-MM-dd}") %>' TextMode="Date"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Valid Till">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblValidtill" runat="server" Text='<%# Bind("Valid_till", "{0:d}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtValidtillEdit" runat="server" Text='<%# Bind("Valid_till", "{0:yyyy-MM-dd}") %>' TextMode="Date"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

